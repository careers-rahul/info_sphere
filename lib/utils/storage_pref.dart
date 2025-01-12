import 'package:info_sphere/utils/imports.dart';

class StoragePrefUtils {
  static const String _kTheme = "THEME";
  static const String _kName = "NAME";

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  /// Method to saves the user theme
  static Future setTheme(ThemeMode? value) async {
    await _storage.write(key: _kTheme, value: value?.toString());
  }

  /// Method to returns the user theme
  static Future<ThemeMode?> getTheme() async {
    try {
      final themeString = await _storage.read(key: _kTheme);
      return themeString != null ? _parseThemeMode(themeString) : null;
    } catch (e) {
      return null;
    }
  }

  static ThemeMode? _parseThemeMode(String value) {
    switch (value) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return null;
    }
  }

  /// Method to saves user register
  static Future setName(String? name) async {
    await _storage.write(key: _kName, value: name == null ? null : name);
  }

  /// Method to returns the user register
  static Future<String?> getName() async {
    String? name = await _storage.read(key: _kName);
    if (name == null) {
      return null;
    } else {
      return name;
    }
  }
}
