import 'package:info_sphere/routes.dart';

import 'utils/imports.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArticlesListViewModel()),
        ChangeNotifierProvider(create: (_) => DetailedArticleViewModel()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppThemes().appThemeNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: value,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.route,
          onGenerateRoute: Routes.onGenerateRouted,
        );
      },
    );
  }
}
