import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/sample_data.dart';
import '../providers/task_provider.dart';
import '../providers/ui_state_provider.dart';
import '../theme/custom_colors.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_button.dart';

/// The intro page for the do-task flow (route '/do-task-start'): a large task
/// image, the task name and step count, and a green "Start" button that resets
/// the step index and pushes into the guided steps.
class DoTaskStartScreen extends StatelessWidget {
  const DoTaskStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String?;
    final task = id != null
        ? context.read<TaskProvider>().taskById(id)
        : SampleData.tasks.first;

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: DefaultAppBar(title: task.name),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: task.imageAsset != null
                    ? Image.asset(
                        task.imageAsset!,
                        width: 240,
                        height: 240,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 240,
                        height: 240,
                        color: CustomColors.placeholder,
                      ),
              ),
              const SizedBox(height: 32),
              Text(
                task.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.primaryText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${task.steps.length} steps',
                style: const TextStyle(
                  fontSize: 16,
                  color: CustomColors.secondaryText,
                ),
              ),
              const SizedBox(height: 40),
              DefaultButton(
                label: 'Start',
                icon: Icons.play_arrow,
                color: CustomColors.success,
                onPressed: () {
                  context.read<UiStateProvider>().resetSteps();
                  Navigator.pushNamed(
                    context,
                    '/do-task-step',
                    arguments: task.id,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
