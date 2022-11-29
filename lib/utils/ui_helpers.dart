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

  static TextStyle linkStyle(BuildContext context) {
    return TextStyle(
      color: linkColor(context),
    );
  }

  static Color linkColor(BuildContext context) {
    return Theme.of(context).toggleableActiveColor;
  }

  static Widget header(BuildContext context, String text) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headline5,
        )
      ],
    );
  }
}
