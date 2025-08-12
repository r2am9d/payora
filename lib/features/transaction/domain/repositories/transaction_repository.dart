import 'package:payora/features/transaction/index.dart';

abstract class TransactionRepository {
  Future<Transaction> createTransaction(Transaction transaction);
}
