import 'package:flutter/foundation.dart' hide Category;

import '../data/sample_data.dart';
import '../models/category.dart';
import '../models/task.dart';
import '../models/schedule_instance.dart';

/// Holds the app's data. UI-skeleton: backed by in-memory [SampleData].
/// Replace the seed lists with a real repository later — the API stays the same.
class TaskProvider extends ChangeNotifier {
  final List<Category> _categories = List.of(SampleData.categories);
  final List<Task> _tasks = List.of(SampleData.tasks);
  final List<ScheduleInstance> _schedule = SampleData.schedule();

  List<Category> get categories => List.unmodifiable(_categories);
  List<Task> get tasks => List.unmodifiable(_tasks);
  List<ScheduleInstance> get schedule => List.unmodifiable(_schedule);

  Task taskById(String id) => _tasks.firstWhere((t) => t.id == id);

  Category categoryById(String id) =>
      _categories.firstWhere((c) => c.id == id);

  List<Task> tasksInCategory(String categoryId) =>
      _tasks.where((t) => t.categoryId == categoryId).toList();

  /// To-do instances due on [day] (date-only comparison).
  List<ScheduleInstance> scheduleOn(DateTime day) => _schedule
      .where((s) =>
          s.dueDate.year == day.year &&
          s.dueDate.month == day.month &&
          s.dueDate.day == day.day)
      .toList();
}
