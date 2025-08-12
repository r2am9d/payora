import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:payora/core/di/injection.dart';
import 'package:payora/core/mixins/index.dart';
import 'package:payora/core/shared/index.dart';
import 'package:payora/core/utils/index.dart';
import 'package:payora/features/transaction/index.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState>
    with MultiStateMixin<TransactionEvent, TransactionState> {
  TransactionBloc({
    required this.createTransactionUsecase,
  }) : super(TransactionInitial()) {
    // Event handlers
    on<TransactionSendMoney>(
      _sendMoney,
      transformer: sequential(),
    );

    on<TransactionReset>(
      _reset,
      transformer: sequential(),
    );

    // Hold State
    holdState(() => const TransactionList());
    holdState(() => const TransactionError());
  }

  final TransactionCreateTransactionUsecase createTransactionUsecase;

  FutureOr<void> _sendMoney(
    TransactionSendMoney event,
    Emitter<TransactionState> emit,
  ) async {
    final authBloc = getIt<AuthBloc>();
    final shellBloc = getIt<ShellBloc>();

    try {
      // Simulate network delay
      shellBloc.add(const ShellSetLoading(loading: true));
      await Future<void>.delayed(const Duration(seconds: 2));

      final transaction = event.transaction;

      final authUser = authBloc.states<AuthVerifiedUser>()!;
      final user = authUser.user!;

      final balance = user.details.balance;
      final amount = transaction.amount;

      // Update user balance
      final userModel = UserModel.fromEntity(user);
      final detailsModel = userModel.details.copyWith(
        balance: balance - amount,
      );
      final updatedUser = userModel.copyWith(details: detailsModel).toEntity();
      authBloc.add(AuthSetVerifiedUser(user: updatedUser));

      // Simulate external api call
      final txn = await createTransactionUsecase.execute(transaction);

      // Update transaction list
      final tList = states<TransactionList>()!;
      final transactions = [txn, ...tList.transactions];
      emit(TransactionList(transactions: transactions));
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during _sendMoney: $e',
        error: e,
        trace: stackTrace,
      );
      emit(TransactionError(message: e.toString()));
      shellBloc.add(ShellSetError(message: e.toString()));
    } finally {
      shellBloc.add(const ShellSetLoading(loading: false));
    }
  }

  FutureOr<void> _reset(
    TransactionReset event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      emit(const TransactionList());
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during _reset: $e',
        error: e,
        trace: stackTrace,
      );
    }
  }
}
