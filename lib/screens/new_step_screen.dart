import 'package:flutter/material.dart';

import '../theme/custom_colors.dart';
import '../widgets/default_app_bar.dart';

/// New Step form (route '/new-step'): a photo/video placeholder, a multiline
/// instruction field, and two toggle rows (record audio, play sound when
/// reached). Pure UI skeleton — nothing is persisted.
class NewStepScreen extends StatefulWidget {
  const NewStepScreen({super.key});

  @override
  State<NewStepScreen> createState() => _NewStepScreenState();
}

class _NewStepScreenState extends State<NewStepScreen> {
  final TextEditingController _instructionController = TextEditingController();
  bool _recordAudio = false;
  bool _playSound = false;

  @override
  void dispose() {
    _instructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: DefaultAppBar(
        title: 'New Step',
        actionLabel: 'Save',
        onAction: () => Navigator.pop(context),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Photo / video placeholder.
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: CustomColors.placeholder,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_camera_outlined,
                        size: 34, color: CustomColors.secondaryText),
                    SizedBox(height: 6),
                    Text(
                      'Add Photo / Video',
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

          // Instruction section.
          _sectionHeader('Instruction'),
          _groupedCard(
            child: TextField(
              controller: _instructionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Describe this step…',
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

          // Audio section.
          _sectionHeader('Audio'),
          _groupedCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.mic_none,
                      color: CustomColors.primaryText),
                  title: const Text(
                    'Record audio for this step',
                    style: TextStyle(
                      fontSize: 16,
                      color: CustomColors.primaryText,
                    ),
                  ),
                  trailing: Switch(
                    value: _recordAudio,
                    activeThumbColor: CustomColors.accentBlue,
                    onChanged: (value) =>
                        setState(() => _recordAudio = value),
                  ),
                ),
                const Divider(height: 0.5, indent: 16),
                ListTile(
                  leading: const Icon(Icons.volume_up_outlined,
                      color: CustomColors.primaryText),
                  title: const Text(
                    'Play sound when reached',
                    style: TextStyle(
                      fontSize: 16,
                      color: CustomColors.primaryText,
                    ),
                  ),
                  trailing: Switch(
                    value: _playSound,
                    activeThumbColor: CustomColors.accentBlue,
                    onChanged: (value) => setState(() => _playSound = value),
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
}
