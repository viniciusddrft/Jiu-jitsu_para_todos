import 'package:material_ui/material_ui.dart';

/// Paleta da identidade "Tatame".
abstract final class AppColors {
  /// Fundo do app (tatame à noite).
  static const Color background = Color(0xff0D1017);

  /// Cartões e superfícies.
  static const Color surface = Color(0xff161B24);

  /// Superfícies elevadas (dentro de cartões, controles).
  static const Color surfaceHigh = Color(0xff1F2632);

  /// Linhas e bordas.
  static const Color line = Color(0xff2A3240);

  /// Texto principal (cor de kimono).
  static const Color text = Color(0xffF4F1EA);

  /// Texto de apoio.
  static const Color textSoft = Color(0xffC9CED8);

  /// Texto secundário / rótulos.
  static const Color textMuted = Color(0xffA3ABB9);

  /// Única cor de destaque: a ponteira vermelha da faixa preta.
  static const Color accent = Color(0xffE5484D);

  /// Feedback de acerto.
  static const Color success = Color(0xff3DD68C);
  static const Color successSurface = Color(0xff102A1C);
  static const Color errorSurface = Color(0xff2A1416);
  static const Color errorText = Color(0xffFF8A8D);

  // Faixas.
  static const Color beltWhite = Color(0xffF4F1EA);
  static const Color beltBlue = Color(0xff3E7BFA);
  static const Color beltPurple = Color(0xff8E5CF7);
  static const Color beltBrown = Color(0xff9A6440);
  static const Color beltBlack = Color(0xff050608);

  // Shimmer de carregamento.
  static const Color shimmerBase = surface;
  static const Color shimmerHighlight = surfaceHigh;
}
