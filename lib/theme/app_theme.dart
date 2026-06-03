import 'package:flutter/material.dart';
import 'custom_colors.dart';

/// App-wide [ThemeData]. Body text uses NotoSansMono (bundled by the
/// original app); titles fall back to the platform UI font for an iOS feel.
class AppTheme {
  AppTheme._();

  static const String fontFamily = 'NotoSansMono';

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: CustomColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CustomColors.accentBlue,
        primary: CustomColors.accentBlue,
        brightness: Brightness.light,
      ),
      fontFamily: fontFamily,
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: CustomColors.barBackground,
        foregroundColor: CustomColors.primaryText,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: CustomColors.primaryText,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: CustomColors.separator,
        thickness: 0.5,
        space: 0.5,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: CustomColors.primaryText,
        displayColor: CustomColors.primaryText,
      ),
    );
  }
}
