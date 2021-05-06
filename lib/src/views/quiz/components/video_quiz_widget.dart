import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoQuiz extends StatefulWidget {
  final String videoPath;
  VideoQuiz({@required this.videoPath});
  @override
  _VideoQuizState createState() => _VideoQuizState();
}

class _VideoQuizState extends State<VideoQuiz> {
  VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.asset(widget.videoPath);
    controller.addListener(() {
      setState(() {});
    });

    controller.setLooping(true);
    controller.initialize().then((_) => setState(() {}));
    controller.play();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(
      controller: controller,
    );
  }
}

//------------------------------------------------------------------------------
class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  VideoPlayerWidget({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) =>
      controller != null && controller.value.isInitialized
          ? Padding(
              padding: EdgeInsets.only(
                  right: 30.w, left: 30.w, top: 10.h, bottom: 10.h),
              child: Container(
                width: 360.w,
                height: 250.h,
                alignment: Alignment.center,
                child: buildVideo(),
              ),
            )
          : Container(
              height: 250.h,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

  Widget buildVideo() => Stack(
        children: [
          buildVideoPlayer(),
          Positioned.fill(
            child: BasicOverlayWidget(
              controller: controller,
            ),
          )
        ],
      );

  Widget buildVideoPlayer() => AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      );
}

class BasicOverlayWidget extends StatefulWidget {
  final VideoPlayerController controller;

  const BasicOverlayWidget({@required this.controller});

  @override
  _BasicOverlayWidgetState createState() => _BasicOverlayWidgetState();
}

class _BasicOverlayWidgetState extends State<BasicOverlayWidget> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => widget.controller.value.isPlaying
            ? widget.controller.pause()
            : widget.controller.play(),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            buildplay(),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: buildIndicator(),
            ),
          ],
        ),
      );

  Widget buildIndicator() =>
      VideoProgressIndicator(widget.controller, allowScrubbing: true);

  Widget buildplay() => widget.controller.value.isPlaying
      ? Container()
      : GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => widget.controller.value.isPlaying
              ? widget.controller.pause()
              : widget.controller.play(),
          child: Container(
            alignment: Alignment.center,
            child: Icon(
              Icons.play_arrow,
              size: 80.sp,
            ),
          ),
        );
}
