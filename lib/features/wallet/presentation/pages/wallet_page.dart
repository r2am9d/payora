import 'package:payora/core/extensions/index.dart';
import 'package:flutter/material.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/index.dart';
import 'package:payora/features/wallet/index.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        icon: Icon(
          Icons.wallet,
          color: context.appColors.onPrimary,
        ),
        title: context.l10n.bottomNavbarItemWallet,
      ),
      body: Container(
        width: context.appSize.width,
        height: context.appSize.height,
        padding: const EdgeInsets.all(16),
        child: const Column(
          children: [
            GreetingsWidget(),
            SizedBox(height: 8),
            WalletCardWidget(),
            SizedBox(height: 24),
            WalletActionsWidget(),
          ],
        ),
      ),
    );
  }
}
