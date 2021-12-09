import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getStringFromSP(String key) async {
  String? value;

  await SharedPreferences.getInstance()
    .then((prefs) {
      value = prefs.getString(key) ?? '';
    });
  
  return value;
}

Future<int?> getIntFromSP(String key) async {
  int? value;
  
  await SharedPreferences.getInstance()
    .then((prefs) {
      value = prefs.getInt(key) ?? null;
    });
  
  return value;
}

