import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/repeat.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../theme/custom_colors.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_button.dart';

/// Schedule a Task form (route '/new-schedule'): an iOS grouped list of
/// tappable setting rows for choosing the task, date, time, and repeat rule.
class NewScheduleScreen extends StatefulWidget {
  const NewScheduleScreen({super.key});

  @override
  State<NewScheduleScreen> createState() => _NewScheduleScreenState();
}

class _NewScheduleScreenState extends State<NewScheduleScreen> {
  String? _taskName;
  String _date = 'Today';
  String _time = '9:00 AM';
  RepeatInterval _repeat = RepeatInterval.none;

  @override
  Widget build(BuildContext context) {
    final tasks = context.read<TaskProvider>().tasks;
    final taskName = _taskName ?? tasks.first.name;

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: DefaultAppBar(
        title: 'Schedule Task',
        actionLabel: 'Save',
        onAction: () => Navigator.pop(context),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _card([
            _settingRow(
              title: 'Task',
              value: taskName,
              onTap: () => _pickTask(tasks),
            ),
            _settingRow(
              title: 'Date',
              value: _date,
              onTap: () => Navigator.pushNamed(context, '/todo-pickers'),
            ),
            _settingRow(
              title: 'Time',
              value: _time,
              onTap: () => Navigator.pushNamed(context, '/todo-pickers'),
            ),
            _settingRow(
              title: 'Repeat',
              value: _repeat.label,
              onTap: _pickRepeat,
            ),
          ]),
          const SizedBox(height: 24),
          DefaultButton(
            label: 'Add to Calendar',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  /// Wraps grouped rows in a rounded white card with 0.5px separators.
  Widget _card(List<Widget> rows) {
    final children = <Widget>[];
    for (var i = 0; i < rows.length; i++) {
      children.add(rows[i]);
      if (i < rows.length - 1) {
        children.add(
          const Divider(
            height: 0.5,
            thickness: 0.5,
            indent: 16,
            color: CustomColors.separator,
          ),
        );
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColors.separator, width: 0.5),
      ),
      child: Column(children: children),
    );
  }

  Widget _settingRow({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: CustomColors.primaryText, fontSize: 16),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: CustomColors.secondaryText,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: CustomColors.chevron),
        ],
      ),
      onTap: onTap,
    );
  }

  void _pickTask(List<Task> tasks) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: CustomColors.background,
      builder: (sheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              for (final task in tasks)
                ListTile(
                  title: Text(task.name),
                  onTap: () {
                    setState(() => _taskName = task.name);
                    Navigator.pop(sheetContext);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _pickRepeat() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: CustomColors.background,
      builder: (sheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              for (final interval in RepeatInterval.values)
                RadioListTile<RepeatInterval>(
                  title: Text(interval.label),
                  value: interval,
                  groupValue: _repeat,
                  activeColor: CustomColors.accentBlue,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _repeat = value);
                    }
                    Navigator.pop(sheetContext);
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
