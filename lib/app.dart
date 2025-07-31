import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/navigation/app_router.dart';
import 'package:payora/core/services/auth_service.dart';
import 'package:payora/core/shared/bloc/index.dart';
import 'package:payora/core/shared/widgets/bottom_navbar/index.dart';
import 'package:payora/core/theme/index.dart';
import 'package:payora/features/login/index.dart';
import 'package:payora/features/send_money/index.dart';
import 'package:payora/features/wallet/presentation/bloc/bloc/wallet_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            authService: AuthService(),
          )..add(const LoginInitializeEvent()),
        ),
        BlocProvider(
          create: (context) =>
              BalanceBloc()..add(const BalanceInitializeEvent()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc()..add(const ThemeLoadEvent()),
        ),
        BlocProvider(
          create: (context) => BottomNavbarBloc(),
        ),
        BlocProvider(
          create: (context) => WalletBloc(),
        ),
        BlocProvider(
          create: (context) => SendMoneyDI.createBloc(),
        ),
      ],
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, loginState) {
          final router = createAppRouter(context.read<LoginBloc>());

          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp.router(
                routerConfig: router,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState is ThemeLoaded
                    ? themeState.themeMode
                    : ThemeMode.light,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
              );
            },
          );
        },
      ),
    );
  }
}
