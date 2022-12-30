import 'package:shared_preferences/shared_preferences.dart';

class PreferencesData {
  static void setBaseUrl(String baseUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('BASE_URL', baseUrl);
  }

  static Future<String> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final String url = prefs.getString('BASE_URL') ?? 'localhost:3099';
    return 'http://$url';
  }
}
