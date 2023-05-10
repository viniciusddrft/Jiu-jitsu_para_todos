import 'package:flutter/material.dart';

import '../../../../../shared/shimmer/shimmer_widget.dart';

class QuizLoadingWidget extends StatelessWidget {
  const QuizLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.07, bottom: size.height * 0.01),
          child: const ShimmerWidget.retangular(width: 175, height: 40),
        ),
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.07),
          child: const ShimmerWidget.retangular(width: 130, height: 40),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.03,
                    left: size.width * 0.07,
                    right: size.width * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerWidget.retangular(width: 350, height: 35),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.01,
                      ),
                      child: const ShimmerWidget.retangular(
                          width: 150, height: 35),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: size.height * 0.05),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ShimmerWidget.retangular(width: 280, height: 35),
                              ShimmerWidget.circular(width: 40, height: 35)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: size.height * 0.05),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ShimmerWidget.retangular(width: 280, height: 47),
                              ShimmerWidget.circular(width: 40, height: 40)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: size.height * 0.05),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ShimmerWidget.retangular(width: 280, height: 47),
                              ShimmerWidget.circular(width: 40, height: 40)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: size.height * 0.05),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ShimmerWidget.retangular(width: 280, height: 47),
                              ShimmerWidget.circular(width: 40, height: 40)
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
