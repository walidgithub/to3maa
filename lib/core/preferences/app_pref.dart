import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String FIRST_LOAD = "FIRST_LOAD";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  //first load
  Future<void> setFirstLoad() async {
    _sharedPreferences.setBool(FIRST_LOAD, true);
  }

  Future<bool> isFirstLoad() async {
    return _sharedPreferences.getBool(FIRST_LOAD) ?? false;
  }
}