import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants.dart';
import '../../core/extensions.dart';
import '../../models/user/app_user.dart';
import '../../services/interfaces/http_service.dart';
import '../../services/interfaces/storage_service.dart';
import '../dashboard/dashboard_view_model.dart';

part 'auth_view_model.freezed.dart';
part 'auth_view_model.g.dart';

@riverpod
class Auth extends _$Auth {
  Timer? _resendTimer;

  @override
  AuthState build() {
    ref.onDispose(() => _resendTimer?.cancel());
    return AuthState(
      accessToken: storage.getString(accessTokenKey),
      currentUser: storage.getAppUser(currentUserKey),
      didForgetPassword: false,
      isSendingCode: false,
      isProcessing: false,
      referralCode: '',
      emailAddress: '',
      firstName: '',
      password: '',
      lastName: '',
      base64Dp: '',
      timeLeft: 0,
      otpCode: '',
    );
  }

  void _startResendCountdown() {
    update(timeLeft: 119);

    _resendTimer?.cancel();

    _resendTimer = Timer.periodic(1000.milliseconds, (timer) {
      if (state.timeLeft >= 0) {
        update(timeLeft: state.timeLeft - 1);
      } else {
        timer.cancel();
      }
    });
  }

  Future<bool> sendVerificationCode() async {
    update(isSendingCode: true);

    final didResendCode = await http.dispatch(
      onPositiveResponse: (_) => _startResendCountdown(),
      httpRequest: http.request(
        payload: {'email': state.emailAddress},
        apiEndpoint: sendOtpEndpoint,
        method: 'POST',
      ),
    );

    update(isSendingCode: false);

    return didResendCode;
  }

  Future<bool> fetchCurrentUserData() async {
    update(isProcessing: true);

    final didFetchUser = await http.dispatch(
      onPositiveResponse: (response) {
        final cachedFirstName = state.currentUser.firstName;
        final data = response.data;

        update(
          currentUser: AppUser.fromJson({
            'referrals': data['referralInsights']['referrals'],
            'stepsRecord': data['stepInsights']['stepsLastFourteenDays'],
            'dailyStepsTarget': data['steps'][0]['stepGoal'],
            'stepCountToday': data['steps'][0]['stepsTaken'],
            'userTypeIndex': data['referralLevel'],
            'pointsRecord': data['pointInsights'],
            'totalPoints': data['totalPoints'],
            ...response.data['profile'],
          }),
        );

        FlutterBackgroundService().invoke('subtlyUpdateUser', {
          stepCountTodayKey: cachedFirstName.isNotEmpty ? null : 0,
          currentUserKey: state.currentUser,
          accessTokenKey: state.accessToken,
        });
      },
      httpRequest: http.request(
        apiEndpoint: profileEndpoint,
        payload: {'token': state.accessToken},
        method: 'POST',
      ),
      isObvious: false,
    );

    update(isProcessing: false);

    return didFetchUser;
  }

  Future<bool> saveProfileChanges() async {
    update(isProcessing: true);

    final didSaveChanges = await http
        .dispatch(
          httpRequest: http.request(
            apiEndpoint: profileEndpoint,
            payload: FormData.fromMap({
              if (state.base64Dp.isNotEmpty)
                'profileImage': MultipartFile.fromBytes(
                  base64Decode(state.base64Dp),
                  contentType: Headers.jsonMimeType,
                  filename: 'profile_image.jpg',
                ),
              'dateOfBirth': state.currentUser.dateOfBirth,
              'heightUnit': state.currentUser.heightUnit,
              'weightUnit': state.currentUser.weightUnit,
              'bodyHeight': state.currentUser.bodyHeight,
              'bodyWeight': state.currentUser.bodyWeight,
              'firstName': state.currentUser.firstName,
              'lastName': state.currentUser.lastName,
              'gender': state.currentUser.gender,
              'token': state.accessToken,
            }),
            method: 'PUT',
          ),
        )
        .then((_) => fetchCurrentUserData());

    update(isProcessing: false);

    return didSaveChanges;
  }

  Future<bool> resetPassword() async {
    update(isProcessing: true);

    final didResetPassword = await http.dispatch(
      onPositiveResponse: (_) {
        update(didForgetPassword: false, otpCode: '');
      },
      httpRequest: http.request(
        apiEndpoint: resetPasswordEndpoint,
        payload: {
          'email': state.emailAddress,
          'password': state.password,
          'otp': state.otpCode,
        },
        method: 'POST',
      ),
    );

    update(isProcessing: false);

    return didResetPassword;
  }

