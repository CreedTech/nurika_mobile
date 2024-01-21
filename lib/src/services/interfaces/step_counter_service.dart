import 'package:get_it/get_it.dart';

typedef StepCountCallback = void Function(int);

abstract class StepCounterService {
  void listen(StepCountCallback onCountStep);
  void cancel();
}

final stepCounter = GetIt.I<StepCounterService>();
