// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  bool get isSendingCode => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  bool get didForgetPassword => throw _privateConstructorUsedError;
  AppUser get currentUser => throw _privateConstructorUsedError;
  String get referralCode => throw _privateConstructorUsedError;
  String get emailAddress => throw _privateConstructorUsedError;
  String get accessToken => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get base64Dp => throw _privateConstructorUsedError;
  String get otpCode => throw _privateConstructorUsedError;
  int get timeLeft => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call(
      {bool isSendingCode,
      bool isProcessing,
      bool didForgetPassword,
      AppUser currentUser,
      String referralCode,
      String emailAddress,
      String accessToken,
      String firstName,
      String lastName,
      String password,
      String base64Dp,
      String otpCode,
      int timeLeft});

  $AppUserCopyWith<$Res> get currentUser;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSendingCode = null,
    Object? isProcessing = null,
    Object? didForgetPassword = null,
    Object? currentUser = null,
    Object? referralCode = null,
    Object? emailAddress = null,
    Object? accessToken = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? password = null,
    Object? base64Dp = null,
    Object? otpCode = null,
    Object? timeLeft = null,
  }) {
    return _then(_value.copyWith(
      isSendingCode: null == isSendingCode
          ? _value.isSendingCode
          : isSendingCode // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      didForgetPassword: null == didForgetPassword
          ? _value.didForgetPassword
          : didForgetPassword // ignore: cast_nullable_to_non_nullable
              as bool,
      currentUser: null == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as AppUser,
      referralCode: null == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String,
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      base64Dp: null == base64Dp
          ? _value.base64Dp
          : base64Dp // ignore: cast_nullable_to_non_nullable
              as String,
      otpCode: null == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String,
      timeLeft: null == timeLeft
          ? _value.timeLeft
          : timeLeft // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res> get currentUser {
    return $AppUserCopyWith<$Res>(_value.currentUser, (value) {
      return _then(_value.copyWith(currentUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
          _$AuthStateImpl value, $Res Function(_$AuthStateImpl) then) =
      __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isSendingCode,
      bool isProcessing,
      bool didForgetPassword,
      AppUser currentUser,
      String referralCode,
      String emailAddress,
      String accessToken,
      String firstName,
      String lastName,
      String password,
      String base64Dp,
      String otpCode,
      int timeLeft});

  @override
  $AppUserCopyWith<$Res> get currentUser;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
      _$AuthStateImpl _value, $Res Function(_$AuthStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSendingCode = null,
    Object? isProcessing = null,
    Object? didForgetPassword = null,
    Object? currentUser = null,
    Object? referralCode = null,
    Object? emailAddress = null,
    Object? accessToken = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? password = null,
    Object? base64Dp = null,
    Object? otpCode = null,
    Object? timeLeft = null,
  }) {
    return _then(_$AuthStateImpl(
      isSendingCode: null == isSendingCode
          ? _value.isSendingCode
          : isSendingCode // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      didForgetPassword: null == didForgetPassword
          ? _value.didForgetPassword
          : didForgetPassword // ignore: cast_nullable_to_non_nullable
              as bool,
      currentUser: null == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as AppUser,
      referralCode: null == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String,
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      base64Dp: null == base64Dp
          ? _value.base64Dp
          : base64Dp // ignore: cast_nullable_to_non_nullable
              as String,
      otpCode: null == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String,
      timeLeft: null == timeLeft
          ? _value.timeLeft
          : timeLeft // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl(
      {required this.isSendingCode,
      required this.isProcessing,
      required this.didForgetPassword,
      required this.currentUser,
      required this.referralCode,
      required this.emailAddress,
      required this.accessToken,
      required this.firstName,
      required this.lastName,
      required this.password,
      required this.base64Dp,
      required this.otpCode,
      required this.timeLeft});

  @override
  final bool isSendingCode;
  @override
  final bool isProcessing;
  @override
  final bool didForgetPassword;
  @override
  final AppUser currentUser;
  @override
  final String referralCode;
  @override
  final String emailAddress;
  @override
  final String accessToken;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String password;
  @override
  final String base64Dp;
  @override
  final String otpCode;
  @override
  final int timeLeft;

  @override
  String toString() {
    return 'AuthState(isSendingCode: $isSendingCode, isProcessing: $isProcessing, didForgetPassword: $didForgetPassword, currentUser: $currentUser, referralCode: $referralCode, emailAddress: $emailAddress, accessToken: $accessToken, firstName: $firstName, lastName: $lastName, password: $password, base64Dp: $base64Dp, otpCode: $otpCode, timeLeft: $timeLeft)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.isSendingCode, isSendingCode) ||
                other.isSendingCode == isSendingCode) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.didForgetPassword, didForgetPassword) ||
                other.didForgetPassword == didForgetPassword) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.base64Dp, base64Dp) ||
                other.base64Dp == base64Dp) &&
            (identical(other.otpCode, otpCode) || other.otpCode == otpCode) &&
            (identical(other.timeLeft, timeLeft) ||
                other.timeLeft == timeLeft));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isSendingCode,
      isProcessing,
      didForgetPassword,
      currentUser,
      referralCode,
      emailAddress,
      accessToken,
      firstName,
      lastName,
      password,
      base64Dp,
      otpCode,
      timeLeft);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState(
      {required final bool isSendingCode,
      required final bool isProcessing,
      required final bool didForgetPassword,
      required final AppUser currentUser,
      required final String referralCode,
      required final String emailAddress,
      required final String accessToken,
      required final String firstName,
      required final String lastName,
      required final String password,
      required final String base64Dp,
      required final String otpCode,
      required final int timeLeft}) = _$AuthStateImpl;

  @override
  bool get isSendingCode;
  @override
  bool get isProcessing;
  @override
  bool get didForgetPassword;
  @override
  AppUser get currentUser;
  @override
  String get referralCode;
  @override
  String get emailAddress;
  @override
  String get accessToken;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get password;
  @override
  String get base64Dp;
  @override
  String get otpCode;
  @override
  int get timeLeft;
  @override
  @JsonKey(ignore: true)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
