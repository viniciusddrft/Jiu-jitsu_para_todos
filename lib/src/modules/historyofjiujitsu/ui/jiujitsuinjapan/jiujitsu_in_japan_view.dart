import 'package:material_ui/material_ui.dart';

import '../../../../shared/l10n/app_localizations.dart';
import '../components/history_article.dart';

class JiujitsuInJapanView extends StatelessWidget {
  const JiujitsuInJapanView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return HistoryArticle(
      chapter: 1,
      tag: l10n.history_japan_tag,
      title: l10n.button_jiujitsu_in_japao,
      paragraphs: [
        l10n.text_jiujitsu_in_japan_paragraph1,
        l10n.text_jiujitsu_in_japan_paragraph2,
        l10n.text_jiujitsu_in_japan_paragraph3,
        l10n.text_jiujitsu_in_japan_paragraph4,
        l10n.text_jiujitsu_in_japan_paragraph5,
        l10n.text_jiujitsu_in_japan_paragraph6,
        l10n.text_jiujitsu_in_japan_paragraph7,
      ],
      nextTitle: l10n.button_jiujitsu_in_india,
      nextRoute: '/historyojiujitsu/jiujitsuinindia',
    );
  }
}
