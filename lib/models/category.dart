/// A task category (e.g. Kitchen, Laundry, Personal).
class Category {
  final String id;
  final String name;
  final String? imageAsset;

  const Category({
    required this.id,
    required this.name,
    this.imageAsset,
  });
}
