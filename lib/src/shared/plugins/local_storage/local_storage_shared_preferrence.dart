import 'package:shared_preferences/shared_preferences.dart';

import 'interface/local_storage_interface.dart';

class LocalStorageSharedPreferrence implements ILocalStorage {
  static const _instance = LocalStorageSharedPreferrence._();

  const LocalStorageSharedPreferrence._();

  factory LocalStorageSharedPreferrence() => _instance;

  // Instância cacheada: obtida do lado nativo só uma vez e reutilizada em
  // todas as chamadas, em vez de chamar getInstance() a cada operação.
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> _preferences() async =>
      _prefs ??= await SharedPreferences.getInstance();

  @override
  Future<T?> getValue<T>(String key) async {
    final preferences = await _preferences();
    return preferences.get(key) as T?;
  }

  @override
  void saveValue<T>(String key, T value) async {
    final preferences = await _preferences();
    if (value is int) {
      preferences.setInt(key, value);
    } else if (value is String) {
      preferences.setString(key, value);
    } else {
      throw Exception('type unsuported in LocalStorageSharedPreferre');
    }
  }

  @override
  void remove(String key) async {
    final preferences = await _preferences();
    preferences.remove(key);
  }
}
