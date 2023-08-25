import 'package:shared_preferences/shared_preferences.dart';

class PreferencesData {
  static Future<bool> setBaseUrl(String baseUrl) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('BASE_URL', baseUrl);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<String> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('BASE_URL') ?? 'localhost';
  }

  static Future<bool> getTestMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('TEST_MODE') ?? true;
  }

  static Future<bool> setTestMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool currentSet = await getTestMode();
      bool testMode = !currentSet;
      print('DEBUGGING SET PREF ' + testMode.toString());
      await prefs.setBool('TEST_MODE', testMode);
      return true;
    } catch (err) {
      return false;
    }
  }
}
