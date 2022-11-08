import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:test/model/res_model.dart";
import 'package:http/http.dart' as http;
import 'package:test/utils/preference_util.dart';

class Api {
  final apiUrl = dotenv.env["DEV_API_URL"];
  final PreferenceUtil preferenceUtil = PreferenceUtil();

  static Future<ResObj> get(String url, String? token) async {
    try {
      final res = await http.get(Uri.parse(url), headers: {
        "Authorization": token ?? "",
      });
      if (res.statusCode == 200) {
        final dynamic jsonMap = json.decode(res.body);

        return ResObj(status: true, code: res.statusCode, data: jsonMap);
      } else {
        return ResObj(status: false, code: res.statusCode, error: res.body);
      }
    } catch (e) {
      return ResObj(status: false, error: "unknown");
    }
  }

  static Future<http.Response?> post(
      String url, Object data, String? token) async {
    try {
      return await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": token ?? "",
          },
          body: jsonEncode(data));
    } catch (e) {
      return null;
    }
  }
}
