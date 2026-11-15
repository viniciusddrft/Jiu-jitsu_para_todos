import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';

/// Tipografia "Tatame": Barlow Condensed (títulos, números — sempre em caixa
/// alta, aplicada no texto com `toUpperCase()`) e Inter (texto corrido).
abstract final class AppTextStyles {
  static TextStyle display(double size, {Color color = AppColors.text}) =>
      GoogleFonts.barlowCondensed(
        fontSize: size,
        fontWeight: FontWeight.w800,
        height: 0.92,
        color: color,
      );

  static TextStyle title(double size, {Color color = AppColors.text}) =>
      GoogleFonts.barlowCondensed(
        fontSize: size,
        fontWeight: FontWeight.w700,
        height: 1.05,
        color: color,
      );

  static TextStyle eyebrow({Color color = AppColors.textMuted}) =>
      GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.7,
        color: color,
      );

  static TextStyle body({
    double size = 15,
    Color color = AppColors.textSoft,
    FontWeight weight = FontWeight.w400,
    double height = 1.55,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        height: height,
        color: color,
      );

  static TextStyle label({
    double size = 15,
    Color color = AppColors.text,
    FontWeight weight = FontWeight.w600,
  }) =>
      GoogleFonts.inter(fontSize: size, fontWeight: weight, color: color);
}
