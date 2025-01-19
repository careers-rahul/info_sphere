import 'package:info_sphere/utils/imports.dart';

class SettingsViewModel extends AppBaseModel {
  bool _isReadOnly = true;
  bool get isReadOnly => _isReadOnly;
  set isReadOnly(bool isReadOnly) {
    _isReadOnly = isReadOnly;
    notifyListeners();
  }

  String? _name;
  String? get name => _name;
  set name(String? name) {
    _name = name;
    notifyListeners();
  }

  onSaveProfile() {
    StoragePrefUtils.setName(name);
    isReadOnly = true;
  }

  Future<void> logout() async {
    await StoragePrefUtils.setName(null);
    await StoragePrefUtils.setTheme(null);
    AppThemes().appThemeNotifier.value = ThemeMode.light;
  }
}
