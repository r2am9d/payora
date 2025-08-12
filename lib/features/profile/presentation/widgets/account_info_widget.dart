import 'package:flutter/material.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/shared/index.dart';

class AccountInfoWidget extends StatelessWidget {
  const AccountInfoWidget({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.appColors.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.appColors.onSurface,
            ),
          ),

          const SizedBox(height: 16),

          _buildInfoRow(
            context,
            Icons.person_outline,
            'Full Name',
            user.details.fullName,
          ),

          const SizedBox(height: 12),

          _buildInfoRow(
            context,
            Icons.phone_outlined,
            'Mobile',
            user.details.mobile,
          ),

          const SizedBox(height: 12),

          _buildInfoRow(
            context,
            Icons.account_balance_wallet_outlined,
            'Current Balance',
            '₱${user.details.balance.withComma}',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: context.appColors.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: context.appColors.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.appColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
