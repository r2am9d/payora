import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/keys/app_key.dart';
import 'package:payora/features/transaction/index.dart';

/// Bottom sheet widget for displaying transaction results
class TransactionResultWidget extends StatelessWidget {
  const TransactionResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final txnBloc = context.read<TransactionBloc>();

    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (txnCtx, txnState) {
        final txnList = txnBloc.states<TransactionList>()!;
        final txnError = txnBloc.states<TransactionError>()!;

        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (txnError.message.isEmpty)
                _buildSuccessContent(
                  context,
                  txnList.transactions.first,
                )
              else
                _buildErrorContent(context),

              // Bottom padding for safe area
              SizedBox(height: context.appMediaQuery.padding.bottom),
            ],
          ),
        );
      },
    );
  }

  /// Build success content
  Widget _buildSuccessContent(
    BuildContext context,
    Transaction transaction,
  ) {
    final theme = context.appTheme;
    final formState = AppKey.sendMoneyFormKey.currentState;

    return Column(
      children: [
        // Success icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(
            Icons.check_circle_rounded,
            size: 50,
            color: Colors.green.shade600,
          ),
        ),

        const SizedBox(height: 24),

        // Success title
        Text(
          'Transaction Successful!',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 12),

        // Success message
        Text(
          'Successfully sent ₱${transaction.amount.withComma} to ${transaction.recipient}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            height: 1.5,
          ),
        ),

        const SizedBox(height: 32),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildDetailRow(
                context,
                'Recipient',
                transaction.recipient,
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                context,
                'Amount',
                '₱${transaction.amount.withComma}',
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                context,
                'Time',
                transaction.timestamp.formattedDate,
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                context,
                'Status',
                'Completed',
                valueColor: Colors.green.shade600,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: context.appColors.inverseSurface,
                ),
                onPressed: () {
                  formState?.reset();
                  Navigator.of(context).pop();
                  context.go('/transaction');
                },
                icon: const Icon(Icons.history_rounded),
                label: const Text('View History'),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: FilledButton.icon(
                onPressed: () {
                  formState?.reset();
                  Navigator.of(context).pop();
                  context.go('/wallet');
                },
                icon: const Icon(Icons.check_rounded),
                label: const Text('Done'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build error content
  Widget _buildErrorContent(BuildContext context) {
    final theme = context.appTheme;

    return Column(
      children: [
        // Error icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(
            Icons.error_rounded,
            size: 50,
            color: Colors.red.shade600,
          ),
        ),

        const SizedBox(height: 24),

        // Error title
        Text(
          'Transaction Failed',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 12),

        // Error message
        Text(
          'Something went wrong. Please try again.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            height: 1.5,
          ),
        ),

        const SizedBox(height: 32),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close_rounded),
                label: const Text('Cancel'),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Try Again'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build detail row
  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
  }) {
    final theme = context.appTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor ?? theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
