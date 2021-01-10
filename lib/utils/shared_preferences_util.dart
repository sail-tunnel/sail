import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  SharedPreferencesUtil._();

  static SharedPreferencesUtil _instance;
  SharedPreferences sharedPreferences;

  static SharedPreferencesUtil getInstance() {
    if (_instance == null) {
      _instance = SharedPreferencesUtil._();
    }
    return _instance;
  }

  static saveData<T>(String key, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (T) {
      case String:
        prefs.setString(key, value as String);
        break;
      case int:
        prefs.setInt(key, value as int);
        break;
      case bool:
        prefs.setBool(key, value as bool);
        break;
      case double:
        prefs.setDouble(key, value as double);
        break;
    }
  }

  static Future<T> getData<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    T res;
    switch (T) {
      case String:
        res = prefs.getString(key) as T;
        break;
      case int:
        res = prefs.getInt(key) as T;
        break;
      case bool:
        res = prefs.getBool(key) as T;
        break;
      case double:
        res = prefs.getDouble(key) as T;
        break;
    }
    return res;
  }

  Future<bool> setBool(String tag, bool isFirst) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(tag, isFirst);
  }

  Future<bool> setString(String tag, String data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(tag, data);
  }

  Future<bool> setMap(String tag, Map<String, dynamic> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(tag, jsonEncode(data));
  }

  Future<bool> setList(String tag, List<dynamic> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(tag, jsonEncode(data));
  }

  Future<bool> getBool(String tag) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(tag);
  }

  Future<String> getString(String tag) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(tag);
  }

  Future<Map<String, dynamic>> getMap(String tag) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return jsonDecode(sharedPreferences.getString(tag) ?? '{}');
  }

  Future<List<dynamic>> getList(String tag) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return jsonDecode(sharedPreferences.getString(tag) ?? '[]');
  }

  Future<bool> clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }
}
