import 'package:payora/features/send_money/data/datasources/send_money_remote_data_source.dart';
import 'package:payora/features/send_money/data/models/transaction_model.dart';
import 'package:payora/features/send_money/domain/entities/transaction.dart';
import 'package:payora/features/send_money/domain/repositories/send_money_repository.dart';

/// Implementation of SendMoneyRepository
class SendMoneyRepositoryImpl implements SendMoneyRepository {
  const SendMoneyRepositoryImpl(this._remoteDataSource);

  final SendMoneyRemoteDataSource _remoteDataSource;

  @override
  Future<Transaction> sendTransaction(Transaction transaction) async {
    try {
      // Convert entity to model for data layer
      final transactionModel = TransactionModel.fromEntity(transaction);

      // Send transaction via remote data source
      final result = await _remoteDataSource.sendTransaction(transactionModel);

      // Convert back to entity for domain layer
      return result.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Transaction>> getTransactionHistory() async {
    try {
      final transactionModels = await _remoteDataSource.getTransactionHistory();

      return transactionModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
