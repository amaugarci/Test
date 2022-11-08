import 'package:test/model/Transaction_model.dart';
import 'package:test/model/cash_model.dart';
import 'package:test/model/currency_model.dart';
import 'package:test/services/http/index.dart';

class MainController {
  MainAPI api = MainAPI();

  MainController();
  Future<List<Cuurrency>> getCurrencyList() async {
    return await api.getCurrencyList();
  }

  Future<List<Cash>> getCashList() async {
    return await api.getCashList();
  }

  Future<List<Transaction>> getTransactionList() async {
    return await api.getTransactionList();
  }

  Future<String> withdraw(int currency_id, int sum) async {
    return await api.withdraw(currency_id, sum);
  }

  Future<String> deposit(int currency_id, int sum) async {
    return await api.deposit(currency_id, sum);
  }
}
