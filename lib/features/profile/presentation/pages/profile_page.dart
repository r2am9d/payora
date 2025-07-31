import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/widgets/appbar/index.dart';
import 'package:payora/core/shared/widgets/bottom_navbar/index.dart';
import 'package:payora/core/theme/index.dart';
import 'package:payora/features/login/index.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        icon: const Icon(Icons.person),
        title: context.l10n.bottomNavbarItemProfile,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 24),
            _buildProfileMenu(context),
            const SizedBox(height: 32),
            _buildLogoutSection(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// Build profile header with avatar and user info
  Widget _buildProfileHeader(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState) {
        // Get user data from LoginBloc
        final userData = LoginBloc.defaultUserData;
        final userName = userData['name'] as String;
        final userEmail = userData['email'] as String;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.appColors.primary,
                context.appColors.primary.withValues(alpha: 0.8),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
            child: Column(
              children: [
                // Avatar
                Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 58,
                        backgroundColor: Colors.grey.shade200,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: context.appColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // User name
                Text(
                  userName,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                // User email
                Text(
                  userEmail,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Build profile menu items
  Widget _buildProfileMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              final isDarkMode = themeState is ThemeLoaded
                  ? themeState.isDarkMode
                  : false;
              return _buildMenuSection(
                context,
                'Settings',
                [
                  _ProfileMenuItem(
                    icon: isDarkMode
                        ? Icons.dark_mode_rounded
                        : Icons.wb_sunny_rounded,
                    title: 'Application Theme',
                    subtitle: isDarkMode
                        ? 'Dark mode enabled'
                        : 'Light mode enabled',
                    onTap: () {
                      // This will be handled by the ThemeSwitch widget
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  /// Build menu section with title and items
  Widget _buildMenuSection(
    BuildContext context,
    String title,
    List<_ProfileMenuItem> items,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 12),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: context.appColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        Card(
          margin: EdgeInsets.zero,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == items.length - 1;

              return Column(
                children: [
                  _buildMenuItem(context, item),
                  if (!isLast)
                    Divider(
                      height: 1,
                      indent: 72,
                      color: context.appColors.outline.withValues(alpha: 0.2),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// Build individual menu item
  Widget _buildMenuItem(BuildContext context, _ProfileMenuItem item) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: context.appColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          item.icon,
          color: context.appColors.primary,
          size: 22,
        ),
      ),
      title: Text(
        item.title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: item.subtitle != null
          ? Text(
              item.subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: context.appColors.onSurface.withValues(alpha: 0.6),
              ),
            )
          : null,
      trailing: item.title == 'Application Theme'
          ? const ThemeSwitch()
          : Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: context.appColors.onSurface.withValues(alpha: 0.4),
            ),
      onTap: item.title == 'Application Theme' ? null : item.onTap,
    );
  }

  /// Build logout section
  Widget _buildLogoutSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.logout_rounded,
              color: Colors.red.shade600,
              size: 22,
            ),
          ),
          title: Text(
            'Logout',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.red.shade600,
            ),
          ),
          subtitle: Text(
            'Sign out of your account',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.appColors.onSurface.withValues(alpha: 0.6),
            ),
          ),
          onTap: () => _showLogoutDialog(context),
        ),
      ),
    );
  }

  /// Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to logout from your account?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout(context);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red.shade600,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  /// Perform logout action
  void _performLogout(BuildContext context) {
    // Use LoginBloc to handle logout
    context.read<LoginBloc>().add(const LoginLogoutEvent());
    context.read<BottomNavbarBloc>().add(const BottomNavbarSetIndex(index: 0));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Logged out successfully'),
        backgroundColor: context.appColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

/// Profile menu item data class
class _ProfileMenuItem {
  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
}
