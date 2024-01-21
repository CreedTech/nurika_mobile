import 'package:get_it/get_it.dart';

abstract class UpdaterService {
  void checkForUpdate();
}

final updater = GetIt.I<UpdaterService>();
