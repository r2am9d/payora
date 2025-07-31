import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/shared/widgets/loading_dialog/widget/loading_dialog.dart';
import 'package:payora/features/login/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // Handle authentication state changes
        if (state is LoginSubmittingState) {
          LoadingDialog.show(context);
        } else if (state is LoginAuthenticatedState) {
          LoadingDialog.hide();
          // Navigation will be handled by router automatically
        } else if (state is LoginErrorState) {
          LoadingDialog.hide();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.appColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  _buildWelcomeSection(context),
                  const SizedBox(height: 60),
                  _buildLoginForm(context, _formKey),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build welcome section with logo and title
  Widget _buildWelcomeSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // App Logo
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.appColors.primary,
                context.appColors.primary.withValues(alpha: 0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: context.appColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.account_balance_wallet_rounded,
            size: 60,
            color: context.appColors.onPrimary,
          ),
        ),

        const SizedBox(height: 32),

        // Welcome Text
        Text(
          'Welcome to Payora',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.appColors.onSurface,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Sign in to continue to your account',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: context.appColors.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  /// Build login form with username and password
  Widget _buildLoginForm(
    BuildContext context,
    GlobalKey<FormBuilderState> formKey,
  ) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          // Username Field
          FormBuilderTextField(
            name: 'username',
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username',
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: context.appColors.primary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: context.appColors.primary,
                  width: 2,
                ),
              ),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(3),
            ]),
          ),

          const SizedBox(height: 20),

          // Password Field
          FormBuilderTextField(
            name: 'password',
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                color: context.appColors.primary,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: context.appColors.onSurface.withValues(alpha: 0.7),
                ),
                tooltip: _isPasswordVisible ? 'Hide password' : 'Show password',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: context.appColors.primary,
                  width: 2,
                ),
              ),
            ),
            textInputAction: TextInputAction.done,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(6),
            ]),
          ),

          const SizedBox(height: 24),

          // Login Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: () => _handleLogin(context, _formKey),
              style: FilledButton.styleFrom(
                backgroundColor: context.appColors.primary,
                foregroundColor: context.appColors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login_rounded,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Handle login form submission
  void _handleLogin(BuildContext context, GlobalKey<FormBuilderState> formKey) {
    // Dismiss keyboard and remove focus from all form fields
    FocusScope.of(context).unfocus();

    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      final values = formKey.currentState?.value;

      final username = values?['username'] as String?;
      final password = values?['password'] as String?;

      // Use LoginBloc to handle login
      context.read<LoginBloc>().add(
        LoginSubmitEvent(
          username: username ?? '',
          password: password ?? '',
        ),
      );
    }
  }
}
