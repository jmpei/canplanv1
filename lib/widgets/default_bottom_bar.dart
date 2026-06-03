import 'package:flutter/material.dart';
import '../theme/custom_colors.dart';

/// Bottom bar mirroring the real app: a gold rounded home button on the
/// left, help (?) and settings (gear) icons on the right.
class DefaultBottomBar extends StatelessWidget {
  const DefaultBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CustomColors.barBackground,
        border: Border(top: BorderSide(color: CustomColors.separator, width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _HomeButton(
              onTap: () => Navigator.of(context)
                  .popUntil((r) => r.isFirst),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.waving_hand, color: CustomColors.homeGold, size: 28),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.help_outline, color: CustomColors.secondaryText),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: CustomColors.secondaryText),
              onPressed: () => Navigator.of(context).pushNamed('/settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  final VoidCallback onTap;
  const _HomeButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColors.homeGold,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Icon(Icons.home, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}
