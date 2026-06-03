/// A single ordered step inside a [Task].
///
/// UI skeleton: [useRecording] / image are display-only; no real audio or
/// camera is wired. [imageAsset] is an asset path under `assets/images/`.
class TaskStep {
  final String id;
  final int order;
  final String text;
  final String? imageAsset;
  final bool useRecording;

  const TaskStep({
    required this.id,
    required this.order,
    required this.text,
    this.imageAsset,
    this.useRecording = false,
  });
}
