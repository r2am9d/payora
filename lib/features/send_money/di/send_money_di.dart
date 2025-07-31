import 'package:dio/dio.dart';
import 'package:payora/features/send_money/data/datasources/send_money_remote_data_source.dart';
import 'package:payora/features/send_money/data/repositories/send_money_repository_impl.dart';
import 'package:payora/features/send_money/domain/repositories/send_money_repository.dart';
import 'package:payora/features/send_money/domain/usecases/send_transaction_usecase.dart';
import 'package:payora/features/send_money/presentation/bloc/send_money_bloc.dart';

/// Dependency Injection Send Money
class SendMoneyDI {
  static Dio? _dio;
  static SendMoneyRemoteDataSource? _remoteDataSource;
  static SendMoneyRepository? _repository;
  static SendTransactionUseCase? _useCase;

  /// Initialize Dio instance
  static Dio get dio {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    return _dio!;
  }

  /// Get remote data source instance
  static SendMoneyRemoteDataSource get remoteDataSource {
    _remoteDataSource ??= SendMoneyRemoteDataSourceImpl(dio);
    return _remoteDataSource!;
  }

  /// Get repository instance
  static SendMoneyRepository get repository {
    _repository ??= SendMoneyRepositoryImpl(remoteDataSource);
    return _repository!;
  }

  /// Get use case instance
  static SendTransactionUseCase get useCase {
    _useCase ??= SendTransactionUseCase(repository);
    return _useCase!;
  }

  /// Create SendMoneyBloc instance
  static SendMoneyBloc createBloc() {
    return SendMoneyBloc(useCase);
  }

  /// Reset all instances (useful for testing)
  static void reset() {
    _dio = null;
    _remoteDataSource = null;
    _repository = null;
    _useCase = null;
  }
}
