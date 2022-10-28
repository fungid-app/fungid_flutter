import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class UiHelpers {
  static Divider get basicDivider => const Divider(
        height: 5,
        indent: 10,
        endIndent: 10,
        thickness: 1,
      );

  static ThemeData get lightTheme => FlexThemeData.light(
        scheme: FlexScheme.outerSpace,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 20,
        appBarOpacity: 0.95,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      );

  static ThemeData get darkTheme => FlexThemeData.dark(
        scheme: FlexScheme.outerSpace,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarOpacity: 0.90,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      );
}