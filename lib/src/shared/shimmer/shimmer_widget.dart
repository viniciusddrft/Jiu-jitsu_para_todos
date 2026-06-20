import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

/// Caixa de placeholder (sem animação própria).
///
/// O brilho deve ser fornecido por um único [Shimmer] ancestral que envolve
/// todas as caixas (ver `wallpapers_page.dart`), em vez de um
/// `AnimationController` por item. Assim há apenas um ticker e uma única
/// `ShaderMaskLayer` por frame, em vez de um por placeholder.
class ShimmerWidget extends StatelessWidget {
  /// Gradiente usado pelo [Shimmer] ancestral. Pré-computado uma única vez
  /// (as cores são `const`) para evitar realocar um `LinearGradient` a cada
  /// build. Usa 3 stops: com `TileMode.clamp` os trechos antes de 0.35 e
  /// depois de 0.65 ficam sólidos em `shimmerEffcetBackground`.
  static const Gradient shimmerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      AppColors.shimmerEffcetBackground,
      AppColors.shimmerEffcetHigh,
      AppColors.shimmerEffcetBackground,
    ],
    stops: <double>[0.35, 0.5, 0.65],
  );

  final double height, width;
  final ShapeBorder shapeBorder;

  const ShimmerWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.shapeBorder});

  const ShimmerWidget.retangular({
    super.key,
    required this.width,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular({
    super.key,
    required this.width,
    required this.height,
  }) : shapeBorder = const CircleBorder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
          shape: shapeBorder, color: AppColors.shimmerEffcetBackground),
    );
  }
}
