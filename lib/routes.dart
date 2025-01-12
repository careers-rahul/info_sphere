import 'package:info_sphere/utils/imports.dart';

class Routes {
  static String currentRoute = SplashScreen.route;

  static Route<dynamic> onGenerateRouted(RouteSettings routeSettings) {
    currentRoute = routeSettings.name ?? "";
    print("Current Route is $currentRoute");

    switch (routeSettings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case HomeScreen.route:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case RegisterNameScreen.route:
        return MaterialPageRoute(builder: (context) => const RegisterNameScreen());

      case ArticlesListScreen.route:
        final args = routeSettings.arguments as ArticlesListScreen;
        return MaterialPageRoute(
          builder: (context) => ArticlesListScreen(newsCategory: args.newsCategory),
        );

      case DetailedArticleScreen.route:
        final args = routeSettings.arguments as DetailedArticleScreen;
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => DetailedArticleScreen(article: args.article),
        );

      case SettingsScreen.route:
        return MaterialPageRoute(builder: (context) => const SettingsScreen());

      default:
        throw Exception('Invalid route: ${routeSettings.name}');
    }
  }
}
