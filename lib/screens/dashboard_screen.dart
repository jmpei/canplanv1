import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../theme/custom_colors.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_bottom_bar.dart';
import '../widgets/default_button.dart';

/// Home screen (route '/'): a welcoming hub linking to the main areas of the
/// app, with live counts pulled from [TaskProvider].
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final taskCount = provider.tasks.length;
    final categoryCount = provider.categories.length;
    final todayCount = provider.scheduleOn(DateTime.now()).length;

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const DefaultAppBar(title: 'CanPlan', showBack: false),
      bottomNavigationBar: const DefaultBottomBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/canassistLogo.png',
                  height: 64,
                  errorBuilder: (context, error, stackTrace) => const Text(
                    'CanPlan',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: CustomColors.primaryText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _DashboardCard(
                icon: Icons.list,
                label: 'My Tasks',
                subtitle: '$taskCount tasks',
                onTap: () => Navigator.pushNamed(context, '/all-tasks'),
              ),
              const SizedBox(height: 12),
              _DashboardCard(
                icon: Icons.folder,
                label: 'Categories',
                subtitle: '$categoryCount categories',
                onTap: () => Navigator.pushNamed(context, '/categories'),
              ),
              const SizedBox(height: 12),
              _DashboardCard(
                icon: Icons.calendar_today,
                label: 'To-Do / Calendar',
                subtitle: '$todayCount due today',
                onTap: () => Navigator.pushNamed(context, '/calendar'),
              ),
              const SizedBox(height: 12),
              _DashboardCard(
                icon: Icons.event,
                label: 'Schedule a Task',
                onTap: () => Navigator.pushNamed(context, '/new-schedule'),
              ),
              const SizedBox(height: 32),
              DefaultButton(
                label: 'New Task',
                icon: Icons.add,
                onPressed: () => Navigator.pushNamed(context, '/new-task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Large tappable grouped-style row: leading icon, label (+ optional subtitle),
/// trailing chevron.
class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColors.groupedBackground,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: [
              Icon(icon, color: CustomColors.accentBlue, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.primaryText,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: CustomColors.secondaryText,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: CustomColors.chevron,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
