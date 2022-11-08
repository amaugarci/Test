import 'dart:convert';

import 'package:http/http.dart';
import 'package:test/model/currency_model.dart';
import 'package:test/services/http/api.dart';

class AuthApi extends Api {
  AuthApi();

  Future<String> authorize(String email, String password) async {
    final res = await Api.post(
        "$apiUrl/auth/login",
        {
          "email": email,
          "password": password,
        },
        "");
    if (res != null) {
      if (res.statusCode == 201) {
        String newToken = json.decode(res.body)['accessToken'];
        await preferenceUtil.setToken("Bearer $newToken");
        return 'true';
      } else {
        return json.decode(res.body)['message'];
      }
    } else {
      return 'net error';
    }
  }

  Future<Response?> registerEmail(
      String name, String email, String password) async {
    print('$apiUrl/auth/register');
    final res = await Api.post(
        "$apiUrl/auth/register",
        {
          'name': name,
          "email": email,
          "password": password,
        },
        "");
    if (res != null) {
      return res;
    } else {
      return null;
    }
  }
}
