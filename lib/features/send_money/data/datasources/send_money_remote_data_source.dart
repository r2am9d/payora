import 'package:dio/dio.dart';
import 'package:payora/features/send_money/data/models/transaction_model.dart';

/// Remote data source for send money operations
abstract class SendMoneyRemoteDataSource {
  Future<TransactionModel> sendTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getTransactionHistory();
}

/// Implementation of SendMoneyRemoteDataSource using Dio
class SendMoneyRemoteDataSourceImpl implements SendMoneyRemoteDataSource {
  const SendMoneyRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<TransactionModel> sendTransaction(TransactionModel transaction) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/posts',
        data: transaction.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TransactionModel.fromJson(response.data!);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to send transaction: ${response.statusMessage}',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/posts'),
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionHistory() async {
    try {
      final response = await _dio.get<List<dynamic>>('/posts');

      if (response.statusCode == 200) {
        final data = response.data!;
        return data
            .map(
              (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message:
              'Failed to get transaction history: ${response.statusMessage}',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/posts'),
        message: 'Unexpected error: $e',
      );
    }
  }
}
