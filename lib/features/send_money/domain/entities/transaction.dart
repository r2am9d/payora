class Transaction {
  const Transaction({
    required this.recipient,
    required this.amount,
    required this.time,
  });

  final String recipient;
  final double amount;
  final String time;
}
