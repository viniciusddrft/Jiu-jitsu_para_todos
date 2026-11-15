import 'package:material_ui/material_ui.dart';

import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';

/// Barra do topo: botão de voltar (ou fechar) + rótulo pequeno em caixa alta.
class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    this.eyebrow,
    this.trailing,
    this.close = false,
    this.onBack,
  });

  final String? eyebrow;
  final Widget? trailing;

  /// Mostra um "X" em vez da seta (para sair de fluxos como o quiz).
  final bool close;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final label = MaterialLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 12, 0),
      child: Row(
        children: [
          IconButton(
            tooltip: close ? label.closeButtonTooltip : label.backButtonTooltip,
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            icon: Icon(close ? Icons.close_rounded : Icons.arrow_back_rounded,
                color: AppColors.text),
          ),
          if (eyebrow != null)
            Expanded(
              child: Text(eyebrow!.toUpperCase(),
                  style: AppTextStyles.eyebrow(),
                  overflow: TextOverflow.ellipsis),
            )
          else
            const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Título grande da página em Barlow Condensed.
class PageHeading extends StatelessWidget {
  const PageHeading(this.text, {super.key, this.description, this.size = 46});

  final String text;
  final String? description;
  final double size;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text.toUpperCase(), style: AppTextStyles.display(size)),
            if (description != null) ...[
              const SizedBox(height: 12),
              Text(description!, style: AppTextStyles.body()),
            ],
          ],
        ),
      );
}
