import 'package:dart_mappable/dart_mappable.dart';
import 'package:payora/features/transaction/index.dart';

part 'transaction_model.mapper.dart';

@MappableClass()
class TransactionModel with TransactionModelMappable {
  const TransactionModel({
    required this.id,
    required this.transactionId,
    required this.sender,
    required this.recipient,
    required this.amount,
    required this.timestamp,
  });

  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      transactionId: transaction.transactionId,
      sender: transaction.sender,
      recipient: transaction.recipient,
      amount: transaction.amount,
      timestamp: transaction.timestamp,
    );
  }

  final int id;
  final String transactionId;
  final String sender;
  final String recipient;
  final double amount;
  final DateTime timestamp;

  Transaction toEntity() {
    return Transaction(
      id: id,
      transactionId: transactionId,
      sender: sender,
      recipient: recipient,
      amount: amount,
      timestamp: timestamp,
    );
  }
}
