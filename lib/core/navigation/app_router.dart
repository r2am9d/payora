import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payora/core/shared/widgets/shell/index.dart';
import 'package:payora/features/profile/index.dart';
import 'package:payora/features/send_money/index.dart';
import 'package:payora/features/transactions/index.dart';
import 'package:payora/features/wallet/index.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Router config
final goRouter = GoRouter(
  initialLocation: '/wallet',
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
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
