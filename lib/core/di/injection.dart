import 'package:dio/dio.dart';
import 'package:payora/core/shared/bloc/shell/shell_bloc.dart';
import 'package:payora/core/shared/infra/auth/index.dart';
import 'package:get_it/get_it.dart';
import 'package:payora/features/transaction/index.dart';
import 'package:payora/features/wallet/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  const uuid = Uuid();
  final prefs = await SharedPreferences.getInstance();
  final dio = Dio()
    ..options = BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

  // Register external dependencies
  getIt
    ..registerSingleton<Uuid>(uuid)
    ..registerSingleton<SharedPreferences>(prefs)
    ..registerSingleton<Dio>(dio);

  // Register application dependencies. Add below as needed.
  _shellDependencies();
  _authDependencies(prefs);
  _walletDependencies();
  _transactionDependencies(dio);
}

void _shellDependencies() {
  getIt.registerLazySingleton<ShellBloc>(ShellBloc.new);
}

void _authDependencies(SharedPreferences prefs) {
  getIt
    ..registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(prefs: prefs),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        dataSource: getIt<AuthDataSource>(),
      ),
    )
    ..registerLazySingleton<AuthLoginUsecase>(
      () => AuthLoginUsecase(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthLogoutUsecase>(
      () => AuthLogoutUsecase(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthSaveUserUsecase>(
      () => AuthSaveUserUsecase(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthGetUserUsecase>(
      () => AuthGetUserUsecase(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        loginUsecase: getIt<AuthLoginUsecase>(),
        logoutUsecase: getIt<AuthLogoutUsecase>(),
        saveUserUsecase: getIt<AuthSaveUserUsecase>(),
        getUserUsecase: getIt<AuthGetUserUsecase>(),
      ),
    );
}

void _walletDependencies() {
  getIt.registerLazySingleton<WalletBloc>(WalletBloc.new);
}

void _transactionDependencies(Dio dio) {
  getIt
    ..registerLazySingleton<TransactionDataSource>(
      () => TransactionDataSourceImpl(apiClient: dio),
    )
    ..registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(
        dataSource: getIt<TransactionDataSource>(),
      ),
    )
    ..registerLazySingleton<TransactionCreateTransactionUsecase>(
      () => TransactionCreateTransactionUsecase(
        transactionRepository: getIt<TransactionRepository>(),
      ),
    )
    ..registerLazySingleton<TransactionBloc>(
      () => TransactionBloc(
        createTransactionUsecase: getIt<TransactionCreateTransactionUsecase>(),
      ),
    );
}
