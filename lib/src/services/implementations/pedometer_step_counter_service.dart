import 'dart:async';

import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../interfaces/step_counter_service.dart';

class PedometerStepCounterService implements StepCounterService {
  late StreamSubscription<int> streamSubscription;

  late var isActive = false;

  @override
  void listen(StepCountCallback onCountStep) async {
    if (await Permission.activityRecognition.isGranted && !isActive) {
      streamSubscription = Pedometer.stepCountStream
          .throttleTime(const Duration(seconds: 1))
          .map((data) => data.steps)
          .listen(onCountStep);

      isActive = true;
    }
  }

  @override
  void cancel() async {
    await streamSubscription.cancel();
    isActive = false;
  }
}
