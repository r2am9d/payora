part of 'balance_bloc.dart';

sealed class BalanceEvent extends Equatable {
  const BalanceEvent();

  @override
  List<Object> get props => [];
}

/// Initialize balance with default user data
final class BalanceInitializeEvent extends BalanceEvent {
  const BalanceInitializeEvent();
}

/// Update balance to a specific amount
final class BalanceUpdateEvent extends BalanceEvent {
  const BalanceUpdateEvent({
    required this.newBalance,
  });

  final double newBalance;

  @override
  List<Object> get props => [newBalance];
}

/// Deduct amount from current balance
final class BalanceDeductEvent extends BalanceEvent {
  const BalanceDeductEvent({
    required this.amount,
  });

  final double amount;

  @override
  List<Object> get props => [amount];
}

/// Add amount to current balance
final class BalanceAddEvent extends BalanceEvent {
  const BalanceAddEvent({
    required this.amount,
  });

  final double amount;

  @override
  List<Object> get props => [amount];
}

/// Reset balance to default amount
final class BalanceResetEvent extends BalanceEvent {
  const BalanceResetEvent();
}
