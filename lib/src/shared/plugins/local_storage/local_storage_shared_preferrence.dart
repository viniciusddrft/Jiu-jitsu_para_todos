import 'package:shared_preferences/shared_preferences.dart';

import 'interface/local_storage_interface.dart';

class LocalStorageSharedPreferrence implements ILocalStorage {
  static const _instance = LocalStorageSharedPreferrence._();

  const LocalStorageSharedPreferrence._();

  factory LocalStorageSharedPreferrence() => _instance;

  @override
  Future<T?> getValue<T>(String key) => SharedPreferences.getInstance()
      .then((SharedPreferences preferences) => preferences.get(key) as T?);

  @override
  void saveValue<T>(String key, T value) =>
      SharedPreferences.getInstance().then((SharedPreferences preferences) {
        if (value is int) {
          preferences.setInt(key, value);
        } else if (value is String) {
          preferences.setString(key, value);
        } else {
          throw Exception('type unsuported in LocalStorageSharedPreferre');
        }
      });

  @override
  void remove(String key) => SharedPreferences.getInstance()
      .then((SharedPreferences preferences) => preferences.remove(key));
}
