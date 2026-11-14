import 'package:material_ui/material_ui.dart';
import 'package:video_player/video_player.dart';

import '../../../../../shared/l10n/app_localizations.dart';
import '../../../../../shared/themes/app_colors.dart';
import '../../../../../shared/themes/app_text_styles.dart';
import '../../../interactor/question_entity.dart';

/// Mídia da pergunta: imagem OU vídeo OU nada (nunca os dois).
/// Se por erro de cadastro vierem os dois, o vídeo tem prioridade.
class QuizMedia extends StatelessWidget {
  const QuizMedia({super.key, required this.question});

  final QuestionEntity question;

  static bool hasMedia(QuestionEntity q) =>
      (q.pathVideo?.isNotEmpty ?? false) || (q.pathImage?.isNotEmpty ?? false);

  @override
  Widget build(BuildContext context) {
    final video = question.pathVideo;
    final image = question.pathImage;
    if (video != null && video.isNotEmpty) return _QuizVideo(source: video);
    if (image != null && image.isNotEmpty) return _QuizImage(source: image);
    return const SizedBox.shrink();
  }
}

bool _isAsset(String source) => source.startsWith('assets/');

class _MediaFrame extends StatelessWidget {
  const _MediaFrame(
      {required this.label, required this.icon, required this.child});

  final String label;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ColoredBox(
          color: AppColors.surfaceHigh,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                child,
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xB80D1017),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, size: 14, color: AppColors.text),
                        const SizedBox(width: 6),
                        Text(label.toUpperCase(),
                            style: AppTextStyles.eyebrow(color: AppColors.text)
                                .copyWith(fontSize: 11)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _QuizImage extends StatelessWidget {
  const _QuizImage({required this.source});

  final String source;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final image = _isAsset(source)
        ? Image.asset(source, fit: BoxFit.cover)
        : Image.network(
            source,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, progress) => progress == null
                ? child
                : const Center(child: CircularProgressIndicator()),
            errorBuilder: (_, __, ___) => const Center(
                child: Icon(Icons.broken_image_outlined,
                    color: AppColors.textMuted)),
          );
    return _MediaFrame(
      label: l10n.quiz_media_image,
      icon: Icons.image_outlined,
      child: GestureDetector(
        onTap: () => showDialog<void>(
          context: context,
          builder: (_) => Dialog.fullscreen(
            backgroundColor: Colors.black,
            child: Stack(
              children: [
                Center(child: InteractiveViewer(child: image)),
                SafeArea(
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon:
                        const Icon(Icons.close_rounded, color: AppColors.text),
                  ),
                ),
              ],
            ),
          ),
        ),
        child: image,
      ),
    );
  }
}

class _QuizVideo extends StatefulWidget {
  const _QuizVideo({required this.source});

  final String source;

  @override
  State<_QuizVideo> createState() => _QuizVideoState();
}

class _QuizVideoState extends State<_QuizVideo> {
  late final VideoPlayerController _controller = _isAsset(widget.source)
      ? VideoPlayerController.asset(widget.source)
      : VideoPlayerController.networkUrl(Uri.parse(widget.source));
  bool _slow = false;

  @override
  void initState() {
    super.initState();
    _controller.initialize().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() =>
      _controller.value.isPlaying ? _controller.pause() : _controller.play();

  void _replay() {
    _controller.seekTo(Duration.zero);
    _controller.play();
  }

  void _toggleSlow() {
    setState(() => _slow = !_slow);
    _controller.setPlaybackSpeed(_slow ? 0.5 : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _MediaFrame(
          label: l10n.quiz_media_video,
          icon: Icons.videocam_outlined,
          child: ValueListenableBuilder<VideoPlayerValue>(
            valueListenable: _controller,
            builder: (context, value, _) {
              if (value.hasError) {
                return const Center(
                    child: Icon(Icons.videocam_off_outlined,
                        color: AppColors.textMuted));
              }
              if (!value.isInitialized) {
                return const Center(child: CircularProgressIndicator());
              }
              return GestureDetector(
                onTap: _togglePlay,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: SizedBox(
                        width: value.size.width,
                        height: value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    if (!value.isPlaying)
                      Center(
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                              color: AppColors.text, shape: BoxShape.circle),
                          child: const Icon(Icons.play_arrow_rounded,
                              size: 36, color: AppColors.background),
                        ),
                      ),
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          minHeight: 4,
                          value: value.duration.inMilliseconds == 0
                              ? 0
                              : value.position.inMilliseconds /
                                  value.duration.inMilliseconds,
                          color: AppColors.text,
                          backgroundColor: const Color(0x40F4F1EA),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _Pill(
                icon: Icons.replay_rounded,
                label: l10n.quiz_video_replay,
                onTap: _replay),
            const SizedBox(width: 8),
            _Pill(
                icon: Icons.slow_motion_video_rounded,
                label: l10n.quiz_video_slow,
                selected: _slow,
                onTap: _toggleSlow),
          ],
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) => Material(
        color: selected ? AppColors.text : AppColors.surface,
        shape: const StadiumBorder(),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon,
                    size: 16,
                    color: selected ? AppColors.background : AppColors.text),
                const SizedBox(width: 8),
                Text(label,
                    style: AppTextStyles.label(
                        size: 13,
                        weight: FontWeight.w500,
                        color:
                            selected ? AppColors.background : AppColors.text)),
              ],
            ),
          ),
        ),
      );
}
