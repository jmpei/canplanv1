import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/schedule_instance.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../theme/custom_colors.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_bottom_bar.dart';

/// To-Do / Calendar screen (route '/calendar').
///
/// A horizontal strip of seven day chips (today-3 … today+3) lets the user
/// pick a day; below it shows that day's scheduled to-dos with status pills.
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  static const List<String> _weekdays = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
  ];
  static const List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _dateOnly(DateTime.now());
  }

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _weekdayAbbrev(DateTime d) => _weekdays[d.weekday - 1];

  /// Formats a time like '9:00 AM' without the intl package.
  String _formatTime(DateTime d) {
    final isPm = d.hour >= 12;
    var hour = d.hour % 12;
    if (hour == 0) hour = 12;
    final minute = d.minute.toString().padLeft(2, '0');
    return '$hour:$minute ${isPm ? 'PM' : 'AM'}';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final today = _dateOnly(DateTime.now());
    final days = List<DateTime>.generate(
      7,
      (i) => today.add(Duration(days: i - 3)),
    );
    final instances = provider.scheduleOn(_selectedDay);

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: DefaultAppBar(
        title: 'To-Do',
        actionLabel: 'Today',
        onAction: () => setState(() => _selectedDay = today),
      ),
      bottomNavigationBar: const DefaultBottomBar(),
      body: Column(
        children: [
          _buildDayStrip(days),
          _buildSelectedHeader(),
          const Divider(height: 0.5, color: CustomColors.separator),
          Expanded(
            child: instances.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    itemCount: instances.length,
                    separatorBuilder: (_, __) => const Divider(
                      height: 0.5,
                      indent: 76,
                      color: CustomColors.separator,
                    ),
                    itemBuilder: (context, i) =>
                        _buildTodoRow(provider, instances[i]),
                  ),
          ),
          _buildScheduleButton(),
        ],
      ),
    );
  }

  Widget _buildDayStrip(List<DateTime> days) {
    return SizedBox(
      height: 84,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        itemCount: days.length,
        itemBuilder: (context, i) {
          final day = days[i];
          final selected = _isSameDay(day, _selectedDay);
          return GestureDetector(
            onTap: () => setState(() => _selectedDay = day),
            child: Container(
              width: 48,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: selected ? CustomColors.accentBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weekdayAbbrev(day),
                    style: TextStyle(
                      fontSize: 12,
                      color: selected
                          ? Colors.white
                          : CustomColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${day.day}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color:
                          selected ? Colors.white : CustomColors.primaryText,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '${_months[_selectedDay.month - 1]} ${_selectedDay.day}, '
          '${_selectedDay.year}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: CustomColors.primaryText,
          ),
        ),
      ),
    );
  }

  Widget _buildTodoRow(TaskProvider provider, ScheduleInstance s) {
    final task = provider.taskById(s.taskId);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: _buildThumbnail(task),
      title: Text(
        task.name,
        style: const TextStyle(
          fontSize: 16,
          color: CustomColors.primaryText,
        ),
      ),
      subtitle: Text(
        _formatTime(s.dueDate),
        style: const TextStyle(
          fontSize: 13,
          color: CustomColors.secondaryText,
        ),
      ),
      trailing: _buildStatusPill(s.status),
    );
  }

  Widget _buildThumbnail(Task task) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 44,
        height: 44,
        child: task.imageAsset != null
            ? Image.asset(task.imageAsset!, fit: BoxFit.cover)
            : Container(
                color: CustomColors.placeholder,
                child: const Icon(
                  Icons.image_outlined,
                  color: CustomColors.secondaryText,
                  size: 22,
                ),
              ),
      ),
    );
  }

  Widget _buildStatusPill(ScheduleStatus status) {
    late final IconData icon;
    late final Color color;
    switch (status) {
      case ScheduleStatus.completed:
        icon = Icons.check_circle;
        color = CustomColors.success;
        break;
      case ScheduleStatus.skipped:
        icon = Icons.remove_circle_outline;
        color = CustomColors.secondaryText;
        break;
      case ScheduleStatus.postponed:
        icon = Icons.schedule;
        color = CustomColors.accentBlue;
        break;
      case ScheduleStatus.pending:
        icon = Icons.radio_button_unchecked;
        color = CustomColors.chevron;
        break;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          status.label,
          style: TextStyle(fontSize: 13, color: color),
        ),
        const SizedBox(width: 6),
        Icon(icon, color: color, size: 22),
      ],
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'No tasks scheduled',
        style: TextStyle(
          fontSize: 16,
          color: CustomColors.secondaryText,
        ),
      ),
    );
  }

  Widget _buildScheduleButton() {
    return SafeArea(
      top: false,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/new-schedule'),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: CustomColors.separator, width: 0.5),
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.add, color: CustomColors.accentBlue, size: 22),
              SizedBox(width: 8),
              Text(
                'Schedule a task',
                style: TextStyle(
                  fontSize: 16,
                  color: CustomColors.accentBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
