import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/widgets/appbar/widget/appbar_widget.dart';
import 'package:payora/features/login/index.dart';
import 'package:payora/features/wallet/index.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState) {
        // Get user data from LoginBloc
        final userData = LoginBloc.defaultUserData;
        final cardNumber = LoginBloc.generatedCardNumber;

        // Use actual username if authenticated, otherwise use default name
        var userName = userData['name'] as String;
        if (loginState is LoginAuthenticatedState) {
          // You can customize this to show actual user name
          userName = loginState.username == LoginBloc.defaultUsername
              ? LoginBloc.defaultUserName
              : loginState.username;
        }

        return Scaffold(
          appBar: AppbarWidget(
            icon: const Icon(Icons.wallet),
            title: context.l10n.bottomNavbarItemWallet,
          ),
          body: Container(
            width: context.appSize.width,
            height: context.appSize.height,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GreetingsWidget(name: userName),
                const SizedBox(height: 8),
                WalletCardWidget(
                  name: userName,
                  cardNumber: cardNumber,
                ),
                const SizedBox(height: 24),
                const WalletActionsWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
