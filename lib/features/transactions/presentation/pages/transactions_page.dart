import 'package:flutter/material.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/widgets/appbar/index.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        icon: const Icon(Icons.receipt_long),
        title: context.l10n.bottomNavbarItemTransactions,
      ),
      body: const Center(
        child: Text('Transactions Page'),
      ),
    );
  }
}
