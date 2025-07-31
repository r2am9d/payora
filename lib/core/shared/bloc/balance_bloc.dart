import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:payora/core/mixins/index.dart';
import 'package:payora/core/utils/index.dart';
import 'package:payora/features/login/index.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState>
    with MultiStateMixin<BalanceEvent, BalanceState> {
  BalanceBloc() : super(BalanceInitial()) {
    on<BalanceInitializeEvent>(_onInitialize, transformer: sequential());
    on<BalanceDeductEvent>(_onDeduct, transformer: sequential());

    // Hold state for balance information
    holdState(() => const BalanceCurrent());
  }

  /// Initialize balance with default user data
  Future<void> _onInitialize(
    BalanceInitializeEvent event,
    Emitter<BalanceState> emit,
  ) async {
    emit(BalanceLoading());

    try {
      final initialBalance = LoginBloc.defaultUserBalance;
      emit(BalanceCurrent(balance: initialBalance));
    } on Exception catch (e) {
      AppLog.d(
        'Failed to initialize balance: $e',
      );
    }
  }

  FutureOr<void> _onDeduct(
    BalanceDeductEvent event,
    Emitter<BalanceState> emit,
  ) async {
    try {
      final amount = event.amount;
      final balanceCurrent = states<BalanceCurrent>()!;
      emit(BalanceCurrent(balance: balanceCurrent.balance - amount));
    } catch (e) {
      AppLog.d(
        'Failed to initialize balance: $e',
      );
    }
  }
}
