import 'package:dio/dio.dart';
import 'package:payora/features/transaction/index.dart';

class TransactionDataSourceImpl implements TransactionDataSource {
  const TransactionDataSourceImpl({
    required this.apiClient,
  });

  final Dio apiClient;

  @override
  Future<TransactionModel> createTransaction(
    TransactionModel transaction,
  ) async {
    final response = await apiClient.post<Map<String, dynamic>>(
      '/posts',
      data: transaction.toJson(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TransactionModelMapper.fromMap(response.data!);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Failed to send transaction: ${response.statusMessage}',
      );
    }
  }
}
