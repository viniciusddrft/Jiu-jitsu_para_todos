import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/shimmer/shimmer_widget.dart';

class WallpapersLoadingWidget extends StatelessWidget {
  const WallpapersLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GridView.builder(
      itemCount: 18,
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.03),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ShimmerWidget(
        width: 100,
        height: 100,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
