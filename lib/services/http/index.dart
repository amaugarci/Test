import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test/model/Transaction_model.dart';
import 'package:test/model/cash_model.dart';
import 'package:test/model/currency_model.dart';
import 'package:test/services/http/api.dart';

class MainAPI extends Api {
  MainAPI();
  Future<List<Cuurrency>> getCurrencyList() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/balance", token);

    return List<Cuurrency>.from(
        res.data.map((x) => Cuurrency.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>);
  }

  Future<List<Cash>> getCashList() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/currency/all", token);

    return List<Cash>.from(
        res.data.map((x) => Cash.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>);
  }

  Future<List<Transaction>> getTransactionList() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/transactions", token);
    return List<Transaction>.from(res.data['data']
            .map((x) => Transaction.fromJson(x as Map<String, dynamic>))
        as Iterable<dynamic>);
  }

  Future<String> deposit(int currency_id, int sum) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
        "$apiUrl/deposit",
        {
          "currencyId": currency_id,
          "amount": sum,
        },
        token);
    if (res != null) {
      if (res.statusCode == 201) {
        return 'success';
      } else {
        return json.decode(res.body)['message'];
      }
    } else {
      return 'net error';
    }
  }

  Future<String> withdraw(int currency_id, int sum) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
        "$apiUrl/withdraw",
        {
          "currencyId": currency_id,
          "amount": sum,
        },
        token);
    if (res != null) {
      if (res.statusCode == 201) {
        return 'success';
      } else {
        return json.decode(res.body)['message'];
      }
    } else {
      return 'net error';
    }
  }
}
