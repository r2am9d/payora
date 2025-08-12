import 'dart:async';

import 'package:payora/core/di/injection.dart';
import 'package:payora/core/keys/app_key.dart';
import 'package:payora/core/shared/index.dart';
import 'package:payora/features/send_money/index.dart';
import 'package:payora/features/transaction/index.dart';
import 'package:payora/features/wallet/index.dart';
import 'package:payora/features/login/index.dart';
import 'package:payora/features/profile/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routerNotifier = RouterNotifier(getIt<AuthBloc>());

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._authBloc) {
    _subscription = _authBloc.stream.listen((state) {
      notifyListeners();
    });
  }

  final AuthBloc _authBloc;
  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  bool get isAuthenticated {
    final verifiedUser = _authBloc.states<AuthVerifiedUser>();
    if (verifiedUser == null) return false;
    return verifiedUser.user != null;
  }
}

final appRouter = GoRouter(
  navigatorKey: AppKey.routerKey,
  initialLocation: '/login',
  refreshListenable: routerNotifier,
  redirect: (routerContext, routerState) {
    final isAuthenticated = routerNotifier.isAuthenticated;
    final isOnLoginPage = routerState.matchedLocation == '/login';

    if (!isAuthenticated && !isOnLoginPage) {
      return '/login';
    }

    if (isAuthenticated && isOnLoginPage) {
      return '/wallet';
    }

    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ShellWidget(navigationShell: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
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
          routes: <RouteBase>[
            GoRoute(
              path: '/transaction',
              builder: (context, state) => const TransactionPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
