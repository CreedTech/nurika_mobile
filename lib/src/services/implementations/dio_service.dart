import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl_standalone.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../l10n/app_localizations.dart';
import '../../core/extensions.dart';
import '../../models/api/api_response.dart';
import '../interfaces/http_service.dart';

class DioService implements HttpService {
  DioService() {
    findSystemLocale().then(
      (locale) => AppLocalizations.delegate
          .load(Locale(locale.split('_').first))
          .then((value) => _l10n = value),
    );
  }

  late final AppLocalizations _l10n;

  late final _dio = Dio(
    BaseOptions(
      baseUrl: productionBaseApiUrl,
      contentType: Headers.jsonContentType,
      validateStatus: (code) => code != null && code < 500,
      connectTimeout: 32.seconds,
      receiveTimeout: 32.seconds,
      sendTimeout: 32.seconds,
    ),
  )..interceptors.add(
      PrettyDioLogger(
        logPrint: (stuff) => log('$stuff'),
        requestHeader: true,
        requestBody: true,
        maxWidth: 65536,
      ),
    );

  @override
  Future<bool> dispatch({
    required Future<ApiResponse> httpRequest,
    ApiResponseCallback? onPositiveResponse,
    ApiResponseCallback? onNegativeResponse,
    bool isObvious = true,
  }) async {
    try {
      final response = await httpRequest;

      if (response.isPositive) {
        onPositiveResponse?.call(response);
        return true;
      }

      onNegativeResponse?.call(response);

      if (isObvious &&
          response.data is String &&
          '${response.data}'.isNotEmpty) {
        Fluttertoast.showToast(msg: response.data);
      }

      return false;
    } on DioException catch (exception) {
      if (isObvious) {
        switch (exception.type) {
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.connectionError:
          case DioExceptionType.connectionTimeout:
            Fluttertoast.showToast(msg: _l10n.poorInternetConnection);
            break;

          case DioExceptionType.cancel:
            Fluttertoast.showToast(msg: _l10n.requestWasCancelled);
            break;

          default:
            Fluttertoast.showToast(msg: _l10n.anErrorOccurred);
            break;
        }
      }

      return false;
    }
  }

  @override
  Future<ApiResponse> request({
    required String apiEndpoint,
    Map<String, dynamic>? headers,
    Object? payload,
    String? method,
  }) async {
    final response = await _dio.request(
      apiEndpoint,
      options: Options(method: method ?? 'GET', headers: headers),
      data: payload,
    );

    return ApiResponse.fromJson(response.data);
  }
}
