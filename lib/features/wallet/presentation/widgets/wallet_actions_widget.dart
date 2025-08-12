import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/index.dart';

class WalletActionsWidget extends StatelessWidget {
  const WalletActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          icon: Icon(
            Icons.send,
            size: 20,
            color: context.appColors.primary,
          ),
          label: context.l10n.walletActionsItemSendMoney,
          onPressed: () {
            context.go('/wallet/send-money');
          },
        ),
        CustomIconButton(
          icon: Icon(
            Icons.receipt_long,
            size: 20,
            color: context.appColors.primary,
          ),
          label: context.l10n.walletActionsItemViewTransaction,
          onPressed: () {
            context.go('/transaction');
          },
        ),
      ],
    );
  }
}
