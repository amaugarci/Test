class Cash {
  final String name;
  final String symbol;
  final int id;
  const Cash({
    required this.name,
    required this.symbol,
    required this.id,
  });

  factory Cash.fromJson(Map<String, dynamic> json) {
    return Cash(name: json['name'], symbol: json['symbol'], id: json['id']);
  }
}
