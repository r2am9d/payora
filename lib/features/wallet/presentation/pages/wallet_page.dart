import 'package:flutter/material.dart';
import 'package:payora/core/extensions/media_query_extension.dart';
import 'package:payora/features/wallet/index.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.appSize.width,
      height: context.appSize.height,
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: [
          GreetingsWidget(),
          SizedBox(height: 8),
          WalletWidget(),
        ],
      ),
    );
  }
}
