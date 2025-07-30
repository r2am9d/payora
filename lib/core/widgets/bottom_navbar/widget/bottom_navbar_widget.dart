import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/widgets/bottom_navbar/index.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
                title: Text(l10n.bottomNavbarItemWallet),
                selectedColor: Colors.purple,
                activeIcon: const Icon(Icons.wallet),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.receipt_long),
                title: Text(l10n.bottomNavbarItemTransactions),
                selectedColor: Colors.purple,
                activeIcon: const Icon(Icons.receipt_long),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                title: Text(l10n.bottomNavbarItemProfile),
                selectedColor: Colors.purple,
                activeIcon: const Icon(Icons.person),
              ),
            ],
          ),
        );
      },
    );
  }
}
