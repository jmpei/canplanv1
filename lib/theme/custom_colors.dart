import 'package:flutter/material.dart';

/// Palette sampled from the real CanPlan app (v3.2.0).
///
/// The app is a light, iOS-style interface: white bars and rows, black
/// titles, system-blue actions, and a gold home button on the bottom bar.
class CustomColors {
  CustomColors._();

  static const Color background = Color(0xFFFFFFFF);
  static const Color groupedBackground = Color(0xFFF2F2F7);
  static const Color barBackground = Color(0xFFFFFFFF);

  static const Color primaryText = Color(0xFF000000);
  static const Color secondaryText = Color(0xFF8E8E93);

  static const Color accentBlue = Color(0xFF007AFF); // iOS system blue
  static const Color homeGold = Color(0xFFF5C518); // bottom-bar home button
  static const Color separator = Color(0xFFE0E0E0);
  static const Color chevron = Color(0xFFC7C7CC);
  static const Color placeholder = Color(0xFFD8D8DC);

  static const Color success = Color(0xFF34C759);
  static const Color destructive = Color(0xFFFF3B30);
}
