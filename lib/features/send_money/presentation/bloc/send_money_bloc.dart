import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/mixins/multi_state_mixin.dart';
import 'package:payora/core/shared/bloc/balance_bloc.dart';
import 'package:payora/core/shared/widgets/loading_dialog/widget/loading_dialog.dart';
import 'package:payora/core/utils/index.dart';
import 'package:payora/features/send_money/domain/entities/transaction.dart';
import 'package:payora/features/send_money/domain/usecases/send_transaction_usecase.dart';

part 'send_money_event.dart';
part 'send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState>
    with MultiStateMixin<SendMoneyEvent, SendMoneyState> {
  SendMoneyBloc(this._sendTransactionUseCase) : super(SendMoneyInitial()) {
    on<SendMoneyExecuteTransaction>(
      _executeTransaction,
      transformer: sequential(),
    );

    on<SendMoneyResetStatus>(
      _resetStatus,
      transformer: sequential(),
    );

    on<SendMoneyClearForm>(
      _clearForm,
      transformer: sequential(),
    );

    // Hold state
    holdState(() => const SendMoneyTransactionList());
    holdState(() => const SendMoneyStatus());
  }

  final SendTransactionUseCase _sendTransactionUseCase;

  FutureOr<void> _executeTransaction(
    SendMoneyExecuteTransaction event,
    Emitter<SendMoneyState> emit,
  ) async {
    try {
      final ctx = event.context;
      final transaction = event.transaction;
      final balanceBloc = ctx.read<BalanceBloc>();

      LoadingDialog.show(ctx);

      // Execute transaction using the use case
      await _sendTransactionUseCase(transaction);

      balanceBloc.add(
        BalanceDeductEvent(amount: transaction.amount),
      );

      LoadingDialog.hide();

      // Add transaction to the list
      final transactionList = states<SendMoneyTransactionList>()!;
      final mTransactions = [
        transaction,
        ...transactionList.transactions,
      ];

      emit(SendMoneyTransactionList(transactions: mTransactions));
      emit(
        const SendMoneyStatus(
          success: true,
          message: 'Transaction completed successfully!',
        ),
      );
    } on Exception catch (e, trace) {
      LoadingDialog.hide();
      AppLog.e('Transaction failed: $e', error: e, trace: trace);
      emit(
        SendMoneyStatus(
          success: false,
          message: 'Transaction failed: $e',
        ),
      );
    }
  }

  FutureOr<void> _resetStatus(
    SendMoneyResetStatus event,
    Emitter<SendMoneyState> emit,
  ) async {
    emit(const SendMoneyStatus());
  }

  FutureOr<void> _clearForm(
    SendMoneyClearForm event,
    Emitter<SendMoneyState> emit,
  ) async {
    emit(const SendMoneyFormCleared());
  }
}
