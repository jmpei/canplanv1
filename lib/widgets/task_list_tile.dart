import 'package:flutter/material.dart';
import '../models/task.dart';
import '../theme/custom_colors.dart';

/// A white row: rounded leading thumbnail, task name, trailing chevron.
class TaskListTile extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final Widget? trailing;

  const TaskListTile({super.key, required this.task, this.onTap, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 48,
              height: 48,
              child: task.imageAsset != null
                  ? Image.asset(task.imageAsset!, fit: BoxFit.cover)
                  : Container(color: CustomColors.placeholder),
            ),
          ),
          title: Text(
            task.name,
            style: const TextStyle(fontSize: 16, color: CustomColors.primaryText),
          ),
          trailing: trailing ??
              const Icon(Icons.chevron_right, color: CustomColors.chevron),
          onTap: onTap,
        ),
        const Divider(height: 0.5, indent: 16),
      ],
    );
  }
}
