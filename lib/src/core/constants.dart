import 'package:flutter/material.dart';

// Data
const languageNames = {'en': 'English', 'fr': 'Français', 'es': 'Español'};
const heightUnits = ['cm', 'in'];
const weightUnits = ['kg', 'lb'];

// Links
const termsOfServiceLink = 'https://nurika-health.gitbook.io/terms-of-service';
const privacyPolicyLink = 'https://nurika-health.gitbook.io/privacy-policy';
const helpCenterLink = 'https://nurika.health/help-centre';
const feedUsBackLink = 'mailto:support@nurika.health';
const socialLinks = [
  'https://twitter.com/nurikahealth',
  'https://facebook.com/nurikahealth',
  'https://t.me/nurikahealth',
  'https://youtube.com/@nurikahealth',
  'https://nurikahealth.medium.com',
  'https://linkedin.com/company/nurikahealth',
  'https://instagram.com/nurikahealth',
];

// Material
const unscrollableScrollPhysics = NeverScrollableScrollPhysics();
const bouncingScrollPhysics = BouncingScrollPhysics();
const transparent = Color(0x00000000);
const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);
const green = Color(0xFF00FF00);
const blue = Color(0xFF0000FF);
const red = Color(0xFFFF0000);

// Notifications
const motivationalNotificationPayload = 'Payload For Motivational Notification';
const notificationsChannelDescription = 'Channel For Nurika App Notifications';
const muteNotificationsChannelName = 'Nurika App Mute Notifications Channel';
const loudNotificationsChannelName = 'Nurika App Loud Notifications Channel';
const stepCountNotificationPayload = 'Payload For Step Count Notification';
const hydrationNotificationPayload = 'Payload For Hydration Notification';
const reminderNotificationPayload = 'Payload For Reminder Notification';
const congratsNotificationPayload = 'Payload For Congrats Notification';
const loudNotificationsChannelId = '$appId.notifications.loud';
const muteNotificationsChannelId = '$appId.notifications.mute';
const motivationalNotificationId = 16;
const stepCountNotificationId = 32;
const hydrationNotificationId = 64;
const reminderNotificationId = 128;
const congratsNotificationId = 256;

// App Details
const appId = 'health.nurika.app';
const invitationUrl = 'https://nurika.health/mobile-apps';
const appTitle = 'Nurika';

// Storage
const showedWaterReminderKey = 'showedWaterReminder';
const reachedStepsGoalKey = 'reachedStepsGoal';
const hasDoneDailyQuizKey = 'hasDoneDailyQuiz';
const leaderboardUsersKey = 'leaderboardUsers';
const themeModeIndexKey = 'themeModeIndex';
const stepCountTodayKey = 'stepCountToday';
const stepCountSinceKey = 'stepCountSince';
const lastMarkedDateKey = 'lastMarkedDate';
const languageCodeKey = 'languageCode';
const currentUserKey = 'currentUser';
const accessTokenKey = 'accessToken';
const dailyQuizKey = 'dailyQuiz';

// Factors
const dailyStepsTargetIncrement = 500;
const kilometersPerStep = 0.0008;
const caloriesPerStep = 0.200;
const minutesPerStep = 1 / 60;

// Limits
const maximumDailyStepsTarget = 15000;
const minimumDailyStepsTarget = 5000;
const dailyQuizPoints = 10;
const designHeight = 928.0;
const designWidth = 428.0;
const codeLength = 6;
