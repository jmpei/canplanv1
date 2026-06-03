import 'package:flutter/material.dart';
import '../models/category.dart';
import '../theme/custom_colors.dart';

/// A white row for a category: rounded leading image, name, trailing chevron.
class CategoryTile extends StatelessWidget {
  final Category category;
  final int taskCount;
  final VoidCallback? onTap;

  const CategoryTile({
    super.key,
    required this.category,
    this.taskCount = 0,
    this.onTap,
  });

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
              width: 44,
              height: 44,
              child: category.imageAsset != null
                  ? Image.asset(category.imageAsset!, fit: BoxFit.cover)
                  : Container(color: CustomColors.placeholder),
            ),
          ),
          title: Text(category.name,
              style: const TextStyle(fontSize: 16, color: CustomColors.primaryText)),
          subtitle: Text('$taskCount tasks',
              style: const TextStyle(color: CustomColors.secondaryText, fontSize: 13)),
          trailing: const Icon(Icons.chevron_right, color: CustomColors.chevron),
          onTap: onTap,
        ),
        const Divider(height: 0.5, indent: 16),
      ],
    );
  }
}
