import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/extensions/theme_extension.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/widgets/bottom_navbar/index.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bnBloc = context.read<BottomNavbarBloc>();

    return BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
      buildWhen: (previous, current) =>
          previous is BottomNavbarIndex || current is BottomNavbarIndex,
      builder: (context, state) {
        final bnIndex = bnBloc.states<BottomNavbarIndex>()!;

        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.purple.shade100,
              ),
            ),
          ),
          child: SalomonBottomBar(
            currentIndex: bnIndex.index,
            onTap: (i) {
              bnBloc.add(BottomNavbarSetIndex(index: i));
            },
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.wallet),
                title: Text(context.l10n.bottomNavbarItemWallet),
                selectedColor: context.appColors.primary,
                activeIcon: const Icon(Icons.wallet),
                unselectedColor: context.appColors.onSurface.withValues(
                  alpha: 0.7,
                ),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.receipt_long),
                title: Text(context.l10n.bottomNavbarItemTransactions),
                selectedColor: context.appColors.primary,
                activeIcon: const Icon(Icons.receipt_long),
                unselectedColor: context.appColors.onSurface.withValues(
                  alpha: 0.7,
                ),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                title: Text(context.l10n.bottomNavbarItemProfile),
                selectedColor: context.appColors.primary,
                activeIcon: const Icon(Icons.person),
                unselectedColor: context.appColors.onSurface.withValues(
                  alpha: 0.7,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
