import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../shared/components/app_top_bar.dart';
import '../../../shared/components/belt.dart';
import '../../../shared/l10n/app_localizations.dart';
import '../../../shared/l10n/locale_app.dart';
import '../../../shared/plugins/app_info/app_info.dart';
import '../../../shared/plugins/in_app_review/in_app_review_interactor.dart';
import '../../../shared/themes/app_colors.dart';
import '../../../shared/themes/app_icons_languages_path.dart';
import '../../../shared/themes/app_text_styles.dart';
import '../interactor/settings_interactor.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, this.appVersion});

  /// Permite exibir a versão fornecida pelo host em previews e testes.
  /// No Android, o padrão continua sendo a versão instalada via JNI.
  final String? appVersion;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _settingsInteractor = inject<SettingsInteractor>();
  final _locale = inject<LocaleInteractor>();

  @override
  void dispose() {
    _settingsInteractor.dispose();
    super.dispose();
  }

  void _select(Locale locale, String icon) =>
      _settingsInteractor.saveLanguage({'locale': locale, 'icon': icon});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  const AppTopBar(),
                  PageHeading(l10n.title_appbar_settings_page),
                  _SectionLabel(l10n.button_language_settings_page),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ValueListenableBuilder<Locale>(
                      valueListenable: _locale,
                      builder: (_, locale, __) {
                        final isPt = locale.languageCode == 'pt';
                        return Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: _LanguageOption(
                                  label: l10n.text_brazilian_portuguese,
                                  selected: isPt,
                                  onTap: () => _select(const Locale('pt', 'BR'),
                                      AppIconsLanguages.brasil),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: _LanguageOption(
                                  label: l10n.text_english_united_states,
                                  selected: !isPt,
                                  onTap: () => _select(const Locale('en', 'US'),
                                      AppIconsLanguages.unitedStates),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  _SectionLabel(l10n.text_about_the_app),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        minTileHeight: 60,
                        leading: const Icon(Icons.star_outline_rounded,
                            color: AppColors.accent),
                        title: Text(l10n.text_rate_the_app,
                            style:
                                AppTextStyles.label(weight: FontWeight.w500)),
                        trailing: const Icon(Icons.chevron_right_rounded,
                            color: AppColors.textMuted),
                        onTap: () =>
                            inject<InAppReviewInteractor>().openStoreListing(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  const BrandBelt(),
                  const SizedBox(height: 10),
                  Text(l10n.title_appbar_home_page.toUpperCase(),
                      style: AppTextStyles.display(18)),
                  const SizedBox(height: 6),
                  Text(
                    '${l10n.text_version} ${widget.appVersion ?? AppInfo.version}',
                    style: AppTextStyles.body(
                        size: 13, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 10),
        child: Text(text.toUpperCase(), style: AppTextStyles.eyebrow()),
      );
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: selected ? AppColors.text : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Semantics(
            selected: selected,
            button: true,
            child: SizedBox(
              height: 52,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (selected) ...[
                    const Icon(Icons.check_rounded,
                        size: 18, color: AppColors.background),
                    const SizedBox(width: 6),
                  ],
                  Flexible(
                    child: Text(label,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.label(
                            size: 14,
                            weight:
                                selected ? FontWeight.w600 : FontWeight.w500,
                            color: selected
                                ? AppColors.background
                                : AppColors.text)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
