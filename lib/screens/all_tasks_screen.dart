import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../theme/custom_colors.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_bottom_bar.dart';
import '../widgets/task_list_tile.dart';

/// The All Tasks list (route '/all-tasks'): white rows of task thumbnails with
/// names and chevrons, plus an "Add Task" row at the bottom.
class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().tasks;

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: DefaultAppBar(
        title: 'All Tasks',
        actionLabel: 'Edit',
        onAction: () {},
      ),
      bottomNavigationBar: const DefaultBottomBar(),
      body: ListView(
        children: [
          for (final task in tasks)
            TaskListTile(
              task: task,
              onTap: () => Navigator.pushNamed(
                context,
                '/do-task-start',
                arguments: task.id,
              ),
            ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            leading: const Icon(Icons.add, color: CustomColors.accentBlue),
            title: const Text(
              'Add Task',
              style: TextStyle(fontSize: 16, color: CustomColors.accentBlue),
            ),
            onTap: () => Navigator.pushNamed(context, '/new-task'),
          ),
          const Divider(height: 0.5, indent: 16),
        ],
      ),
    );
  }
}
