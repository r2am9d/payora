part of 'balance_bloc.dart';

sealed class BalanceState extends Equatable {
  const BalanceState();

  @override
  List<Object?> get props => [];
}

final class BalanceInitial extends BalanceState {}

/// Loading state while processing balance operations
final class BalanceLoading extends BalanceState {}

/// Current Balance
final class BalanceCurrent extends BalanceState {
  const BalanceCurrent({
    this.balance = 0,
  });

  final double balance;

  @override
  List<Object?> get props => [balance];
}
