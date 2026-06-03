import 'package:flutter/material.dart';

import '../models/repeat.dart';
import '../theme/custom_colors.dart';
import '../widgets/default_app_bar.dart';

/// To-Do pickers (route '/todo-pickers'): date, time, and repeat choosers
/// shown together as iOS grouped white cards, with local selection state.
class TodoPickersScreen extends StatefulWidget {
  const TodoPickersScreen({super.key});

  @override
  State<TodoPickersScreen> createState() => _TodoPickersScreenState();
}

class _TodoPickersScreenState extends State<TodoPickersScreen> {
  late DateTime _selectedDate;
  String _selectedTime = '9:00 AM';
  RepeatInterval _selectedRepeat = RepeatInterval.none;

  /// Half-hour times from 7:00 AM to 9:00 PM, built without intl.
  late final List<String> _times = _buildTimes();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
  }

  List<String> _buildTimes() {
    final times = <String>[];
    for (var minutes = 7 * 60; minutes <= 21 * 60; minutes += 30) {
      final hour24 = minutes ~/ 60;
      final minute = minutes % 60;
      final period = hour24 < 12 ? 'AM' : 'PM';
      var hour12 = hour24 % 12;
      if (hour12 == 0) hour12 = 12;
      final mm = minute.toString().padLeft(2, '0');
      times.add('$hour12:$mm $period');
    }
    return times;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: DefaultAppBar(
        title: 'Schedule',
        actionLabel: 'Done',
        onAction: () => Navigator.pop(context),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _sectionHeader('Date'),
          _card([
            CalendarDatePicker(
              initialDate: _selectedDate,
              firstDate: DateTime(today.year, today.month, today.day)
                  .subtract(const Duration(days: 30)),
              lastDate: DateTime(today.year, today.month, today.day)
                  .add(const Duration(days: 365)),
              onDateChanged: (date) => setState(() => _selectedDate = date),
            ),
          ]),
          _sectionHeader('Time'),
          _card([
            SizedBox(
              height: 150,
              child: ListView.separated(
                itemCount: _times.length,
                separatorBuilder: (_, _) => const Divider(
                  height: 0.5,
                  thickness: 0.5,
                  indent: 16,
                  color: CustomColors.separator,
                ),
                itemBuilder: (context, index) {
                  final time = _times[index];
                  final selected = time == _selectedTime;
                  return ListTile(
                    dense: true,
                    title: Text(
                      time,
                      style: TextStyle(
                        fontSize: 16,
                        color: selected
                            ? CustomColors.accentBlue
                            : CustomColors.primaryText,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    trailing: selected
                        ? const Icon(Icons.check,
                            color: CustomColors.accentBlue)
                        : null,
                    onTap: () => setState(() => _selectedTime = time),
                  );
                },
              ),
            ),
          ]),
          _sectionHeader('Repeat'),
          _card([
            for (var i = 0; i < RepeatInterval.values.length; i++) ...[
              if (i > 0)
                const Divider(
                  height: 0.5,
                  thickness: 0.5,
                  indent: 16,
                  color: CustomColors.separator,
                ),
              _repeatRow(RepeatInterval.values[i]),
            ],
          ]),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _repeatRow(RepeatInterval interval) {
    final selected = interval == _selectedRepeat;
    return ListTile(
      title: Text(
        interval.label,
        style: const TextStyle(color: CustomColors.primaryText, fontSize: 16),
      ),
      trailing: selected
          ? const Icon(Icons.check, color: CustomColors.accentBlue)
          : null,
      onTap: () => setState(() => _selectedRepeat = interval),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: CustomColors.secondaryText,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  /// Wraps grouped content in a rounded white card with a hairline border.
  Widget _card(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: CustomColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColors.separator, width: 0.5),
      ),
      child: Column(children: children),
    );
  }
}
