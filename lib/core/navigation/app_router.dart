import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payora/core/shared/widgets/shell/index.dart';
import 'package:payora/features/login/index.dart';
import 'package:payora/features/profile/index.dart';
import 'package:payora/features/send_money/index.dart';
import 'package:payora/features/transactions/index.dart';
import 'package:payora/features/wallet/index.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Change notifier that listens to LoginBloc state changes
class LoginBlocChangeNotifier extends ChangeNotifier {
  LoginBlocChangeNotifier(this._loginBloc) {
    _loginBloc.stream.listen((_) {
      notifyListeners();
    });
  }

  final LoginBloc _loginBloc;
}

/// Create router with authentication-aware routing
GoRouter createAppRouter(LoginBloc loginBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/wallet',
    refreshListenable: LoginBlocChangeNotifier(loginBloc),
    redirect: (context, state) {
      final loginState = loginBloc.state;
      final currentPath = state.matchedLocation;

      // If still loading, don't redirect
      if (loginState is LoginLoadingState || loginState is LoginInitialState) {
        return null;
      }

      // If user is not authenticated, has error, or not on login page, redirect to login
      if ((loginState is LoginUnauthenticatedState ||
              loginState is LoginErrorState ||
              loginState is LoginSubmittingState) &&
          currentPath != '/login') {
        return '/login';
      }

      // If user is authenticated and on login page, redirect to main app
      if (loginState is LoginAuthenticatedState && currentPath == '/login') {
        return '/wallet';
      }

      return null; // No redirect needed
    },
    routes: <RouteBase>[
      // Login route (outside shell)
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),

      // Main app shell with bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ShellWidget(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/wallet',
                builder: (context, state) => const WalletPage(),
                routes: [
                  GoRoute(
                    path: 'send-money',
                    builder: (context, state) => const SendMoneyPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/transactions',
                builder: (BuildContext context, GoRouterState state) {
                  return const TransactionsPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (BuildContext context, GoRouterState state) {
                  return const ProfilePage();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
