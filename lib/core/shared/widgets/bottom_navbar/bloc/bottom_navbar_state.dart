part of 'bottom_navbar_bloc.dart';

@immutable
sealed class BottomNavbarState extends Equatable {
  const BottomNavbarState();

  @override
  List<Object?> get props => [];
}

final class BottomNavbarInitial extends BottomNavbarState {}

final class BottomNavbarIndex extends BottomNavbarState {
  const BottomNavbarIndex({this.index = 0});

  final int index;

  @override
  List<Object?> get props => [index];
}
