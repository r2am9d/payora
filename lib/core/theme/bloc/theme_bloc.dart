import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:payora/core/theme/bloc/theme_event.dart';
import 'package:payora/core/theme/bloc/theme_state.dart';
import 'package:payora/core/theme/services/theme_service.dart';

/// BLoC for managing application theme
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({ThemeService? themeService})
    : _themeService = themeService ?? ThemeService(),
      super(const ThemeInitial()) {
    on<ThemeLoadEvent>(_onThemeLoad);
    on<ThemeToggleEvent>(_onThemeToggle);
    on<ThemeSetEvent>(_onThemeSet);
  }

  final ThemeService _themeService;

  /// Handle theme load event
  Future<void> _onThemeLoad(
    ThemeLoadEvent event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      final isDarkMode = await _themeService.getThemeMode();
      emit(
        ThemeLoaded(
          isDarkMode: isDarkMode,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        ),
      );
    } catch (e) {
      // Default to light theme if there's an error
      emit(
        const ThemeLoaded(
          isDarkMode: false,
          themeMode: ThemeMode.light,
        ),
      );
    }
  }

  /// Handle theme toggle event
  Future<void> _onThemeToggle(
    ThemeToggleEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final currentState = state;
    if (currentState is ThemeLoaded) {
      final newIsDarkMode = !currentState.isDarkMode;

      // Save the new theme preference
      await _themeService.setThemeMode(newIsDarkMode);

      emit(
        currentState.copyWith(
          isDarkMode: newIsDarkMode,
          themeMode: newIsDarkMode ? ThemeMode.dark : ThemeMode.light,
        ),
      );
    }
  }

  /// Handle theme set event
  Future<void> _onThemeSet(
    ThemeSetEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final currentState = state;
    if (currentState is ThemeLoaded) {
      // Save the new theme preference
      await _themeService.setThemeMode(event.isDarkMode);

      emit(
        currentState.copyWith(
          isDarkMode: event.isDarkMode,
          themeMode: event.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        ),
      );
    }
  }
}
