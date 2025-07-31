part of 'send_money_bloc.dart';

sealed class SendMoneyEvent extends Equatable {
  const SendMoneyEvent();

  @override
  List<Object?> get props => [];
}

final class SendMoneyExecuteTransaction extends SendMoneyEvent {
  const SendMoneyExecuteTransaction({
    required this.transaction,
    required this.context,
  });

  final Transaction transaction;
  final BuildContext context;
}

final class SendMoneyResetStatus extends SendMoneyEvent {
  const SendMoneyResetStatus();
}

final class SendMoneyClearForm extends SendMoneyEvent {
  const SendMoneyClearForm();
}
