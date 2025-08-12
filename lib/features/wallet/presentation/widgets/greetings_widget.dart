import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/extensions/media_query_extension.dart';
import 'package:payora/core/extensions/theme_extension.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/index.dart';

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return Container(
      width: context.appSize.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (abCtx, abState) {
              final aVerifiedUser = authBloc.states<AuthVerifiedUser>();

              return RichText(
                text: TextSpan(
                  text: '${context.l10n.walletGreetingsTitle}, ',
                  style: context.appTextTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      text: '${aVerifiedUser?.user?.details.firstname}',
                      style: context.appTextTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.appColors.primary,
                      ),
                    ),
                  ],
                ),
              );
            },
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
