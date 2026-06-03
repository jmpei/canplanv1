import 'package:flutter/material.dart';
import '../theme/custom_colors.dart';
import '../widgets/default_app_bar.dart';

/// Modal-style form for creating a new category: a photo placeholder, a name
/// field, and a grid of selectable icon chips. Pure UI — nothing persists.
class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({super.key});

  @override
  State<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  final TextEditingController _nameController = TextEditingController();
  int _selectedIcon = 0;

  static const List<IconData> _icons = [
    Icons.kitchen,
    Icons.local_laundry_service,
    Icons.person,
    Icons.home,
    Icons.work,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.medical_services,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: DefaultAppBar(
        title: 'New Category',
        actionLabel: 'Save',
        onAction: () => Navigator.pop(context),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(child: _photoPlaceholder()),
          const SizedBox(height: 24),
          _sectionLabel('Name'),
          const SizedBox(height: 8),
          _nameField(),
          const SizedBox(height: 24),
          _sectionLabel('Choose an icon'),
          const SizedBox(height: 12),
          _iconGrid(),
        ],
      ),
    );
  }

  Widget _photoPlaceholder() {
    return GestureDetector(
      onTap: () {}, // no-op
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: CustomColors.placeholder,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.photo_camera,
              size: 40,
              color: CustomColors.secondaryText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add Photo',
            style: TextStyle(
              color: CustomColors.accentBlue,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: CustomColors.secondaryText,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _nameField() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.groupedBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColors.separator, width: 0.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: _nameController,
        decoration: const InputDecoration(
          hintText: 'Category name',
          hintStyle: TextStyle(color: CustomColors.secondaryText),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _iconGrid() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(_icons.length, (i) {
        final bool selected = i == _selectedIcon;
        return GestureDetector(
          onTap: () => setState(() => _selectedIcon = i),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: selected
                  ? CustomColors.accentBlue
                  : CustomColors.groupedBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? CustomColors.accentBlue
                    : CustomColors.separator,
                width: 0.5,
              ),
            ),
            child: Icon(
              _icons[i],
              size: 28,
              color: selected
                  ? CustomColors.background
                  : CustomColors.primaryText,
            ),
          ),
        );
      }),
    );
  }
}
