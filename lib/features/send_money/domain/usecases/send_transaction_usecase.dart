import 'package:payora/features/send_money/domain/entities/transaction.dart';
import 'package:payora/features/send_money/domain/repositories/send_money_repository.dart';

class SendTransactionUseCase {
  const SendTransactionUseCase(this._repository);

  final SendMoneyRepository _repository;

  Future<Transaction> call(Transaction transaction) async {
    // Add any business logic validation here
    if (transaction.amount <= 0) {
      throw ArgumentError('Transaction amount must be greater than 0');
    }

    if (transaction.recipient.isEmpty) {
      throw ArgumentError('Recipient cannot be empty');
    }

    // Call repository to send transaction
    return _repository.sendTransaction(transaction);
  }
}
