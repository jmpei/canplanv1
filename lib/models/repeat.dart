/// Recurrence rule attached to a scheduled task.
enum RepeatInterval { none, daily, weekly, monthly }

extension RepeatIntervalLabel on RepeatInterval {
  String get label {
    switch (this) {
      case RepeatInterval.none:
        return 'Never';
      case RepeatInterval.daily:
        return 'Daily';
      case RepeatInterval.weekly:
        return 'Weekly';
      case RepeatInterval.monthly:
        return 'Monthly';
    }
  }
}

class Repeat {
  final RepeatInterval interval;
  final DateTime startDate;
  final DateTime? endDate;

  const Repeat({
    this.interval = RepeatInterval.none,
    required this.startDate,
    this.endDate,
  });
}
