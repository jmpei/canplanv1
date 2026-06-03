import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/sample_data.dart';
import '../models/task_step.dart';
import '../providers/task_provider.dart';
import '../providers/ui_state_provider.dart';
import '../theme/custom_colors.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_button.dart';

/// The step-by-step guided flow (route '/do-task-step'): walks through one
/// [TaskStep] at a time with a progress bar, a large step image, the step
/// text in a card, and a bottom control bar (previous / speak / skip / next).
/// On the final step the Next button reveals a celebratory finish state.
///
/// The current step index lives in [UiStateProvider] so it survives rebuilds
/// and is shared with the rest of the do-task flow.
class DoTaskStepScreen extends StatelessWidget {
  const DoTaskStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String?;
    final task = id != null
        ? context.read<TaskProvider>().taskById(id)
        : SampleData.tasks.first;

    final ui = context.watch<UiStateProvider>();
    final total = task.steps.length;
    final i = ui.stepIndex.clamp(0, total - 1);
    final step = task.steps[i];
    final isLast = i == total - 1;

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: DefaultAppBar(title: task.name),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ProgressHeader(current: i + 1, total: total),
              const SizedBox(height: 20),
              Expanded(child: _StepBody(step: step)),
              const SizedBox(height: 16),
              _ControlBar(
                isFirst: i == 0,
                isLast: isLast,
                onPrev: () => context.read<UiStateProvider>().prevStep(),
                onSpeak: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Reading step aloud'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                },
                onSkip: () =>
                    context.read<UiStateProvider>().nextStep(total),
                onNext: () {
                  if (isLast) {
                    _showFinish(context);
                  } else {
                    context.read<UiStateProvider>().nextStep(total);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFinish(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: CustomColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _FinishSheet(),
    );
  }
}

/// Linear progress bar plus "Step X of Y" caption.
class _ProgressHeader extends StatelessWidget {
  final int current;
  final int total;

  const _ProgressHeader({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: total == 0 ? 0 : current / total,
            minHeight: 8,
            backgroundColor: CustomColors.placeholder,
            valueColor:
                const AlwaysStoppedAnimation<Color>(CustomColors.accentBlue),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Step $current of $total',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: CustomColors.secondaryText,
          ),
        ),
      ],
    );
  }
}

/// Large rounded step image above the step instruction card.
class _StepBody extends StatelessWidget {
  final TaskStep step;

  const _StepBody({required this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: step.imageAsset != null
                ? Image.asset(
                    step.imageAsset!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: CustomColors.placeholder,
                    child: const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 64,
                        color: CustomColors.secondaryText,
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: CustomColors.groupedBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            step.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              height: 1.35,
              fontWeight: FontWeight.w600,
              color: CustomColors.primaryText,
            ),
          ),
        ),
      ],
    );
  }
}

/// Bottom row of large round controls: previous, speak (central), skip, next.
class _ControlBar extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final VoidCallback onPrev;
  final VoidCallback onSpeak;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  const _ControlBar({
    required this.isFirst,
    required this.isLast,
    required this.onPrev,
    required this.onSpeak,
    required this.onSkip,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _RoundControl(
          icon: Icons.arrow_back,
          onTap: isFirst ? null : onPrev,
        ),
        _RoundControl(
          icon: Icons.volume_up,
          onTap: onSpeak,
          large: true,
          filled: true,
        ),
        _RoundControl(
          icon: Icons.skip_next,
          onTap: isLast ? null : onSkip,
        ),
        _RoundControl(
          icon: isLast ? Icons.check : Icons.arrow_forward,
          onTap: onNext,
          tint: isLast ? CustomColors.success : CustomColors.accentBlue,
        ),
      ],
    );
  }
}

/// A single circular control button. [filled] paints a solid blue disc with a
/// white glyph (used for the central speak button); otherwise it is a tinted
/// outlined disc that greys out when [onTap] is null.
class _RoundControl extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool large;
  final bool filled;
  final Color tint;

  const _RoundControl({
    required this.icon,
    required this.onTap,
    this.large = false,
    this.filled = false,
    this.tint = CustomColors.accentBlue,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final size = large ? 72.0 : 56.0;
    final color = enabled ? tint : CustomColors.placeholder;

    return Material(
      color: filled ? color : CustomColors.background,
      shape: CircleBorder(
        side: filled
            ? BorderSide.none
            : BorderSide(color: color, width: 1.5),
      ),
      elevation: filled && enabled ? 2 : 0,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            size: large ? 36 : 26,
            color: filled ? Colors.white : color,
          ),
        ),
      ),
    );
  }
}

/// Celebratory finish state: gold star, happy face, "All done!" and a Finish
/// button that returns to the first route.
class _FinishSheet extends StatelessWidget {
  const _FinishSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/goldStar.png',
            width: 96,
            height: 96,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.star,
              size: 96,
              color: CustomColors.homeGold,
            ),
          ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/images/happyface.png',
            width: 72,
            height: 72,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.sentiment_very_satisfied,
              size: 72,
              color: CustomColors.success,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'All done!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: CustomColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Great job finishing every step.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: CustomColors.secondaryText,
            ),
          ),
          const SizedBox(height: 28),
          DefaultButton(
            label: 'Finish',
            icon: Icons.check_circle,
            color: CustomColors.success,
            onPressed: () =>
                Navigator.of(context).popUntil((r) => r.isFirst),
          ),
        ],
      ),
    );
  }
}
