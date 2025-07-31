import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/widgets/bottom_navbar/index.dart';

class ShellWidget extends StatelessWidget {
  const ShellWidget({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.appName,
          style: context.appTextTheme.headlineLarge?.copyWith(
            color: context.appColors.surface,
          ),
        ),
        centerTitle: true,
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavbarWidget(navigationShell: navigationShell),
    );
  }
}
