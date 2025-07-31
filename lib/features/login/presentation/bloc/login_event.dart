part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginInitializeEvent extends LoginEvent {
  const LoginInitializeEvent();
}

class LoginSubmitEvent extends LoginEvent {
  const LoginSubmitEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object?> get props => [username, password];
}

class LoginLogoutEvent extends LoginEvent {
  const LoginLogoutEvent();
}

class LoginCheckAuthEvent extends LoginEvent {
  const LoginCheckAuthEvent();
}
