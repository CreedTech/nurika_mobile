import 'package:get_it/get_it.dart';

import '../../models/api/api_response.dart';

typedef ApiResponseCallback = void Function(ApiResponse);

const stagingBaseApiUrl = 'https://nurika-staging.onrender.com/api/v1';
const productionBaseApiUrl = 'https://api.nurika.engineering/api/v1';
const deleteAccountEndpoint = '$profileEndpoint/delete-account';
const changePasswordEndpoint = '/change-password';
const resetPasswordEndpoint = '/reset-password';
const verifyEmailEndpoint = '/verify-email';
const leaderboardEndpoint = '/leaderboard';
const answerQuizEndpoint = '/quiz/answer';
const dailyQuizEndpoint = '/quiz/today';
const sendOtpEndpoint = '/send-otp';
const profileEndpoint = '/profile';
const signInEndpoint = '/signin';
const signUpEndpoint = '/signup';
const stepEndpoint = '/step';

abstract class HttpService {
  Future<bool> dispatch({
    required Future<ApiResponse> httpRequest,
    ApiResponseCallback? onPositiveResponse,
    ApiResponseCallback? onNegativeResponse,
    bool isObvious = true,
  });

  Future<ApiResponse> request({
    required String apiEndpoint,
    Map<String, dynamic>? headers,
    Object? payload,
    String? method,
  });
}

final http = GetIt.I<HttpService>();
