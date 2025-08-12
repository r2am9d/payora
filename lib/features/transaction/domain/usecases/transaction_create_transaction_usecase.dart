import 'package:payora/core/base/index.dart';
import 'package:payora/features/transaction/index.dart';

class TransactionCreateTransactionUsecase
    implements Usecase<Transaction, Transaction> {
  TransactionCreateTransactionUsecase({
    required this.transactionRepository,
  });

  final TransactionRepository transactionRepository;

  @override
  Future<Transaction> execute(Transaction transaction) async {
    return transactionRepository.createTransaction(transaction);
  }
}
