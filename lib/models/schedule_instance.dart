/// A concrete to-do: one occurrence of a [Task] due on a date.
enum ScheduleStatus { pending, completed, skipped, postponed }

extension ScheduleStatusLabel on ScheduleStatus {
  String get label {
    switch (this) {
      case ScheduleStatus.pending:
        return 'To do';
      case ScheduleStatus.completed:
        return 'Done';
      case ScheduleStatus.skipped:
        return 'Skipped';
      case ScheduleStatus.postponed:
        return 'Postponed';
    }
  }
}

class ScheduleInstance {
  final String id;
  final String taskId;
  final DateTime dueDate;
  final ScheduleStatus status;

  const ScheduleInstance({
    required this.id,
    required this.taskId,
    required this.dueDate,
    this.status = ScheduleStatus.pending,
  });
}
