import 'package:payora/features/transaction/index.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  const TransactionRepositoryImpl({
    required this.dataSource,
  });

  final TransactionDataSource dataSource;

  @override
  Future<Transaction> createTransaction(Transaction transaction) async {
    final transactionModel = await dataSource.createTransaction(
      TransactionModel.fromEntity(transaction),
    );
    return transactionModel.toEntity();
  }
}
