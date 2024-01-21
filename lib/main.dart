import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl_standalone.dart';

import 'l10n/app_localizations.dart';
import 'src/core/constants.dart';
import 'src/core/extensions.dart';
import 'src/core/routers.dart';
import 'src/core/themes.dart';
import 'src/models/user/app_user.dart';
import 'src/services/implementations/dio_service.dart';
import 'src/services/implementations/in_app_updater_service.dart';
import 'src/services/implementations/local_notifications_service.dart';
import 'src/services/implementations/pedometer_step_counter_service.dart';
import 'src/services/implementations/shared_prefs_service.dart';
import 'src/services/interfaces/http_service.dart';
import 'src/services/interfaces/notifier_service.dart';
import 'src/services/interfaces/step_counter_service.dart';
import 'src/services/interfaces/storage_service.dart';
import 'src/services/interfaces/updater_service.dart';
import 'src/viewmodels/settings/settings_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerSingletonServiceInstances();

  await notifier.initialize();

  await FlutterBackgroundService().configure(
    androidConfiguration: AndroidConfiguration(
      notificationChannelId: muteNotificationsChannelId,
      foregroundServiceNotificationId: stepCountNotificationId,
      initialNotificationContent: 'Loading step count...',
      initialNotificationTitle: 'Walk to earn!',
      isForegroundMode: true,
      onStart: onStart,
    ),
    iosConfiguration: IosConfiguration(
      onBackground: onIosBackground,
      onForeground: onStart,
    ),
  );

  if (Platform.isAndroid) {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
  }

  await FlutterBackgroundService().startService();

  runApp(const ProviderScope(child: AppFrame()));
}

