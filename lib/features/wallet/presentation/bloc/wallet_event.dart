part of 'wallet_bloc.dart';

@immutable
sealed class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object?> get props => [];
}

final class WalletSetVisibility extends WalletEvent {
  const WalletSetVisibility({required this.visibility});

  final bool visibility;
}
