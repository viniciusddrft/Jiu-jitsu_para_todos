import 'package:material_ui/material_ui.dart';

import '../../../../shared/l10n/app_localizations.dart';
import '../components/history_article.dart';

class JiujitsuInIndiaView extends StatelessWidget {
  const JiujitsuInIndiaView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return HistoryArticle(
      chapter: 2,
      tag: l10n.history_india_tag,
      title: l10n.button_jiujitsu_in_india,
      paragraphs: [
        l10n.text_origin_of_jiujitsu_india_paragraph1,
        l10n.text_origin_of_jiujitsu_india_paragraph2,
        l10n.text_origin_of_jiujitsu_india_paragraph3,
        l10n.text_origin_of_jiujitsu_india_paragraph4,
        l10n.text_origin_of_jiujitsu_india_paragraph5,
      ],
      nextTitle: l10n.button_jiujitsu_in_brazil,
      nextRoute: '/historyojiujitsu/jiujitsuinbrazil',
    );
  }
}