  Future<bool> deleteAccount() async {
    update(isProcessing: true);

    final didDeleteAccount = await http.dispatch(
      onPositiveResponse: (response) {
        Fluttertoast.showToast(msg: response.data);
        update(accessToken: '');
      },
      httpRequest: http.request(
        apiEndpoint: deleteAccountEndpoint,
        payload: {'token': state.accessToken},
        method: 'DELETE',
      ),
    );

    if (didDeleteAccount) {
      FlutterBackgroundService()
        ..invoke('enterBackground')
        ..invoke('stopAndCleanUp');

      await storage.clear().then((_) => ref.invalidate(dashboardViewModel));
    }

    update(isProcessing: false);

    return didDeleteAccount;
  }

  Future<bool> verifyCode() async {
    update(isProcessing: true);

    final didVerifyCode = await http.dispatch(
      httpRequest: http.request(
        payload: {'email': state.emailAddress, 'otp': state.otpCode},
        apiEndpoint: verifyEmailEndpoint,
        method: 'POST',
      ),
      isObvious: false,
    );

    update(isProcessing: false);

    return didVerifyCode;
  }

  Future<bool> signOut() async {
    update(isProcessing: true, accessToken: '');

    FlutterBackgroundService()
      ..invoke('enterBackground')
      ..invoke('stopAndCleanUp');

    final didSignOut = await storage.clear().then((_) {
      ref.invalidate(dashboardViewModel);
      return true;
    });

    update(isProcessing: false);

    return didSignOut;
  }

  Future<bool> signIn() async {
    update(isProcessing: true);

    final didSignIn = await http
        .dispatch(
          onPositiveResponse: (response) {
            update(accessToken: response.data['token']);
          },
          httpRequest: http.request(
            payload: {'email': state.emailAddress, 'password': state.password},
            apiEndpoint: signInEndpoint,
            method: 'POST',
          ),
        )
        .then((didSucceed) async => didSucceed && await fetchCurrentUserData());

    if (!didSignIn) {
      state = state.copyWith(accessToken: '');
      await storage.remove(accessTokenKey);
    }

    update(isProcessing: false);

    return didSignIn;
  }

  Future<bool> signUp() async {
    update(isProcessing: true);

    final didSignUp = await http.dispatch(
      onPositiveResponse: (_) => _startResendCountdown(),
      httpRequest: http.request(
        apiEndpoint: signUpEndpoint,
        payload: {
          'email': state.emailAddress,
          'referral': state.referralCode,
          'firstName': state.firstName,
          'lastName': state.lastName,
          'password': state.password,
        },
        method: 'POST',
      ),
    );

    update(isProcessing: false);

    return didSignUp;
  }

  void update({
    bool? isSendingCode,
    bool? isProcessing,
    bool? didForgetPassword,
    AppUser? currentUser,
    String? referralCode,
    String? emailAddress,
    String? accessToken,
    String? firstName,
    String? lastName,
    String? password,
    String? base64Dp,
    String? otpCode,
    int? timeLeft,
  }) {
    state = state.copyWith(
      didForgetPassword: didForgetPassword ?? state.didForgetPassword,
      referralCode: referralCode ?? state.referralCode,
      emailAddress: emailAddress ?? state.emailAddress,
      isProcessing: isProcessing ?? state.isProcessing,
      isSendingCode: isSendingCode ?? state.isSendingCode,
      currentUser: currentUser ?? state.currentUser,
      accessToken: accessToken ?? state.accessToken,
      firstName: firstName ?? state.firstName,
      lastName: lastName ?? state.lastName,
      password: password ?? state.password,
      timeLeft: timeLeft ?? state.timeLeft,
      base64Dp: base64Dp ?? state.base64Dp,
      otpCode: otpCode ?? state.otpCode,
    );

    if (currentUser != null) {
      storage.setAppUser(currentUserKey, currentUser);
    }

    if (accessToken != null) {
      storage.setString(accessTokenKey, accessToken);
    }
  }
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required bool isSendingCode,
    required bool isProcessing,
    required bool didForgetPassword,
    required AppUser currentUser,
    required String referralCode,
    required String emailAddress,
    required String accessToken,
    required String firstName,
    required String lastName,
    required String password,
    required String base64Dp,
    required String otpCode,
    required int timeLeft,
  }) = _AuthState;
}
