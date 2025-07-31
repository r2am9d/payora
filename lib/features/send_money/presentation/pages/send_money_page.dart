import 'package:flutter/material.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/widgets/appbar/index.dart';

class SendMoneyPage extends StatelessWidget {
  const SendMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: context.l10n.walletActionsItemSendMoney,
        icon: const Icon(Icons.send),
        showIcon: false,
      ),
      body: const Center(
        child: Text('Send Money Page'),
      ),
    );
  }
}
