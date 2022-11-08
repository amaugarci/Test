import 'package:flutter/material.dart';
import 'package:test/views/dashboard.dart';
import 'package:test/views/currency.dart';
import 'package:test/views/login.dart';
import 'package:test/views/register.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/registration':
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case '/index':
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => CurrencyScreen());
      default:
        return MaterialPageRoute(builder: (_) => CurrencyScreen());
    }
  }
}
