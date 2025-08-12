import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payora/core/di/injection.dart';
import 'package:payora/core/theme/app_theme.dart';
import 'package:payora/core/utils/index.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (err) {
    AppLog.e(
      err.exceptionAsString(),
      error: err,
      trace: err.stack,
    );
  };

  Bloc.observer = const AppBlocObserver();

  // Initialize theme
  AppTheme.initialize(
    color: Colors.purple,
    font: GoogleFonts.nunitoSansTextTheme,
  );

  // Setup dependencies
  await setupDependencies();

  runApp(await builder());
}
