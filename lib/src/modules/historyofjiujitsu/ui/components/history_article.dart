import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../shared/components/app_card.dart';
import '../../../../shared/components/app_top_bar.dart';
import '../../../../shared/components/native_ad_slot.dart';
import '../../../../shared/l10n/app_localizations.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_styles.dart';

/// Leitura de um capítulo da história: rótulo, título, parágrafos, barra de
/// progresso da leitura e atalho para o próximo capítulo.
class HistoryArticle extends StatefulWidget {
  const HistoryArticle({
    super.key,
    required this.chapter,
    required this.tag,
    required this.title,
    required this.paragraphs,
    this.nextTitle,
    this.nextRoute,
  });

  final int chapter;
  final String tag, title;
  final List<String> paragraphs;
  final String? nextTitle, nextRoute;

  @override
  State<HistoryArticle> createState() => _HistoryArticleState();
}

class _HistoryArticleState extends State<HistoryArticle> {
  final _scroll = ScrollController();
  final _progress = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      final max = _scroll.position.maxScrollExtent;
      _progress.value = max <= 0 ? 1 : (_scroll.offset / max).clamp(0, 1);
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppTopBar(
              eyebrow:
                  '${l10n.button_history_of_jiujitsu_home_page} · 0${widget.chapter} / 03',
            ),
            ValueListenableBuilder<double>(
              valueListenable: _progress,
              builder: (_, value, __) => LinearProgressIndicator(
                value: value,
                minHeight: 2,
                color: AppColors.accent,
                backgroundColor: Colors.transparent,
              ),
            ),
            Expanded(
              child: ListView(
                controller: _scroll,
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                children: [
                  Text(widget.tag.toUpperCase(),
                      style: AppTextStyles.eyebrow(color: AppColors.accent)),
                  const SizedBox(height: 12),
                  Text(widget.title.toUpperCase(),
                      style: AppTextStyles.display(46)),
                  const SizedBox(height: 16),
                  const Divider(color: AppColors.line, height: 1),
                  const SizedBox(height: 18),
                  for (final paragraph in widget.paragraphs) ...[
                    Text(paragraph,
                        style: AppTextStyles.body(
                            size: 16,
                            height: 1.65,
                            color: const Color(0xffD9DDE4))),
                    const SizedBox(height: 16),
                  ],
                  if (widget.nextRoute != null) ...[
                    const SizedBox(height: 8),
                    AppCard(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      radius: 16,
                      onTap: () => context.replace(widget.nextRoute!),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.history_next,
                                    style: AppTextStyles.body(
                                        size: 12, color: AppColors.textMuted)),
                                Text(widget.nextTitle!.toUpperCase(),
                                    style: AppTextStyles.title(20)),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_rounded,
                              color: AppColors.text),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NativeAdSlot(),
    );
  }
}
