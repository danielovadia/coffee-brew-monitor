import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  void removeData(String key) {
    prefs.remove(key);
  }

  static final LocalStorage instance = LocalStorage._();
}
