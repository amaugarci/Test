class Cuurrency {
  final String currency_name;
  final String currency_symbol;
  final int sum;
  const Cuurrency({
    required this.currency_name,
    required this.currency_symbol,
    required this.sum,
  });

  factory Cuurrency.fromJson(Map<String, dynamic> json) {
    return Cuurrency(
        currency_name: json['currency_name'],
        currency_symbol: json['currency_symbol'],
        sum: json['sum']);
  }
}
