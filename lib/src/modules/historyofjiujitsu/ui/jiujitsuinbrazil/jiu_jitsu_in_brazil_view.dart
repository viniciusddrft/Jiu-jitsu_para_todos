import 'package:material_ui/material_ui.dart';

import '../../../../shared/l10n/app_localizations.dart';
import '../components/history_article.dart';

class JiujitsuinBrazilPage extends StatelessWidget {
  const JiujitsuinBrazilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return HistoryArticle(
      chapter: 3,
      tag: l10n.history_brazil_tag,
      title: l10n.button_jiujitsu_in_brazil,
      paragraphs: [
        l10n.text_jiujitsu_in_brazil_paragraph1,
        l10n.text_jiujitsu_in_brazil_paragraph2,
        l10n.text_jiujitsu_in_brazil_paragraph3,
      ],
    );
  }
}
