// ignore_for_file: lines_longer_than_80_chars, document_ignores

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:payora/core/extensions/num_extension.dart';
import 'package:payora/core/shared/widgets/bottom_navbar/index.dart';
import 'package:payora/features/send_money/domain/entities/transaction.dart';

/// Bottom sheet widget for displaying transaction results
class TransactionResultBottomSheet extends StatelessWidget {
  const TransactionResultBottomSheet({
    required this.isSuccess,
    this.transaction,
    this.errorMessage,
    super.key,
  });

  final bool isSuccess;
  final Transaction? transaction;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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

          if (isSuccess)
            _buildSuccessContent(context)
          else
            _buildErrorContent(context),

          // Bottom padding for safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  /// Build success content
  Widget _buildSuccessContent(BuildContext context) {
    final theme = Theme.of(context);
    final bnBloc = context.read<BottomNavbarBloc>();

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
          transaction != null
              ? 'Successfully sent ₱${transaction!.amount.withComma} to ${transaction!.recipient}'
              : 'Your transaction has been completed successfully.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            height: 1.5,
          ),
        ),

        const SizedBox(height: 32),

        // Transaction details card (if transaction is provided)
        if (transaction != null) ...[
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
                  transaction!.recipient,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  context,
                  'Amount',
                  '₱${transaction!.amount.withComma}',
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  context,
                  'Time',
                  transaction!.time,
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
        ],

        // Action buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go('/transactions');
                  bnBloc.add(const BottomNavbarSetIndex(index: 1));
                },
                icon: const Icon(Icons.history_rounded),
                label: const Text('View History'),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go('/wallet');
                  bnBloc.add(const BottomNavbarSetIndex(index: 0));
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
    final theme = Theme.of(context);

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
          errorMessage ?? 'Something went wrong. Please try again.',
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
    final theme = Theme.of(context);

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
