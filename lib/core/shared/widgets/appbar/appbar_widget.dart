import 'package:flutter/material.dart';
import 'package:payora/core/extensions/index.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    required this.title,
    required this.icon,
    this.showIcon = true,
    super.key,
  });

  final String title;
  final Icon icon;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.appColors.secondary,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            icon,
            const SizedBox(width: 16),
          ],
          Text(
            title,
            style: TextStyle(
              color: context.appColors.onPrimary,
            ),
          ),
        ],
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
