import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/shared/index.dart';
import 'package:payora/features/login/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (authCtx, authState) {
        final authLoading = authBloc.states<AuthLoading>();
        final authError = authBloc.states<AuthError>();

        // Handle loading state
        if (authState is AuthLoading && authLoading != null) {
          authLoading.loading
              ? LoadingDialog.show(context)
              : LoadingDialog.hide();
        }

        // Handle error state
        if (authState is AuthError &&
            authError != null &&
            authError.message.isNotEmpty) {
          LoadingDialog.hide();
          context.appScaffoldMsgr.hideCurrentSnackBar();
          context.appScaffoldMsgr.showSnackBar(
            SnackBar(
              content: Text(authError.message),
              backgroundColor: context.appColors.error,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
              margin: EdgeInsets.only(
                bottom: context.appMediaQuery.viewInsets.bottom + 16,
                left: 16,
                right: 16,
              ),
            ),
          );
        }
      },
      child: const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 48),

                // App Logo/Icon
                AppIconWidget(),

                SizedBox(height: 48),

                // Login Form
                LoginFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
