import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/widgets/bottom_navbar/index.dart';
import 'package:payora/core/shared/widgets/custom_icon_button/index.dart';

class WalletActionsWidget extends StatelessWidget {
  const WalletActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bnBloc = context.read<BottomNavbarBloc>();

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
            bnBloc.add(const BottomNavbarSetIndex(index: 0));
          },
        ),
        CustomIconButton(
          icon: Icon(
            Icons.receipt_long,
            size: 20,
            color: context.appColors.primary,
          ),
          label: context.l10n.walletActionsItemViewTransactions,
          onPressed: () {
            context.go('/transactions');
            bnBloc.add(const BottomNavbarSetIndex(index: 1));
          },
        ),
      ],
    );
  }
}
