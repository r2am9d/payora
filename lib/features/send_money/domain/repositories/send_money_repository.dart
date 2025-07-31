import 'package:payora/features/send_money/domain/entities/transaction.dart';

abstract class SendMoneyRepository {
  Future<Transaction> sendTransaction(Transaction transaction);
  Future<List<Transaction>> getTransactionHistory();
}
