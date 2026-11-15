import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../local_storage/interface/local_storage_interface.dart';

/// Vibração (haptics) do app, seguindo os padrões do Android
/// (`HapticFeedbackConstants`), via [HapticFeedback]:
///
/// | Uso                                     | Método        | Android        |
/// |-----------------------------------------|---------------|----------------|
/// | Tecla de ferramenta (placar, relógio)   | [key]         | VIRTUAL_KEY    |
/// | Desfazer / voltar uma ação              | [undo]        | KEYBOARD_TAP   |
/// | Seleção: rodas, atalhos, opções, switch | [selection]   | CLOCK_TICK     |
/// | Ação concluída com sucesso              | [success]     | CONFIRM        |
/// | Erro / resposta errada                  | [error]       | REJECT         |
/// | Alarme (fim do tempo da luta)           | [alarm]       | LONG_PRESS ×3  |
///
/// Navegação comum (abrir tela, voltar, cartões) não vibra — é o padrão do
/// Android e evita vibração em excesso. Respeita também a configuração do
/// sistema "vibração ao tocar". Ligado por padrão; desligável em Configurações.
abstract final class AppHaptics {
  static const storageKey = 'haptics_enabled';

  /// Preferência do usuário (true = vibração ligada).
  static final enabled = ValueNotifier<bool>(true);

  static ILocalStorage? _storage;

  /// Carrega a preferência salva (sem preferência salva = ligado).
  static Future<void> load(ILocalStorage storage) async {
    _storage = storage;
    final saved = await storage.getValue<int>(storageKey);
    enabled.value = saved != 0;
  }

  static void setEnabled(bool value) {
    enabled.value = value;
    _storage?.saveValue<int>(storageKey, value ? 1 : 0);
    // Ao ligar, uma vibração curta mostra como é.
    if (value) selection();
  }

  static void key() => _run(HapticFeedback.lightImpact);
  static void undo() => _run(HapticFeedback.mediumImpact);
  static void selection() => _run(HapticFeedback.selectionClick);
  static void success() => _run(HapticFeedback.successNotification);
  static void error() => _run(HapticFeedback.errorNotification);

  /// Três vibrações longas, para o fim do tempo da luta.
  static Future<void> alarm() async {
    for (var i = 0; i < 3; i++) {
      if (!enabled.value) return;
      await HapticFeedback.vibrate();
      await Future<void>.delayed(const Duration(milliseconds: 350));
    }
  }

  static void _run(Future<void> Function() feedback) {
    if (enabled.value) feedback();
  }
}
