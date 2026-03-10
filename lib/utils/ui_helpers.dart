import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class UiHelpers {
  // Consistent spacing constants
  static const double horizontalPadding = 16.0;
  static const double verticalPadding = 8.0;
  static const double sectionSpacing = 16.0;
  static const double itemSpacing = 8.0;
  static const double cardBorderRadius = 12.0;

  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: horizontalPadding,
    vertical: verticalPadding,
  );

  static Divider get basicDivider => const Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
      );

  static Widget sectionHeader(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  static ThemeData get lightTheme => FlexThemeData.light(
        scheme: FlexScheme.outerSpace,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 20,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      );

  static ThemeData get darkTheme => FlexThemeData.dark(
        scheme: FlexScheme.outerSpace,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      );

  static TextStyle linkStyle(BuildContext context) {
    return TextStyle(
      color: linkColor(context),
    );
  }

  static Color linkColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }
}
