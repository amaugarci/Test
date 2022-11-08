class Transaction {
  final int currencyId;
  final String description;
  final String symbol;
  final int amount;
  const Transaction(
      {required this.currencyId,
      required this.description,
      required this.amount,
      required this.symbol});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        currencyId: json['currency']['id'],
        symbol: json['currency']['symbol'],
        description: json['description'],
        amount: json['amount']);
  }
}
