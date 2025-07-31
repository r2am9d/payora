import 'package:flutter/material.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/widgets/appbar/index.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        icon: const Icon(Icons.person),
        title: context.l10n.bottomNavbarItemProfile,
      ),
      body: const Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
