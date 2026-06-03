import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../theme/custom_colors.dart';
import '../widgets/category_tile.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_bottom_bar.dart';

/// Categories list screen (route '/categories'): white grouped rows, one
/// [CategoryTile] per category with its task count, and a trailing
/// "＋ New Category" action row.
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final categories = provider.categories;

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: DefaultAppBar(
        title: 'Categories',
        actionLabel: 'Edit',
        onAction: () {},
      ),
      bottomNavigationBar: const DefaultBottomBar(),
      body: ListView(
        children: [
          for (final category in categories)
            CategoryTile(
              category: category,
              taskCount: provider.tasksInCategory(category.id).length,
              onTap: () => Navigator.pushNamed(context, '/all-tasks'),
            ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            leading: const Icon(Icons.add, color: CustomColors.accentBlue),
            title: const Text(
              'New Category',
              style: TextStyle(fontSize: 16, color: CustomColors.accentBlue),
            ),
            onTap: () => Navigator.pushNamed(context, '/new-category'),
          ),
        ],
      ),
    );
  }
}
