import 'package:flutter/material.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/widgets/bottom_navbar/index.dart';
import 'package:payora/features/wallet/index.dart';

class ShellWidget extends StatelessWidget {
  const ShellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        centerTitle: true,
      ),
      body: const WalletPage(),
      bottomNavigationBar: const BottomNavbarWidget(),
    );
  }
}
