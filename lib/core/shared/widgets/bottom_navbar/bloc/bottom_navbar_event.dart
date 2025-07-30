part of 'bottom_navbar_bloc.dart';

@immutable
sealed class BottomNavbarEvent extends Equatable {
  const BottomNavbarEvent();

  @override
  List<Object?> get props => [];
}

final class BottomNavbarSetIndex extends BottomNavbarEvent {
  const BottomNavbarSetIndex({required this.index});

  final int index;
}
