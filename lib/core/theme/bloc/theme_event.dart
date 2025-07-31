// ignore_for_file: avoid_positional_boolean_parameters, document_ignores

import 'package:equatable/equatable.dart';

/// Theme events
sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

/// Event to toggle between light and dark theme
final class ThemeToggleEvent extends ThemeEvent {
  const ThemeToggleEvent();
}

/// Event to set a specific theme mode
final class ThemeSetEvent extends ThemeEvent {
  const ThemeSetEvent(this.isDarkMode);

  final bool isDarkMode;

  @override
  List<Object> get props => [isDarkMode];
}

/// Event to load theme from storage
final class ThemeLoadEvent extends ThemeEvent {
  const ThemeLoadEvent();
}
