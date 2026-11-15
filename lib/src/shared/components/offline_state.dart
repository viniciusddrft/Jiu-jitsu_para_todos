import 'package:material_ui/material_ui.dart';

import '../l10n/app_localizations.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';

/// Estado de erro de rede.
class OfflineState extends StatelessWidget {
  const OfflineState({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                  color: AppColors.surface, shape: BoxShape.circle),
              child: const Icon(Icons.wifi_off_rounded,
                  size: 32, color: AppColors.textMuted),
            ),
            const SizedBox(height: 20),
            Text(l10n.text_offline.toUpperCase(),
                style: AppTextStyles.display(32), textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(l10n.text_try_again),
                style: TextButton.styleFrom(foregroundColor: AppColors.text),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
