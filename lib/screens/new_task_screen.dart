import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/sample_data.dart';
import '../models/category.dart';
import '../providers/task_provider.dart';
import '../theme/custom_colors.dart';
import '../widgets/default_app_bar.dart';

/// New Task form (route '/new-task'): a photo placeholder, a name field,
/// an inline category picker (bottom sheet), and a sample list of steps with
/// an "Add Step" row. Pure UI skeleton — nothing is persisted.
class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TextEditingController _nameController = TextEditingController();
  Category _selectedCategory = SampleData.categories.first;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _pickCategory() {
    final categories = context.read<TaskProvider>().categories;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: CustomColors.background,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Select Category',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.primaryText,
                  ),
                ),
              ),
              const Divider(height: 0.5),
              for (final category in categories)
                ListTile(
                  title: Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: CustomColors.primaryText,
                    ),
                  ),
                  trailing: category.id == _selectedCategory.id
                      ? const Icon(Icons.check,
                          color: CustomColors.accentBlue)
                      : null,
                  onTap: () {
                    setState(() => _selectedCategory = category);
                    Navigator.pop(sheetContext);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: DefaultAppBar(
        title: 'New Task',
        actionLabel: 'Save',
        onAction: () => Navigator.pop(context),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Photo placeholder.
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: CustomColors.placeholder,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_camera_outlined,
                        size: 32, color: CustomColors.secondaryText),
                    SizedBox(height: 6),
                    Text(
                      'Add Photo',
                      style: TextStyle(
                        fontSize: 13,
                        color: CustomColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Name section.
          _sectionHeader('Name'),
          _groupedCard(
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Task name',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                hintStyle: TextStyle(color: CustomColors.secondaryText),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: CustomColors.primaryText,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Category section.
          _sectionHeader('Category'),
          _groupedCard(
            child: InkWell(
              onTap: _pickCategory,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedCategory.name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: CustomColors.primaryText,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right,
                        color: CustomColors.chevron),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Steps section.
          _sectionHeader('Steps'),
          _groupedCard(
            child: Column(
              children: [
                _stepRow('1. Fill the water tank'),
                const Divider(height: 0.5, indent: 12),
                _stepRow('2. Turn on the machine'),
                const Divider(height: 0.5, indent: 12),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/new-step'),
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: CustomColors.accentBlue),
                        SizedBox(width: 8),
                        Text(
                          'Add Step',
                          style: TextStyle(
                            fontSize: 16,
                            color: CustomColors.accentBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: CustomColors.secondaryText,
        ),
      ),
    );
  }

  Widget _groupedCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.groupedBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColors.separator, width: 0.5),
      ),
      child: child,
    );
  }

  Widget _stepRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: CustomColors.primaryText,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: CustomColors.chevron),
        ],
      ),
    );
  }
}
