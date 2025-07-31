/// Service for managing theme preferences
class ThemeService {
  // In-memory storage for demo purposes
  static bool _isDarkMode = false;

  /// Get the current theme mode
  Future<bool> getThemeMode() async {
    // For in-memory storage
    return _isDarkMode;
  }

  /// Set the theme mode
  Future<void> setThemeMode(bool isDarkMode) async {
    _isDarkMode = isDarkMode;
  }

  /// Clear theme preferences
  Future<void> clearThemePreferences() async {
    _isDarkMode = false;
  }
}
