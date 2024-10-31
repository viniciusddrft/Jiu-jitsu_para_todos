import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import '../../../interactor/clock_interactor.dart';

class SetTimerWidget extends StatefulWidget {
  const SetTimerWidget({super.key, required this.clockInteractor});

  final ClockInteractor clockInteractor;

  @override
  State<SetTimerWidget> createState() => _SetTimerWidgetState();
}

class _SetTimerWidgetState extends State<SetTimerWidget> {
  final _pageControllerMinutes = PageController();
  final _pageControllerSeconds = PageController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return AlertDialog(
      backgroundColor: AppColors.background,
      title: Text(
        AppLocalizations.of(context)!.text_label_time_popup,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.35,
            width: size.width * 0.07,
            child: Column(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: size.width * 0.02,
                  onPressed: () => _pageControllerMinutes.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut),
                  icon: Icon(
                    Icons.keyboard_arrow_up,
                    size: size.height * 0.1,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                  child: PageView.builder(
                    controller: _pageControllerMinutes,
                    itemCount: 60,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => Center(
                      child: Text(
                        '$index',
                        style: GoogleFonts.ubuntu(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: size.width * 0.02,
                  onPressed: () => _pageControllerMinutes.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: size.height * 0.1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: Text(
              ':',
              style: GoogleFonts.ubuntu(fontSize: 30),
            ),
          ),
          SizedBox(
            height: size.height * 0.35,
            width: size.width * 0.07,
            child: Column(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: size.width * 0.02,
                  onPressed: () => _pageControllerSeconds.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut),
                  icon: Icon(
                    Icons.keyboard_arrow_up,
                    size: size.height * 0.1,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                  child: PageView.builder(
                    controller: _pageControllerSeconds,
                    itemCount: 60,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => Center(
                      child: Text(
                        '$index',
                        style: GoogleFonts.ubuntu(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: size.width * 0.02,
                  onPressed: () => _pageControllerSeconds.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: size.height * 0.1,
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
          child: Text(
            AppLocalizations.of(context)!.text_label_cancel_popup,
            style: GoogleFonts.ubuntu(fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.clockInteractor.setTime(_pageControllerMinutes.page!.toInt(),
                _pageControllerSeconds.page!.toInt());
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context)!.text_label_continue,
            style: GoogleFonts.ubuntu(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageControllerMinutes.dispose();
    _pageControllerSeconds.dispose();
    super.dispose();
  }
}
