import 'dart:io';

import 'package:in_app_update/in_app_update.dart';

import '../interfaces/updater_service.dart';

class InAppUpdaterService implements UpdaterService {
  @override
  void checkForUpdate() async {
    try {
      if (Platform.isAndroid &&
          const bool.fromEnvironment('dart.vm.product') &&
          (await InAppUpdate.checkForUpdate()).updateAvailability ==
              UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate();
      }
    } finally {}
  }
}
