import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Theme state
sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

/// Initial theme state
final class ThemeInitial extends ThemeState {
  const ThemeInitial();
}

/// Theme loaded state
final class ThemeLoaded extends ThemeState {
  const ThemeLoaded({
    required this.isDarkMode,
    required this.themeMode,
  });

  final bool isDarkMode;
  final ThemeMode themeMode;

  @override
  List<Object> get props => [isDarkMode, themeMode];

  /// Create a copy with updated values
  ThemeLoaded copyWith({
    bool? isDarkMode,
    ThemeMode? themeMode,
  }) {
    return ThemeLoaded(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
