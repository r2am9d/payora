import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/index.dart';
import 'package:payora/features/wallet/presentation/bloc/wallet_bloc.dart';

class WalletCardWidget extends StatelessWidget {
  const WalletCardWidget({
    super.key,
    this.name = 'PayWallet',
    this.cardNumber = 110110110110110,
  });

  final String name;
  final int cardNumber;

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final walletBloc = context.read<WalletBloc>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Positioned(
            top: -140,
            left: -160,
            child: Container(
              width: 420,
              height: 420,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.appColors.primary.withValues(alpha: 0.85),
              ),
            ),
          ),
          Container(
            width: context.appSize.width,
            height: context.appSize.height * 0.28,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: context.appColors.secondary),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.appTextTheme.headlineMedium?.copyWith(
                    color: context.appColors.surface,
                  ),
                ),
                Text(
                  '$cardNumber',
                  style: context.appTextTheme.bodyMedium?.copyWith(
                    color: context.appColors.surface.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  '${context.l10n.walletCardSubtitile}:',
                  style: context.appTextTheme.bodyMedium?.copyWith(
                    color: context.appColors.surface.withValues(alpha: 0.75),
                  ),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      previous is AuthVerifiedUser ||
                      current is AuthVerifiedUser,
                  builder: (abCtx, abState) {
                    return BlocBuilder<WalletBloc, WalletState>(
                      buildWhen: (previous, current) =>
                          previous is WalletVisibility ||
                          current is WalletVisibility,
                      builder: (walCtx, walState) {
                        final aVerifiedUser = authBloc
                            .states<AuthVerifiedUser>();
                        final wVisibility = walletBloc
                            .states<WalletVisibility>()!;

                        final balance = aVerifiedUser?.user?.details.balance;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '₱ ',
                                style: context.appTextTheme.headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: context.appColors.surface,
                                    ),
                                children: [
                                  TextSpan(
                                    text: wVisibility.visibility
                                        ? balance?.withComma
                                        : '* * * * * * * *',
                                    style: context.appTextTheme.headlineMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: context.appColors.surface,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: wVisibility.visibility
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              tooltip: wVisibility.visibility
                                  ? 'Hide balance'
                                  : 'Show balance',
                              onPressed: () {
                                walletBloc.add(
                                  WalletSetVisibility(
                                    visibility: !wVisibility.visibility,
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
