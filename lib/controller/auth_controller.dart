import 'package:http/http.dart';
import 'package:test/services/http/auth_api.dart';

class AuthController {
  AuthApi api = AuthApi();

  AuthController();
  Future<String> authorize(String email, String password) async {
    return await api.authorize(email, password);
  }

  Future<void> logout() async {
    await api.preferenceUtil.removeToken();
  }

  Future<Response?> registerEmail(
      String name, String email, String password) async {
    return await api.registerEmail(name, email, password);
  }
}
