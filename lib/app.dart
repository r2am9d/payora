import 'package:payora/core/di/injection.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/router/app_router.dart';
import 'package:payora/core/shared/index.dart';
import 'package:payora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/features/transaction/index.dart';
import 'package:payora/features/wallet/index.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ShellBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(const AuthCheckSession()),
        ),
        BlocProvider(
          create: (context) => getIt<WalletBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<TransactionBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: AppTheme.instance.lightTheme,
        darkTheme: AppTheme.instance.darkTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
