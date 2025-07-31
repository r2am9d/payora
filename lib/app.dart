import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/navigation/app_router.dart';
import 'package:payora/core/shared/widgets/bottom_navbar/index.dart';
import 'package:payora/core/theme/index.dart';
import 'package:payora/features/wallet/presentation/bloc/bloc/wallet_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavbarBloc(),
        ),
        BlocProvider(
          create: (context) => WalletBloc(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: goRouter,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
