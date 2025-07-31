import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _usernameKey = 'username';

  /// Check if user is currently logged in
  Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_isLoggedInKey) ?? false;
    } on Exception catch (e) {
      return false;
    }
  }

  /// Get stored username
  Future<String?> getUsername() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_usernameKey);
    } on Exception catch (e) {
      return null;
    }
  }

  /// Perform login and store credentials
  /// Note: This method only stores the credentials, validation should be done before calling this
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      // Store credentials without validation (validation is done in LoginBloc)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_usernameKey, username);
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  /// Perform logout and clear stored data
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, false);
      await prefs.remove(_usernameKey);
    } on Exception catch (e) {
      // Handle error silently for now
    }
  }

  /// Clear all authentication data
  Future<void> clearAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_isLoggedInKey);
      await prefs.remove(_usernameKey);
    } on Exception catch (e) {
      // Handle error silently for now
    }
  }
}
