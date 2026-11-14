import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../themes/app_colors.dart';

/// Cores de faixa. Toda faixa tem ponteira: preta nas coloridas e vermelha
/// na faixa preta.
enum BeltColor {
  white(AppColors.beltWhite, AppColors.beltBlack),
  blue(AppColors.beltBlue, AppColors.beltBlack),
  purple(AppColors.beltPurple, AppColors.beltBlack),
  brown(AppColors.beltBrown, AppColors.beltBlack),
  black(AppColors.beltBlack, AppColors.accent);

  const BeltColor(this.color, this.tip);

  final Color color;
  final Color tip;
}

/// Uma faixa de jiu-jitsu desenhada como barra com ponteira.
class Belt extends StatelessWidget {
  const Belt({
    super.key,
    required this.belt,
    this.width = 30,
    this.height = 8,
    this.stripes = 0,
  });

  final BeltColor belt;
  final double width, height;

  /// Graus brancos sobre a ponteira (usado no símbolo da marca).
  final int stripes;

  @override
  Widget build(BuildContext context) {
    // Em faixas compridas a ponteira acompanha a altura (como na faixa real),
    // em vez de crescer com a largura e virar um bloco.
    final tipWidth = math.min(width * 0.27, height * 4);
    final endGap = math.min(width * 0.09, height * 1.2);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: belt.color,
        borderRadius: BorderRadius.circular(height * 0.25),
        border: belt == BeltColor.black
            ? Border.all(color: AppColors.line, width: 1)
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          const Spacer(),
          Container(
            width: tipWidth,
            color: belt.tip,
            child: stripes == 0
                ? null
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i = 0; i < stripes; i++)
                        Container(
                            width: tipWidth * 0.11, color: AppColors.text),
                    ],
                  ),
          ),
          SizedBox(width: endGap),
        ],
      ),
    );
  }
}

/// Símbolo da marca: faixa preta, ponteira vermelha e dois graus.
class BrandBelt extends StatelessWidget {
  const BrandBelt({super.key, this.width = 64});

  final double width;

  @override
  Widget build(BuildContext context) => Belt(
        belt: BeltColor.black,
        width: width,
        height: width * 0.16,
        stripes: width >= 100 ? 2 : 0,
      );
}
