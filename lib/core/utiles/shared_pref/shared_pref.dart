import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._internal();
  static final SharedPref instance = SharedPref._internal();

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<void> setList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  List<String>? getList(String key) {
    return _prefs.getStringList(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  Future<void> setMap(String key, Map<int, String> value) async {
    // JSON لا يدعم int كمفتاح، نحوله إلى String
    Map<String, String> mapToSave = value.map(
      (k, v) => MapEntry(k.toString(), v),
    );

    String jsonString = jsonEncode(mapToSave);

    await _prefs.setString(key, jsonString);
  }

  Future<Map<int, String>> getMap(String key) async {
    String? jsonString = _prefs.getString(key);

    if (jsonString == null) return {};

    try {
      Map<String, dynamic> decoded = jsonDecode(jsonString);
      return decoded.map((k, v) => MapEntry(int.parse(k), v.toString()));
    } catch (_) {
      return {};
    }
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  bool contains(String key) {
    return _prefs.containsKey(key);
  }
}
