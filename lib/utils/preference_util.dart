import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString("token");
  }

  Future<void> setToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("token", token);
  }

  Future<void> removeToken() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove("token");
  }
}
