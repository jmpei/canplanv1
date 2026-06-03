import 'task_step.dart';

/// A task the user can perform, made of ordered [steps].
///
/// [mood] mirrors the original app's per-task mood marker (0 = none,
/// 1 = sad, 2 = plain, 3 = happy). [imageAsset] is the list thumbnail.
class Task {
  final String id;
  final String name;
  final String categoryId;
  final String? imageAsset;
  final int mood;
  final bool sampleTask;
  final List<TaskStep> steps;

  const Task({
    required this.id,
    required this.name,
    required this.categoryId,
    this.imageAsset,
    this.mood = 0,
    this.sampleTask = false,
    this.steps = const [],
  });
}
