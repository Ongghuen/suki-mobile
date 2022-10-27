import 'package:shared_preferences/shared_preferences.dart';

Future<void> setPrefs(key, value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future getPrefs(key) async {
  final prefs = await SharedPreferences.getInstance();
  final String? data = prefs.getString(key);
  return data;
}

Future removePrevs(key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}
