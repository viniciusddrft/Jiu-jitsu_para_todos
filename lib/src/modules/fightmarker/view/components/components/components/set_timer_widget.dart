import 'package:flutter/material.dart';

import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

import '../../../../controller/clock_controller.dart';

class SetTimerWidget extends StatefulWidget {
  final MyClock myClock;
  const SetTimerWidget({super.key, required this.myClock});

  @override
  State<SetTimerWidget> createState() => _SetTimerWidgetState();
}

class _SetTimerWidgetState extends State<SetTimerWidget> {
  final PageController pageControllerMinutes = PageController();
  final PageController pageControllerSeconds = PageController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      title: const Text(
        'Tempo',
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 136,
            width: 50,
            child: Column(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 15,
                  onPressed: () => pageControllerMinutes.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut),
                  icon: const Icon(
                    Icons.keyboard_arrow_up,
                    size: 40,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: PageView.builder(
                    controller: pageControllerMinutes,
                    itemCount: 60,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => Center(
                      child: Text(
                        '$index',
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 15,
                  onPressed: () => pageControllerMinutes.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              ':',
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(
            height: 136,
            width: 50,
            child: Column(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 15,
                  onPressed: () => pageControllerSeconds.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut),
                  icon: const Icon(
                    Icons.keyboard_arrow_up,
                    size: 40,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: PageView.builder(
                    controller: pageControllerSeconds,
                    itemCount: 60,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => Center(
                      child: Text(
                        '$index',
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 15,
                  onPressed: () => pageControllerSeconds.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.myClock.setTime(pageControllerMinutes.page!.toInt(),
                pageControllerSeconds.page!.toInt());
            Navigator.pop(context);
          },
          child: const Text(
            'Salvar',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
