import 'package:flutter/material.dart';
import '../theme/custom_colors.dart';

/// White iOS-style top bar: centered title, optional back chevron on the
/// left, optional blue text action on the right.
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final String? actionLabel;
  final VoidCallback? onAction;

  const DefaultAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.actionLabel,
    this.onAction,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      leading: showBack && Navigator.canPop(context)
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              color: CustomColors.accentBlue,
              onPressed: () => Navigator.maybePop(context),
            )
          : null,
      actions: [
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              actionLabel!,
              style: const TextStyle(
                color: CustomColors.accentBlue,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0.5),
        child: Divider(height: 0.5),
      ),
    );
  }
}
