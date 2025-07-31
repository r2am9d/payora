import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/theme/index.dart';

/// Custom theme switch widget
class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {
        // Show a subtle feedback when theme changes
        if (state is ThemeLoaded) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.isDarkMode ? 'Dark mode enabled' : 'Light mode enabled',
              ),
              duration: const Duration(milliseconds: 1500),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.only(
                bottom: 80,
                left: 16,
                right: 16,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final isDarkMode = state is ThemeLoaded ? state.isDarkMode : false;

        return GestureDetector(
          onTap: () {
            context.read<ThemeBloc>().add(const ThemeToggleEvent());
          },
          child: Container(
            width: 60,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isDarkMode
                  ? context.appColors.primary
                  : context.appColors.outline.withValues(alpha: 0.3),
            ),
            child: Stack(
              children: [
                // Background icons
                Positioned(
                  left: 6,
                  top: 6,
                  child: Icon(
                    Icons.wb_sunny_rounded,
                    size: 20,
                    color: isDarkMode
                        ? Colors.white.withValues(alpha: 0.5)
                        : context.appColors.primary,
                  ),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Icon(
                    Icons.dark_mode_rounded,
                    size: 20,
                    color: isDarkMode
                        ? Colors.white
                        : context.appColors.outline.withValues(alpha: 0.5),
                  ),
                ),

                // Sliding circle
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: isDarkMode ? 32 : 2,
                  top: 2,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      isDarkMode
                          ? Icons.dark_mode_rounded
                          : Icons.wb_sunny_rounded,
                      size: 16,
                      color: isDarkMode
                          ? context.appColors.primary
                          : Colors.orange.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
