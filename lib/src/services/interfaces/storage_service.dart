import 'package:get_it/get_it.dart';

import '../../models/user/app_user.dart';

abstract class StorageService {
  Future<bool> setHashMap(String key, Object value);
  Future<bool> setAppUser(String key, AppUser value);

  Future<bool> setStringList(String key, List<String> value);
  Future<bool> setString(String key, String value);
  Future<bool> setDouble(String key, double value);
  Future<bool> setBool(String key, bool value);
  Future<bool> setInt(String key, int value);

  AppUser getAppUser(String key, [AppUser fallback]);
  Map<String, dynamic> getHashMap(String key, [Map fallback]);

  List<String> getStringList(String key, [List<String> fallback]);
  String getString(String key, [String fallback]);
  double getDouble(String key, [double fallback]);
  bool getBool(String key, [bool fallback]);
  int getInt(String key, [int fallback]);

  Future<bool> remove(String key);
  Future<bool> clear();

  bool has(String key);
}

final storage = GetIt.I<StorageService>();
