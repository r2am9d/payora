import 'package:flutter/material.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/widgets/bottom_navbar/index.dart';
import 'package:payora/features/wallet/index.dart';

class ShellWidget extends StatelessWidget {
  const ShellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appName),
        centerTitle: true,
      ),
      body: const WalletPage(),
      bottomNavigationBar: const BottomNavbarWidget(),
    );
  }
}
