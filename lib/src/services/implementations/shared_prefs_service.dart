import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user/app_user.dart';
import '../interfaces/storage_service.dart';

class SharedPrefsService implements StorageService {
  SharedPrefsService._(this._database);

  static SharedPrefsService? _instance;

  late final SharedPreferences _database;

  static Future<SharedPrefsService> create() async =>
      _instance ??= SharedPrefsService._(await SharedPreferences.getInstance());

  @override
  bool has(String key) => _database.containsKey(key);

  @override
  Future<bool> remove(String key) => _database.remove(key);

  @override
  Future<bool> setInt(String key, int value) => _database.setInt(key, value);

  @override
  Future<bool> setBool(String key, bool value) => _database.setBool(key, value);

  @override
  Future<bool> setAppUser(String key, AppUser value) => setHashMap(key, value);

  @override
  Future<bool> setStringList(String key, List<String> value) =>
      _database.setStringList(key, value);

  @override
  Future<bool> setHashMap(String key, Object value) =>
      setString(key, jsonEncode(value));

  @override
  Future<bool> setDouble(String key, double value) =>
      _database.setDouble(key, value);

  @override
  Future<bool> setString(String key, String value) =>
      _database.setString(key, value);

  @override
  AppUser getAppUser(String key, [AppUser fallback = const AppUser()]) =>
      has(key) ? AppUser.fromJson(getHashMap(key)) : fallback;

  @override
  Map<String, dynamic> getHashMap(String key, [Map fallback = const {}]) =>
      has(key) ? jsonDecode(getString(key)) : {...fallback};

  @override
  List<String> getStringList(String key, [List<String> fallback = const []]) =>
      _database.getStringList(key) ?? fallback;

  @override
  double getDouble(String key, [double fallback = 0.0]) =>
      _database.getDouble(key) ?? fallback;

  @override
  String getString(String key, [String fallback = '']) =>
      _database.getString(key) ?? fallback;

  @override
  bool getBool(String key, [bool fallback = false]) =>
      _database.getBool(key) ?? fallback;

  @override
  int getInt(String key, [int fallback = 0]) =>
      _database.getInt(key) ?? fallback;

  @override
  Future<bool> clear() => _database.clear();
}
