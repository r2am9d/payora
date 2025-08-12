class Transaction {
  const Transaction({
    required this.id,
    required this.transactionId,
    required this.sender,
    required this.recipient,
    required this.amount,
    required this.timestamp,
  });

  final int id;
  final String transactionId;
  final String sender;
  final String recipient;
  final double amount;
  final DateTime timestamp;
}
