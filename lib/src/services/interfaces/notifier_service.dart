import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:timezone/timezone.dart';

typedef OnNotificationCallback = void Function(String?);

abstract class NotifierService {
  StreamSubscription<String?> listen(OnNotificationCallback onNotification);

  Future<void> cancelNotification(int id, {String? tag});

  Future<void> showImmediateNotification(
    int id,
    String? title,
    String? message,
    String? payload,
    bool isPersistent, [
    bool isAudible = false,
  ]);

  Future<void> scheduleNotification(
    int id,
    String? title,
    String? message,
    String? payload,
    TZDateTime dateTime,
  );

  Future<void> clearNotifications();

  Future<bool?> initialize();
}

final notifier = GetIt.I<NotifierService>();
