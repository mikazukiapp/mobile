import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();

    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }

    buffer.write(hexString.replaceFirst('#', ''));

    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String calculateComplementaryColorFromHex(String hexString) {
    final buffer = StringBuffer();

    buffer.write(hexString.replaceFirst('#', ''));

    int color = int.parse(buffer.toString(), radix: 16);
    int whiteColor = 0xFFFFFF;
    int complementary = whiteColor - color;

    buffer.clear();

    return '#${complementary.toRadixString(16).padLeft(6, '0')}';
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
