import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/shimmer/shimmer_effect.dart';

import '../themes/app_colors.dart';

class ShimmerWidget extends StatelessWidget {
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
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerEffcetBackground,
      highlightColor: AppColors.shimmerEffcetHigh,
      period: const Duration(seconds: 3),
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
            shape: shapeBorder, color: AppColors.shimmerEffcetBackground),
      ),
    );
  }
}
