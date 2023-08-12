import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceKey {
  // Keys for the app preferences
  themeMode('theme_mode'),
  bookMarkList('book_mark_list'),
  readerMode('reader_mode');

  // property to get the key as string
  const PreferenceKey(this.key);
  final String key;
}

class AppPreference {
  AppPreference(this.pref);

  late final SharedPreferences? pref;

  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    if (pref == null) {
      await init();
    }
    await pref!.clear();
  }

  Future<void> remove(PreferenceKey key) async {
    if (pref == null) {
      await init();
    }
    await pref!.remove(key.key);
  }

  Future<bool> contains(PreferenceKey key) async {
    if (pref == null) {
      await init();
    }
    return pref!.containsKey(key.key);
  }

  Future<Set<String>> getKeys() async {
    if (pref == null) {
      await init();
    }
    return pref!.getKeys();
  }

  Future<void> reload() async {
    if (pref == null) {
      await init();
    }
    await pref!.reload();
  }

  Future<bool> save(PreferenceKey key, dynamic value) async {
    if (pref == null) {
      await init();
    }

    await reload();

    switch (value.runtimeType) {
      case String:
        return pref!.setString(key.key, value as String);
      case int:
        return pref!.setInt(key.key, value as int);
      case bool:
        return pref!.setBool(key.key, value as bool);
      case double:
        return pref!.setDouble(key.key, value as double);
      case const (List<String>):
        return pref!.setStringList(key.key, value as List<String>);
      default:
        throw Exception('Preference type is not supported');
    }
  }

  Future<dynamic> get(PreferenceKey key, dynamic defaultValue) async {
    if (pref == null) {
      await init();
    }

    await reload();

    switch (defaultValue.runtimeType) {
      case String:
        return pref!.getString(key.key) ?? defaultValue as String;
      case int:
        return pref!.getInt(key.key) ?? defaultValue as int;
      case bool:
        return pref!.getBool(key.key) ?? defaultValue as bool;
      case double:
        return pref!.getDouble(key.key) ?? defaultValue as double;
      case const (List<String>):
        return pref!.getStringList(key.key) ?? defaultValue as List<String>;
      default:
        throw Exception('Preference type is not supported');
    }
  }
}
