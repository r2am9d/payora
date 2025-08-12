import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/index.dart';
import 'package:payora/features/transaction/index.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final txnBloc = context.read<TransactionBloc>();

    return Scaffold(
      appBar: AppbarWidget(
        icon: Icon(
          Icons.receipt_long,
          color: context.appColors.onPrimary,
        ),
        title: context.l10n.bottomNavbarItemTransaction,
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          final txnList = txnBloc.states<TransactionList>()!;

          // Handle empty state
          if (txnList.transactions.isEmpty) {
            return _buildEmptyState(context, context.appTheme);
          }

          // Show transaction list
          return RefreshIndicator(
            onRefresh: () async {
              await Future<void>.delayed(const Duration(seconds: 1));
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: txnList.transactions.length,
              itemBuilder: (context, index) {
                final transaction = txnList.transactions[index];
                return TransactionCardWidget(
                  transaction: transaction,
                  onTap: () => _onTransactionTap(context, transaction),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _onTransactionTap(BuildContext context, Transaction transaction) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildTransactionDetails(context, transaction),
    );
  }

  /// Build empty state widget
  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(
                Icons.receipt_long_rounded,
                size: 60,
                color: theme.colorScheme.primary.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Transaction Yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your transaction history will appear here once you start sending money.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {
                context.go('/wallet/send-money');
              },
              icon: const Icon(Icons.send_rounded),
              label: const Text('Send Money'),
            ),
          ],
        ),
      ),
    );
  }

  /// Build transaction details bottom sheet
  Widget _buildTransactionDetails(
    BuildContext context,
    Transaction transaction,
  ) {
    final theme = context.appTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outline.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Transaction header
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Icon(
                  Icons.send_rounded,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Money Sent',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      transaction.timestamp.formattedDate,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Transaction details
          _buildDetailRow(context, 'Recipient', transaction.recipient),
          const SizedBox(height: 16),
          _buildDetailRow(
            context,
            'Amount',
            '₱${transaction.amount.withComma}',
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            context,
            'Status',
            'Completed',
            statusColor: Colors.green,
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            context,
            'Transaction ID',
            transaction.transactionId.last,
          ),
          const SizedBox(height: 32),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: context.appColors.inverseSurface,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.share_rounded),
                  label: const Text('Share'),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/wallet/send-money');
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Send Again'),
                ),
              ),
            ],
          ),

          // Bottom padding for safe area
          SizedBox(height: context.appMediaQuery.padding.bottom),
        ],
      ),
    );
  }

  /// Build detail row for transaction details
  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    Color? statusColor,
  }) {
    final theme = context.appTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: statusColor ?? theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
