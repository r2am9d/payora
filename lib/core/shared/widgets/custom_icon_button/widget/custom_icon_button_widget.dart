import 'package:flutter/material.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/extensions/string_extension.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final Icon icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: context.appColors.onSurface.withValues(
                alpha: 0.05,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.zero,
            ),
            onPressed: onPressed,
            child: icon,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label.withNewlines,
          textAlign: TextAlign.center,
          style: context.appTextTheme.bodySmall?.copyWith(
            color: context.appColors.onSurface.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }
}
