import 'package:payora/features/transaction/index.dart';

abstract class TransactionDataSource {
  Future<TransactionModel> createTransaction(TransactionModel transaction);
}
