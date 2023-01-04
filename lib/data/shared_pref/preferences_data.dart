import 'package:shared_preferences/shared_preferences.dart';

class PreferencesData {
  static Future<bool> setBaseUrl(String baseUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('BASE_URL', baseUrl);
    return true;
  }

  static Future<String> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('BASE_URL') ?? 'localhost:3099';
  }
}
