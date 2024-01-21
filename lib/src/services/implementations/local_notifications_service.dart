import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart';

import '../../core/constants.dart';
import '../interfaces/notifier_service.dart';

class LocalNotifierService implements NotifierService {
  late final _plugin = FlutterLocalNotificationsPlugin();
  late final _subject = BehaviorSubject<String?>();

  @override
  StreamSubscription<String?> listen(OnNotificationCallback onNotification) =>
      _subject.listen(onNotification);

  @override
  Future<void> clearNotifications() => _plugin.cancelAll();

  @override
  Future<void> cancelNotification(int id, {String? tag}) =>
      _plugin.cancel(id, tag: tag);

  @override
  Future<void> showImmediateNotification(
    int id,
    String? title,
    String? message,
    String? payload,
    bool isPersistent, [
    bool isAudible = false,
  ]) {
    return _plugin.show(
      id,
      title,
      message,
      NotificationDetails(
        android: AndroidNotificationDetails(
          isAudible ? loudNotificationsChannelId : muteNotificationsChannelId,
          isAudible
              ? loudNotificationsChannelName
              : muteNotificationsChannelName,
          channelDescription: notificationsChannelDescription,
          styleInformation: BigTextStyleInformation(
            message!,
            contentTitle: title,
          ),
          autoCancel: !isPersistent,
          showWhen: !isPersistent,
          ongoing: isPersistent,
        ),
        iOS: DarwinNotificationDetails(
          interruptionLevel:
              isAudible ? InterruptionLevel.active : InterruptionLevel.passive,
          presentBanner: isAudible,
          presentAlert: isAudible,
          presentSound: isAudible,
        ),
      ),
      payload: payload,
    );
  }

  @override
  Future<void> scheduleNotification(
    int id,
    String? title,
    String? message,
    String? payload,
    TZDateTime dateTime,
  ) {
    return _plugin.zonedSchedule(
      id,
      title,
      message,
      dateTime,
      NotificationDetails(
        iOS: const DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          loudNotificationsChannelId,
          loudNotificationsChannelName,
          channelDescription: notificationsChannelDescription,
          styleInformation: BigTextStyleInformation(
            message!,
            contentTitle: title,
          ),
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  @override
  Future<bool?> initialize() {
    return _plugin.initialize(
      InitializationSettings(
        android: const AndroidInitializationSettings('ic_bg_service_small'),
        iOS: DarwinInitializationSettings(
          onDidReceiveLocalNotification: (id, title, body, payload) {},
        ),
      ),
      onDidReceiveNotificationResponse: (response) {
        _subject.add(response.payload);
      },
    ).then((didInitialize) async {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              muteNotificationsChannelId,
              muteNotificationsChannelName,
              description: notificationsChannelDescription,
              importance: Importance.low,
            ),
          );

      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              loudNotificationsChannelId,
              loudNotificationsChannelName,
              description: notificationsChannelDescription,
              importance: Importance.high,
            ),
          );

      return didInitialize;
    });
  }
}
