import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/base/index.dart';
import 'package:payora/core/di/injection.dart';
import 'package:payora/core/mixins/index.dart';
import 'package:payora/core/shared/index.dart';
import 'package:payora/core/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:payora/features/transaction/index.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>
    with MultiStateMixin<AuthEvent, AuthState> {
  AuthBloc({
    // required this.authRepository,
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.saveUserUsecase,
    required this.getUserUsecase,
  }) : super(AuthInitial()) {
    // Event handlers
    on<AuthExecuteLogin>(
      _executeLogin,
      transformer: sequential(),
    );
    on<AuthExecuteLogout>(
      _executeLogout,
      transformer: sequential(),
    );
    on<AuthSaveUser>(
      _saveUser,
      transformer: sequential(),
    );
    on<AuthCheckSession>(
      _checkSession,
      transformer: sequential(),
    );
    on<AuthSetVerifiedUser>(
      _setVerifiedUser,
      transformer: sequential(),
    );

    // Hold State
    holdState(() => const AuthVerifiedUser());
    holdState(() => const AuthLoading());
    holdState(() => const AuthError());

    // Check for existing session on startup
    add(const AuthCheckSession());
  }

  // final AuthRepository authRepository;
  final AuthLoginUsecase loginUsecase;
  final AuthLogoutUsecase logoutUsecase;
  final AuthSaveUserUsecase saveUserUsecase;
  final AuthGetUserUsecase getUserUsecase;

  FutureOr<void> _executeLogin(
    AuthExecuteLogin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Simulate network delay
      emit(const AuthLoading(loading: true));
      await Future<void>.delayed(const Duration(seconds: 2));

      final user = await loginUsecase.execute(
        LoginParams(
          username: event.username,
          password: event.password,
        ),
      );

      emit(AuthVerifiedUser(user: user));
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during _executeLogin: $e',
        error: e,
        trace: stackTrace,
      );
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> _executeLogout(
    AuthExecuteLogout event,
    Emitter<AuthState> emit,
  ) async {
    final shellBloc = getIt<ShellBloc>();
    final txnBloc = getIt<TransactionBloc>();

    try {
      // Simulate network delay
      shellBloc.add(const ShellSetLoading(loading: true));
      await Future<void>.delayed(const Duration(seconds: 2));

      await logoutUsecase.execute(const NoParams());

      // Set the user to null after logout
      emit(const AuthVerifiedUser());
      txnBloc.add(const TransactionReset());
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during _executeLogout: $e',
        error: e,
        trace: stackTrace,
      );
      shellBloc.add(ShellSetError(message: e.toString()));
    } finally {
      shellBloc.add(const ShellSetLoading(loading: false));
    }
  }

  FutureOr<void> _saveUser(
    AuthSaveUser event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = event.user;
      await saveUserUsecase.execute(user);
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during _saveUser: $e',
        error: e,
        trace: stackTrace,
      );
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> _checkSession(
    AuthCheckSession event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await getUserUsecase.execute(const NoParams());
      emit(AuthVerifiedUser(user: user));
    } on Exception catch (e, stackTrace) {
      AppLog.d(
        '_checkSession: $e',
        trace: stackTrace,
      );
    }
  }

  FutureOr<void> _setVerifiedUser(
    AuthSetVerifiedUser event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthVerifiedUser(user: event.user));
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during _setVerifiedUser: $e',
        error: e,
        trace: stackTrace,
      );
    }
  }
}
