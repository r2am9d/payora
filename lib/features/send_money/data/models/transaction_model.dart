import 'package:payora/features/send_money/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  const TransactionModel({
    required super.recipient,
    required super.amount,
    required super.time,
  });

  /// Creates a TransactionModel from Transaction entity
  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      recipient: transaction.recipient,
      amount: transaction.amount,
      time: transaction.time,
    );
  }

  /// Creates a TransactionModel from JSON
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      recipient: json['recipient'] as String,
      amount: (json['amount'] as num).toDouble(),
      time: json['time'] as String,
    );
  }

  /// Converts TransactionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'recipient': recipient,
      'amount': amount,
      'time': time,
    };
  }

  /// Converts to Transaction entity
  Transaction toEntity() {
    return Transaction(
      recipient: recipient,
      amount: amount,
      time: time,
    );
  }

  /// Creates a copy with updated fields
  TransactionModel copyWith({
    String? recipient,
    double? amount,
    String? time,
  }) {
    return TransactionModel(
      recipient: recipient ?? this.recipient,
      amount: amount ?? this.amount,
      time: time ?? this.time,
    );
  }
}
