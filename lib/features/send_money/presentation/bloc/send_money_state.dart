part of 'send_money_bloc.dart';

sealed class SendMoneyState extends Equatable {
  const SendMoneyState();

  @override
  List<Object?> get props => [];
}

final class SendMoneyInitial extends SendMoneyState {}

final class SendMoneyTransactionList extends SendMoneyState {
  const SendMoneyTransactionList({
    this.transactions = const [],
  });

  final List<Transaction> transactions;

  @override
  List<Object> get props => [transactions];
}

final class SendMoneyStatus extends SendMoneyState {
  const SendMoneyStatus({
    this.success,
    this.message,
  });

  final bool? success;
  final String? message;

  @override
  List<Object?> get props => [success, message];
}

final class SendMoneyFormCleared extends SendMoneyState {
  const SendMoneyFormCleared();
}
