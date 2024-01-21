import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants.dart';
import '../../core/extensions.dart';
import '../../models/quiz/daily_quiz.dart';
import '../../services/interfaces/http_service.dart';
import '../../services/interfaces/storage_service.dart';

part 'dashboard_view_model.freezed.dart';
part 'dashboard_view_model.g.dart';

@riverpod
class Dashboard extends _$Dashboard {
  @override
  DashboardState build() {
    512.milliseconds.schedule(_fetchDailyQuizData);
    return DashboardState(
      dailyQuiz: DailyQuiz.fromJson(storage.getHashMap(dailyQuizKey)),
      hasDoneDailyQuiz: storage.getBool(hasDoneDailyQuizKey),
      stepCountToday: storage.getInt(stepCountTodayKey),
      tabIndex: 0,
    );
  }

  void _fetchDailyQuizData() async {
    while (true) {
      if (storage.has(accessTokenKey) && state.dailyQuiz.hasExpired) {
        await http.dispatch(
          onPositiveResponse: (response) {
            update(dailyQuiz: DailyQuiz.fromJson(response.data));
          },
          httpRequest: http.request(
            payload: {'token': storage.getString(accessTokenKey)},
            apiEndpoint: dailyQuizEndpoint,
            method: 'POST',
          ),
          isObvious: false,
        );
      }

      await 8.seconds.delay;
    }
  }

  void tuneInToBackgroundService() async {
    final backgroundServiceRef = FlutterBackgroundService();

    final permissions = await [
      Permission.activityRecognition,
      Permission.notification,
    ].request();

    if (permissions.values.every((status) => status.isGranted)) {
      if (!await backgroundServiceRef.isRunning()) {
        await backgroundServiceRef.startService();
      }

      backgroundServiceRef
        ..invoke('enterForeground')
        ..invoke('initStepCounting')
        ..on('update').listen((data) {
          update(
            hasDoneDailyQuiz: data![hasDoneDailyQuizKey],
            stepCountToday: data[stepCountTodayKey],
          );
        });
    }
  }

  void update({
    DailyQuiz? dailyQuiz,
    bool? hasDoneDailyQuiz,
    int? stepCountToday,
    int? tabIndex,
  }) {
    state = state.copyWith(
      hasDoneDailyQuiz: hasDoneDailyQuiz ?? state.hasDoneDailyQuiz,
      tabIndex: tabIndex ?? state.tabIndex,
      stepCountToday: stepCountToday ?? state.stepCountToday,
      dailyQuiz: dailyQuiz ?? state.dailyQuiz,
    );

    if (hasDoneDailyQuiz != null) {
      storage.setBool(hasDoneDailyQuizKey, hasDoneDailyQuiz);
    }

    if (stepCountToday != null) {
      storage.setInt(stepCountTodayKey, stepCountToday);
    }

    if (dailyQuiz != null) {
      storage.setHashMap(dailyQuizKey, dailyQuiz);
    }
  }
}

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    required DailyQuiz dailyQuiz,
    required bool hasDoneDailyQuiz,
    required int stepCountToday,
    required int tabIndex,
  }) = _DashboardState;
}
