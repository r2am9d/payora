import 'package:flutter/material.dart';
import 'package:payora/core/extensions/media_query_extension.dart';
import 'package:payora/core/extensions/theme_extension.dart';
import 'package:payora/core/l10n/l10n.dart';

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({
    super.key,
    this.name = 'User',
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.appSize.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: '${context.l10n.walletGreetingsTitle}, ',
              style: context.appTextTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.normal,
              ),
              children: [
                TextSpan(
                  text: '$name!',
                  style: context.appTextTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            context.l10n.walletGreetingsSubtitle,
            style: context.appTextTheme.bodySmall?.copyWith(
              color: context.appColors.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
