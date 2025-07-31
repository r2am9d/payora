import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Color palette
  static const Color _primaryPurple = Colors.purple;
  static const Color _primaryPurpleLight = Color(0xFFBA68C8); // purple.shade300
  static const Color _primaryPurpleLighter = Color(
    0xFFCE93D8,
  ); // purple.shade200
  static const Color _white = Colors.white;
  static const Color _black = Colors.black;
  // static const Color _lightGrey = Color(0xFFF5F5F5);
  static const Color _darkGrey = Color(0xFF121212);
  static const Color _mediumGrey = Color(0xFF757575);

  /// Light Theme Configuration
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,

      // Color scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryPurple,
        primary: _primaryPurple,
        onPrimary: _white,
        secondary: _primaryPurpleLight,
        onSecondary: _white,
        surface: _white,
        onSurface: _black,
        error: Colors.red.shade600,
        onError: _white,
      ),

      // App bar theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: _primaryPurple,
        foregroundColor: _white,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: _white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryPurple,
          foregroundColor: _white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primaryPurple,
          side: const BorderSide(color: _primaryPurple, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryPurple,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: _white,
        elevation: 4,
        shadowColor: _black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _mediumGrey.withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _mediumGrey.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryPurple, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade600, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade600, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: const TextStyle(color: _mediumGrey),
        labelStyle: const TextStyle(color: _primaryPurple),
      ),

      // Floating action button theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primaryPurple,
        foregroundColor: _white,
        elevation: 6,
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _white,
        selectedItemColor: _primaryPurple,
        unselectedItemColor: _mediumGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Text theme
      textTheme: GoogleFonts.nunitoSansTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: _black,
            height: 1.25, // 40px line height
            letterSpacing: -0.25,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: _black,
            height: 1.29, // 36px line height
            letterSpacing: 0,
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: _black,
            height: 1.33, // 32px line height
            letterSpacing: 0,
          ),
          headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: _black,
            height: 1.45, // 32px line height
            letterSpacing: 0,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: _black,
            height: 1.5, // 30px line height
            letterSpacing: 0,
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _black,
            height: 1.44, // 26px line height
            letterSpacing: 0,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _black,
            height: 1.5, // 24px line height
            letterSpacing: 0.15,
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _black,
            height: 1.43, // 20px line height
            letterSpacing: 0.15,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _black,
            height: 1.33, // 16px line height
            letterSpacing: 0.1,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: _black,
            height: 1.5, // 24px line height
            letterSpacing: 0.15,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: _black,
            height: 1.43, // 20px line height
            letterSpacing: 0.25,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: _mediumGrey,
            height: 1.67, // 20px line height
            letterSpacing: 0.4,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _black,
            height: 1.43, // 20px line height
            letterSpacing: 0.1,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _black,
            height: 1.33, // 16px line height
            letterSpacing: 0.5,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: _mediumGrey,
            height: 1.6, // 16px line height
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: _mediumGrey.withValues(alpha: 0.2),
        thickness: 1,
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: _primaryPurple,
        size: 24,
      ),

      // List tile theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        iconColor: _primaryPurple,
        textColor: _black,
      ),
    );
  }

  /// Dark Theme Configuration
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,

      // Color scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryPurple,
        brightness: Brightness.dark,
        primary: _primaryPurpleLight,
        onPrimary: _black,
        secondary: _primaryPurpleLighter,
        onSecondary: _black,
        surface: const Color(0xFF1E1E1E),
        onSurface: _white,
        error: Colors.red.shade400,
        onError: _black,
      ),

      // App bar theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: _darkGrey,
        foregroundColor: _white,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: _white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryPurpleLight,
          foregroundColor: _black,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primaryPurpleLight,
          side: const BorderSide(color: _primaryPurpleLight, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryPurpleLight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E1E),
        elevation: 4,
        shadowColor: _black.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _mediumGrey.withValues(alpha: 0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _mediumGrey.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryPurpleLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade400, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: const TextStyle(color: _mediumGrey),
        labelStyle: const TextStyle(color: _primaryPurpleLight),
      ),

      // Floating action button theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primaryPurpleLight,
        foregroundColor: _black,
        elevation: 6,
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: _primaryPurpleLight,
        unselectedItemColor: _mediumGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Text theme
      textTheme: GoogleFonts.nunitoSansTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: _white,
            height: 1.25, // 40px line height
            letterSpacing: -0.25,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: _white,
            height: 1.29, // 36px line height
            letterSpacing: 0,
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: _white,
            height: 1.33, // 32px line height
            letterSpacing: 0,
          ),
          headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: _white,
            height: 1.45, // 32px line height
            letterSpacing: 0,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: _white,
            height: 1.5, // 30px line height
            letterSpacing: 0,
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _white,
            height: 1.44, // 26px line height
            letterSpacing: 0,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _white,
            height: 1.5, // 24px line height
            letterSpacing: 0.15,
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _white,
            height: 1.43, // 20px line height
            letterSpacing: 0.15,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _white,
            height: 1.33, // 16px line height
            letterSpacing: 0.1,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: _white,
            height: 1.5, // 24px line height
            letterSpacing: 0.15,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: _white,
            height: 1.43, // 20px line height
            letterSpacing: 0.25,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: _mediumGrey,
            height: 1.67, // 20px line height
            letterSpacing: 0.4,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _white,
            height: 1.43, // 20px line height
            letterSpacing: 0.1,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _white,
            height: 1.33, // 16px line height
            letterSpacing: 0.5,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: _mediumGrey,
            height: 1.6, // 16px line height
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: _mediumGrey.withValues(alpha: 0.3),
        thickness: 1,
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: _primaryPurpleLight,
        size: 24,
      ),

      // List tile theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        iconColor: _primaryPurpleLight,
        textColor: _white,
      ),
    );
  }
}
