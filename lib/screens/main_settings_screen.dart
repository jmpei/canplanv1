import 'package:flutter/material.dart';

import '../theme/custom_colors.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_bottom_bar.dart';

/// Main Settings screen (route '/settings').
///
/// An iOS-style grouped settings list: rounded white section cards, each row a
/// [ListTile] with a colored leading icon, a title, and a trailing chevron.
/// Every row is a UI-skeleton no-op that shows a SnackBar.
class MainSettingsScreen extends StatelessWidget {
  const MainSettingsScreen({super.key});

  void _showNotAvailable(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Not available in the UI skeleton')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.groupedBackground,
      appBar: const DefaultAppBar(title: 'Settings'),
      bottomNavigationBar: const DefaultBottomBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          _Section(
            header: 'Preferences',
            rows: [
              _SettingsRow(
                icon: Icons.palette,
                color: CustomColors.accentBlue,
                title: 'Interface',
                onTap: () => _showNotAvailable(context),
              ),
              _SettingsRow(
                icon: Icons.notifications,
                color: CustomColors.destructive,
                title: 'Notifications',
                onTap: () => _showNotAvailable(context),
              ),
              _SettingsRow(
                icon: Icons.record_voice_over,
                color: CustomColors.success,
                title: 'Audio & Speech',
                onTap: () => _showNotAvailable(context),
              ),
              _SettingsRow(
                icon: Icons.cloud,
                color: const Color(0xFF5AC8FA),
                title: 'iCloud Sync',
                onTap: () => _showNotAvailable(context),
              ),
            ],
          ),
          _Section(
            header: 'Progress',
            rows: [
              _SettingsRow(
                icon: Icons.bar_chart,
                color: const Color(0xFF5856D6),
                title: 'Statistics',
                onTap: () => _showNotAvailable(context),
              ),
              _SettingsRow(
                icon: Icons.emoji_events,
                color: CustomColors.homeGold,
                title: 'Achievements',
                onTap: () => _showNotAvailable(context),
              ),
            ],
          ),
          _Section(
            header: 'Help',
            rows: [
              _SettingsRow(
                icon: Icons.school,
                color: const Color(0xFFFF9500),
                title: 'Tutorial',
                onTap: () => _showNotAvailable(context),
              ),
              _SettingsRow(
                icon: Icons.feedback,
                color: const Color(0xFFFF2D55),
                title: 'Send Feedback',
                onTap: () => _showNotAvailable(context),
              ),
              _SettingsRow(
                icon: Icons.info,
                color: CustomColors.secondaryText,
                title: 'About',
                onTap: () => _showNotAvailable(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'CanPlan · UI Skeleton · v3.2.0',
              style: TextStyle(
                color: CustomColors.secondaryText,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A grouped section: an uppercase grey header above a rounded white card.
class _Section extends StatelessWidget {
  final String header;
  final List<_SettingsRow> rows;

  const _Section({required this.header, required this.rows});

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < rows.length; i++) {
      children.add(rows[i]);
      if (i != rows.length - 1) {
        children.add(
          const Padding(
            padding: EdgeInsets.only(left: 56),
            child: Divider(height: 0.5, thickness: 0.5, color: CustomColors.separator),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
          child: Text(
            header.toUpperCase(),
            style: const TextStyle(
              color: CustomColors.secondaryText,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 28),
          decoration: BoxDecoration(
            color: CustomColors.background,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: children),
        ),
      ],
    );
  }
}

/// A single settings row: rounded colored icon, title, trailing chevron.
class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback onTap;

  const _SettingsRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
      title: Text(
        title,
        style: const TextStyle(color: CustomColors.primaryText, fontSize: 16),
      ),
      trailing: const Icon(Icons.chevron_right, color: CustomColors.chevron),
    );
  }
}
