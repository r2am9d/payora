part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

final class TransactionInitial extends TransactionState {}

final class TransactionList extends TransactionState {
  const TransactionList({
    this.transactions = const [],
  });

  final List<Transaction> transactions;

  @override
  List<Object> get props => [transactions];
}

final class TransactionError extends TransactionState {
  const TransactionError({
    this.message = '',
  });

  final String message;

  @override
  List<Object> get props => [message];
}
