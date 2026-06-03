import 'package:flutter/foundation.dart';

/// Transient UI state not tied to persisted data — e.g. the current step
/// index while a user works through the do-task flow.
class UiStateProvider extends ChangeNotifier {
  int _stepIndex = 0;
  int get stepIndex => _stepIndex;

  void resetSteps() {
    _stepIndex = 0;
    notifyListeners();
  }

  void nextStep(int total) {
    if (_stepIndex < total - 1) {
      _stepIndex++;
      notifyListeners();
    }
  }

  void prevStep() {
    if (_stepIndex > 0) {
      _stepIndex--;
      notifyListeners();
    }
  }
}
