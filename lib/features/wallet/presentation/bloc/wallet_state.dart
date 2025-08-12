part of 'wallet_bloc.dart';

@immutable
sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

final class WalletInitial extends WalletState {}

final class WalletVisibility extends WalletState {
  const WalletVisibility({
    this.visibility = true,
  });

  final bool visibility;

  @override
  List<Object> get props => [visibility];
}
