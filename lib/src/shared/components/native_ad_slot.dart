import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../plugins/admob/admob_interactor.dart';
import '../themes/app_colors.dart';
import 'admob_native_ad.dart';

/// Espaço do anúncio nativo, integrado ao visual (cartão "Lona").
/// O layout interno vem de `android/app/src/main/res/layout/list_tile_native_ad.xml`.
class NativeAdSlot extends StatelessWidget {
  const NativeAdSlot({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        top: false,
        child: Container(
          height: 76,
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.line),
          ),
          clipBehavior: Clip.antiAlias,
          child: AdmobNativeAd(
            factoryId: 'listTile',
            adUnitId: inject<AdmobInteractor>().nativeAdUnitIDListTile,
          ),
        ),
      );
}
