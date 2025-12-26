import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  static Future<void> saveLogin(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
    prefs.setString("email", email);
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("name") ?? "";
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") ?? "";
  }

  static Future<void> clearLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
