part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {
  const LoginInitialState();
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginAuthenticatedState extends LoginState {
  const LoginAuthenticatedState({
    required this.username,
  });

  final String username;

  @override
  List<Object?> get props => [username];
}

class LoginUnauthenticatedState extends LoginState {
  const LoginUnauthenticatedState();
}

class LoginSubmittingState extends LoginState {
  const LoginSubmittingState();
}

class LoginLoggingOutState extends LoginState {
  const LoginLoggingOutState();
}

class LoginErrorState extends LoginState {
  const LoginErrorState({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}
