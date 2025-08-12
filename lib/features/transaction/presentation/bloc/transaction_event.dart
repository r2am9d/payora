part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

final class TransactionSendMoney extends TransactionEvent {
  const TransactionSendMoney({
    required this.transaction,
  });

  final Transaction transaction;
}

final class TransactionReset extends TransactionEvent {
  const TransactionReset();
}
