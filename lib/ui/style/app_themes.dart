import 'package:info_sphere/utils/imports.dart';

class AppThemes {
  // Single instance
  static final AppThemes _instance = AppThemes._internal();
  factory AppThemes() => _instance;
  AppThemes._internal();

  ValueNotifier<ThemeMode> appThemeNotifier = ValueNotifier(ThemeMode.light);
  ThemeMode? get appTheme => appThemeNotifier.value;
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'nunito',
    shadowColor: primaryColorLight.withOpacity(0.25),
    brightness: Brightness.light,
    primaryColor: primaryColorLight,
    secondaryHeaderColor: primaryColorLight,
    scaffoldBackgroundColor: scaffoldBackgroundColorLight,
    canvasColor: surfaceColorLight,
    cardColor: cardColorLight,
    scrollbarTheme: const ScrollbarThemeData().copyWith(
      thumbColor: MaterialStateProperty.all(accentColorLight),
    ),
    textTheme: const TextTheme().copyWith(
      bodySmall: const TextStyle(color: textColorLight),
      bodyMedium: const TextStyle(color: textColorLight),
      bodyLarge: const TextStyle(color: textColorLight),
      labelSmall: const TextStyle(color: textColorLight),
      labelMedium: const TextStyle(color: textColorLight),
      labelLarge: const TextStyle(color: textColorLight),
      titleSmall: const TextStyle(color: textColorLight),
      titleMedium: const TextStyle(color: textColorLight),
      titleLarge: const TextStyle(color: textColorLight),
      headlineSmall: const TextStyle(color: textColorLight),
      headlineMedium: const TextStyle(color: textColorLight),
      headlineLarge: const TextStyle(color: textColorLight),
      displaySmall: const TextStyle(color: textColorLight),
      displayMedium: const TextStyle(color: textColorLight),
      displayLarge: const TextStyle(color: textColorLight),
    ),
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: primaryColorLight,
      foregroundColor: textColorLight,
    ),
    colorScheme: ThemeData().colorScheme.copyWith(
          brightness: Brightness.light,
          secondary: accentColorLight,
          primary: primaryColorLight,
          inversePrimary: Colors.black,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
        ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'nunito',
    shadowColor: primaryColorDark.withOpacity(0.25),
    brightness: Brightness.dark,
    primaryColor: primaryColorDark,
    scaffoldBackgroundColor: scaffoldBackgroundColorDark,
    canvasColor: surfaceColorDark,
    cardColor: cardColorDark,
    textTheme: const TextTheme().copyWith(
      bodySmall: const TextStyle(color: textColorDark),
      bodyMedium: const TextStyle(color: textColorDark),
      bodyLarge: const TextStyle(color: textColorDark),
      labelSmall: const TextStyle(color: textColorDark),
      labelMedium: const TextStyle(color: textColorDark),
      labelLarge: const TextStyle(color: textColorDark),
      titleSmall: const TextStyle(color: textColorDark),
      titleMedium: const TextStyle(color: textColorDark),
      titleLarge: const TextStyle(color: textColorDark),
      headlineSmall: const TextStyle(color: textColorDark),
      headlineMedium: const TextStyle(color: textColorDark),
      headlineLarge: const TextStyle(color: textColorDark),
      displaySmall: const TextStyle(color: textColorDark),
      displayMedium: const TextStyle(color: textColorDark),
      displayLarge: const TextStyle(color: textColorDark),
    ),
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: primaryColorDark,
      foregroundColor: textColorDark,
    ),
    colorScheme: ThemeData().colorScheme.copyWith(
        brightness: Brightness.dark,
        primary: primaryColorDark,
        inversePrimary: Colors.white,
        secondary: accentColorDark,
        onPrimary: Colors.black,
        onSecondary: Colors.white),
  );

  ///status bar color for light theme
  static const lightBar = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,

    /// ios Light
    statusBarBrightness: Brightness.light,

    /// Android Light
    statusBarIconBrightness: Brightness.dark,
  );

  ///status bar color for dark theme
  static const darkBar = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,

    /// iOS dark
    statusBarBrightness: Brightness.dark,

    /// Android  Dark
    statusBarIconBrightness: Brightness.light,
  );

  Future<void> changeTheme(ThemeMode theme) async {
    appThemeNotifier.value = theme;
    await StoragePrefUtils.setTheme(theme);
    SystemUiOverlayStyle? overlayStyle;
    if (theme == ThemeMode.light) {
      overlayStyle = darkBar;
    } else {
      overlayStyle = lightBar;
    }

    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  }

  Future<void> getPreferences() async {
    appThemeNotifier.value = await StoragePrefUtils.getTheme() ?? ThemeMode.light;
    await StoragePrefUtils.setTheme(appThemeNotifier.value);
    print('appTheme ${appThemeNotifier.value}');
  }
}