@pragma('vm:entry-point')
Future<void> registerSingletonServiceInstances() async {
  GetIt.I.registerSingleton<StorageService>(await SharedPrefsService.create());
  GetIt.I.registerSingleton<StepCounterService>(PedometerStepCounterService());
  GetIt.I.registerSingleton<NotifierService>(LocalNotifierService());
  GetIt.I.registerSingleton<UpdaterService>(InAppUpdaterService());
  GetIt.I.registerSingleton<HttpService>(DioService());
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance instance) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final l10n = await AppLocalizations.delegate.load(
    Locale((await findSystemLocale()).split('_').first),
  );

  AppUser getCurrentUser() => storage.getAppUser(currentUserKey);

  await registerSingletonServiceInstances();

  await notifier.initialize();

  void showMotivationalNotification() {
    if (storage.getInt(stepCountTodayKey) < getCurrentUser().dailyStepsTarget) {
      if (storage.has(reachedStepsGoalKey)) {
        notifier.cancelNotification(congratsNotificationId);
        storage.remove(reachedStepsGoalKey);
      }

      notifier.showImmediateNotification(
        motivationalNotificationId,
        null,
        l10n.increaseYourStepCount(getCurrentUser().dailyStepsTarget),
        motivationalNotificationPayload,
        true,
      );
    } else if (!storage.has(reachedStepsGoalKey)) {
      storage.setString(reachedStepsGoalKey, '${DateTime.now()}');
      notifier.cancelNotification(motivationalNotificationId).then((_) {
        notifier.showImmediateNotification(
          congratsNotificationId,
          null,
          l10n.congratulationsOnGoal,
          congratsNotificationPayload,
          false,
          true,
        );
      });
    }
  }

  void showHydrationNotification() {
    final currentTime = DateTime.now();
    final currentMinute = currentTime.minute;

    if ([8, 10, 12, 14, 16, 18, 20].contains(currentTime.hour)) {
      if (currentMinute < 2 && !storage.has(showedWaterReminderKey)) {
        storage.setString(showedWaterReminderKey, '$currentTime');
        notifier.showImmediateNotification(
          hydrationNotificationId,
          null,
          l10n.rememberToDrinkWater(getCurrentUser().firstName),
          hydrationNotificationPayload,
          false,
          true,
        );
      } else if (currentMinute >= 2 && storage.has(showedWaterReminderKey)) {
        storage.remove(showedWaterReminderKey);
      }
    } else if (storage.has(showedWaterReminderKey)) {
      storage.remove(showedWaterReminderKey);
    }
  }

  void showStepCountNotification() {
    notifier.showImmediateNotification(
      stepCountNotificationId,
      l10n.walkToEarn,
      '${l10n.stepsTakenToday}: ${storage.getInt(stepCountTodayKey).formatted}',
      stepCountNotificationPayload,
      true,
    );
  }

  void invokeForegroundUpdate() {
    service.invoke('update', {
      hasDoneDailyQuizKey: storage.getBool(hasDoneDailyQuizKey),
      stepCountTodayKey: storage.getInt(stepCountTodayKey),
    });
  }

  void initStepCounting() {
    stepCounter.listen((stepCount) async {
      final lastStepCountSince = storage.getInt(stepCountSinceKey);
      final lastStepCountToday = storage.getInt(stepCountTodayKey);

      var stepCountDelta = stepCount - lastStepCountSince;

      if (stepCount < lastStepCountSince) {
        stepCountDelta = stepCount;
      }

      if (lastStepCountSince == 0) {
        stepCountDelta = 0;
      }

      final newStepCountToday = lastStepCountToday + stepCountDelta;

      await storage.setInt(stepCountTodayKey, newStepCountToday);
      await storage.setInt(stepCountSinceKey, stepCount);

      showStepCountNotification();
      invokeForegroundUpdate();
    });
  }

  if (service is AndroidServiceInstance) {
    service
      ..on('enterForeground').listen((_) => service.setAsForegroundService())
      ..on('enterBackground').listen((_) => service.setAsBackgroundService());
  }

  service
    ..on('subtlyUpdateUser').listen((data) {
      final currentUser = data![currentUserKey];

      if (data[stepCountTodayKey] != null) {
        storage.setInt(stepCountTodayKey, currentUser[stepCountTodayKey]);
      }

      storage.setAppUser(currentUserKey, AppUser.fromJson(currentUser));
      storage.setString(accessTokenKey, data[accessTokenKey]);

      storage.setBool(
        hasDoneDailyQuizKey,
        (currentUser['pointsRecord'] as List).any(
          (data) =>
              DateTime.parse(data['date']).asYyMmDd ==
                  DateTime.now().asYyMmDd &&
              data['quiz'] != null,
        ),
      );
    })
    ..on('initStepCounting').listen((_) {
      invokeForegroundUpdate();
      initStepCounting();
    })
    ..on('stopAndCleanUp').listen((_) {
      notifier.clearNotifications();
      stepCounter.cancel();
      storage.clear();
    });

  initStepCounting();

  Timer.periodic(2.seconds, (_) async {
    final today = DateTime.now().asYyMmDd;

    if (!storage.has(lastMarkedDateKey)) {
      await storage.setString(lastMarkedDateKey, today);
    }

    if (DateTime.parse(today).isAfter(
      DateTime.parse(storage.getString(lastMarkedDateKey)),
    )) {
      await storage.setString(lastMarkedDateKey, today);
      await storage.setBool(hasDoneDailyQuizKey, false);
      await storage.setInt(stepCountTodayKey, 0);

      final user = getCurrentUser();

      notifier.showImmediateNotification(
        reminderNotificationId,
        null,
        l10n.itIsAnotherBeautifulDay(user.firstName, user.dailyStepsTarget),
        reminderNotificationPayload,
        false,
      );
    }

    if (storage.has(accessTokenKey) &&
        (service is! AndroidServiceInstance ||
            await service.isForegroundService())) {
      showMotivationalNotification();
      showHydrationNotification();
      showStepCountNotification();
      invokeForegroundUpdate();
    }
  });

  Timer.periodic(8.seconds, (_) {
    if (storage.has(accessTokenKey)) {
      final stepCountToday = storage.getInt(stepCountTodayKey);
      http.dispatch(
        onNegativeResponse: (response) {
          if (['invalidToken', 'Account disabled, contact support']
              .contains('${response.data}')) {
            if (service is AndroidServiceInstance) {
              service.setAsBackgroundService();
            }

            notifier.clearNotifications();
            stepCounter.cancel();
            storage.clear();

            service.invoke('signOut');
          }
        },
        httpRequest: http.request(
          apiEndpoint: stepEndpoint,
          payload: {
            'token': storage.getString(accessTokenKey),
            'stepGoal': getCurrentUser().dailyStepsTarget,
            'caloriesBurned': stepCountToday * caloriesPerStep,
            'durationInMinutes': stepCountToday * minutesPerStep,
            'distanceInKilometers': stepCountToday * kilometersPerStep,
            'stepsTaken': stepCountToday,
            'date': '${DateTime.now()}',
          },
          method: 'POST',
        ),
        isObvious: false,
      );
    }
  });
}

class AppFrame extends ConsumerStatefulWidget {
  const AppFrame({super.key});

  @override
  ConsumerState<AppFrame> createState() => _AppFrameState();
}

class _AppFrameState extends ConsumerState<AppFrame> {
  @override
  void initState() {
    super.initState();
    updater.checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final appThemeMode = ref.watch(
      settingsViewModel.select((state) => state.themeMode),
    );

    final appLocale = ref.watch(
      settingsViewModel.select((state) => state.locale),
    );

    return MaterialApp.router(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      themeMode: appThemeMode,
      darkTheme: darkTheme,
      locale: appLocale,
      theme: lightTheme,
      title: appTitle,
    );
  }
}
