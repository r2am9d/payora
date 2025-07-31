import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/mixins/index.dart';
import 'package:payora/core/services/auth_service.dart';
import 'package:payora/core/utils/index.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>
    with MultiStateMixin<LoginEvent, LoginState> {
  LoginBloc({
    required AuthService authService,
  }) : _authService = authService,
       super(const LoginInitialState()) {
    on<LoginInitializeEvent>(_onInitialize, transformer: sequential());
    on<LoginSubmitEvent>(_onSubmit, transformer: sequential());
    on<LoginLogoutEvent>(_onLogout, transformer: sequential());
    on<LoginCheckAuthEvent>(_onCheckAuth, transformer: sequential());
  }

  final AuthService _authService;

  // Default user credentials for validation
  static const String _defaultName = 'John Doe';
  static const String _defaultEmail = 'jdoe123@payora.com';
  static const String _defaultUsername = 'jdoe123';
  static const String _defaultPassword = 'admin123456';
  static const double _defaultBalance = 1000000;
  static const bool _defaultIsLoggedIn = false;

  /// Handle login initialization
  Future<void> _onInitialize(
    LoginInitializeEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoadingState());

    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        final username = await _authService.getUsername();
        emit(LoginAuthenticatedState(username: username ?? 'User'));
      } else {
        emit(const LoginUnauthenticatedState());
      }
    } on Exception catch (e, trace) {
      emit(LoginErrorState(message: e.toString()));
      AppLog.e(e.toString(), error: e, trace: trace); // coverage:ignore-line
    }
  }

  /// Handle user login submission
  Future<void> _onSubmit(
    LoginSubmitEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginSubmittingState());

    try {
      // Simulate login delay
      await Future<void>.delayed(const Duration(seconds: 2));

      // Validate against default user credentials first
      final isValidCredentials = _validateCredentials(
        username: event.username,
        password: event.password,
      );

      if (isValidCredentials) {
        // Only store credentials if validation passes
        final success = await _authService.login(
          username: event.username,
          password: event.password,
        );

        if (success) {
          emit(LoginAuthenticatedState(username: event.username));
        } else {
          emit(const LoginErrorState(message: 'Failed to save login state'));
        }
      } else {
        // Invalid credentials - do not call AuthService
        emit(const LoginErrorState(message: 'Invalid username or password'));
      }
    } on Exception catch (e, trace) {
      emit(LoginErrorState(message: e.toString()));
      AppLog.e(e.toString(), error: e, trace: trace); // coverage:ignore-line
    }
  }

  /// Handle user logout
  Future<void> _onLogout(
    LoginLogoutEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoggingOutState());

    try {
      await _authService.logout();
      emit(const LoginUnauthenticatedState());
    } on Exception catch (e, trace) {
      emit(LoginErrorState(message: e.toString()));
      AppLog.e(e.toString(), error: e, trace: trace); // coverage:ignore-line
    }
  }

  /// Handle authentication check
  Future<void> _onCheckAuth(
    LoginCheckAuthEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        final username = await _authService.getUsername();
        emit(LoginAuthenticatedState(username: username ?? 'User'));
      } else {
        emit(const LoginUnauthenticatedState());
      }
    } on Exception catch (e, trace) {
      emit(LoginErrorState(message: e.toString()));
      AppLog.e(e.toString(), error: e, trace: trace); // coverage:ignore-line
    }
  }

  /// Validate user credentials against default user
  bool _validateCredentials({
    required String username,
    required String password,
  }) {
    final trimmedUsername = username.trim();
    final trimmedPassword = password.trim();

    final isValid =
        trimmedUsername == _defaultUsername &&
        trimmedPassword == _defaultPassword;

    return isValid;
  }

  /// Get default user balance (for future use)
  static double get defaultUserBalance => _defaultBalance;

  /// Get default user login status (for future use)
  static bool get defaultUserLoginStatus => _defaultIsLoggedIn;

  /// Get default user name
  static String get defaultUserName => _defaultName;

  /// Get default user email
  static String get defaultUserEmail => _defaultEmail;

  /// Get default username
  static String get defaultUsername => _defaultUsername;

  /// Get all user data as a map
  static Map<String, dynamic> get defaultUserData => {
    'name': _defaultName,
    'email': _defaultEmail,
    'username': _defaultUsername,
    'balance': _defaultBalance,
    'isLoggedIn': _defaultIsLoggedIn,
  };

  /// Generate a card number based on username (for demo purposes)
  static int get generatedCardNumber {
    // Create a simple card number based on username
    final usernameHash = _defaultUsername.hashCode.abs();
    // Convert to a 13-digit number starting with 4 (like Visa)
    final cardNumber = 4000000000000 + (usernameHash % 1000000000);
    return cardNumber;
  }
}
