import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/extensions/num_extension.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/features/wallet/presentation/bloc/bloc/wallet_bloc.dart';

class WalletCardWidget extends StatelessWidget {
  const WalletCardWidget({
    super.key,
    this.name = 'PayWallet',
    this.cardNumber = 110110110110110,
    this.balance = 1234.56,
  });

  final String name;
  final int cardNumber;
  final double balance;

  @override
  Widget build(BuildContext context) {
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
            height: context.appSize.height * 0.27,
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
                    color: context.appColors.surface.withValues(alpha: 0.75),
                  ),
                ),
                Text(
                  '$cardNumber',
                  style: context.appTextTheme.bodySmall?.copyWith(
                    color: context.appColors.surface.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  '${context.l10n.walletCardSubtitile}:',
                  style: context.appTextTheme.bodySmall?.copyWith(
                    color: context.appColors.surface.withValues(alpha: 0.75),
                  ),
                ),
                BlocBuilder<WalletBloc, WalletState>(
                  buildWhen: (previous, current) =>
                      previous is WalletVisibility ||
                      current is WalletVisibility,
                  builder: (context, state) {
                    final walletVisibility = walletBloc
                        .states<WalletVisibility>()!;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '₱ ',
                            style: context.appTextTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.normal,
                              color: context.appColors.onSurface.withValues(
                                alpha: 0.85,
                              ),
                            ),
                            children: [
                              TextSpan(
                                text: walletVisibility.visibility
                                    ? balance.withComma
                                    : '* * * * * * * *',
                                style: context.appTextTheme.headlineLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: context.appColors.onSurface
                                          .withValues(
                                            alpha: 0.85,
                                          ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: walletVisibility.visibility
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          tooltip: walletVisibility.visibility
                              ? 'Hide balance'
                              : 'Show balance',
                          onPressed: () {
                            walletBloc.add(
                              WalletSetVisibility(
                                visibility: !walletVisibility.visibility,
                              ),
                            );
                          },
                        ),
                      ],
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
