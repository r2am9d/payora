import 'package:flutter/material.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/shared/index.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.appColors.primary,
            context.appColors.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.appColors.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: context.appColors.onPrimary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: context.appColors.onPrimary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.person,
              size: 40,
              color: context.appColors.onPrimary,
            ),
          ),

          const SizedBox(height: 16),

          // User Name
          Text(
            user.details.fullName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: context.appColors.onPrimary,
            ),
          ),

          const SizedBox(height: 4),

          // Username
          Text(
            '@${user.username}',
            style: TextStyle(
              fontSize: 16,
              color: context.appColors.onPrimary.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
