import 'package:flutter/material.dart';

const Color accentColor = Color(0xFFD22F27);
const Color onAccentColor = Colors.white;
MaterialColor primaryColor = createMaterialColor(Colors.black);
const Color onPrimaryColor = Colors.white;
const Color backgroundColor = Color(0xFFEDEFF7);
const Color onBackgroundColor = Colors.black;
const Color outlineColor = Color(0xFFE0E0E0);

MaterialColor createMaterialColor(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;
  const lowDivisor = 6;
  const highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  Map<int, Color> swatch = {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };

  return MaterialColor(color.value, swatch);
}
