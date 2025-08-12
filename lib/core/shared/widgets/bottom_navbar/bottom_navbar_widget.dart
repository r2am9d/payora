import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.appColors.primary.withValues(
              alpha: 0.25,
            ),
          ),
        ),
      ),
      child: SalomonBottomBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(index);
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.wallet),
            activeIcon: const Icon(Icons.wallet),
            title: Text(
              context.l10n.bottomNavbarItemWallet,
              style: context.appTextTheme.labelMedium,
            ),
            selectedColor: context.appColors.primary,
            unselectedColor: context.appColors.primary.withValues(
              alpha: 0.7,
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.receipt_long),
            activeIcon: const Icon(Icons.receipt_long),
            title: Text(
              context.l10n.bottomNavbarItemTransaction,
              style: context.appTextTheme.labelMedium,
            ),
            selectedColor: context.appColors.primary,
            unselectedColor: context.appColors.primary.withValues(
              alpha: 0.7,
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            activeIcon: const Icon(Icons.person),
            title: Text(
              context.l10n.bottomNavbarItemProfile,
              style: context.appTextTheme.labelMedium,
            ),
            selectedColor: context.appColors.primary,
            unselectedColor: context.appColors.primary.withValues(
              alpha: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}
