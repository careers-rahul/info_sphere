import 'package:info_sphere/utils/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const route = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return ExitAppAlert(
              onYesTap: () => exit(0),
              onNoTap: () => Navigator.pop(context),
            );
          },
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<SettingsViewModel>(
            builder: (context, view, child) {
              return Text(
                'Hey, ${view.name}',
                style: context.textTheme.titleLarge,
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SettingsScreen.route);
              },
              icon: const Icon(Icons.person),
            ),
            const SizedBox(width: 12),
          ],
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                CategoryCard(
                  categoryName: 'Technology',
                  imagePath: Assets.technologyCategory,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ArticlesListScreen.route,
                      arguments: const ArticlesListScreen(
                        newsCategory: NewsCategory.technology,
                      ),
                    );
                  },
                ),
                CategoryCard(
                  categoryName: 'Sports',
                  imagePath: Assets.sportsCategory,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ArticlesListScreen.route,
                      arguments: const ArticlesListScreen(
                        newsCategory: NewsCategory.sports,
                      ),
                    );
                  },
                ),
                CategoryCard(
                  categoryName: 'Entertainment',
                  imagePath: Assets.entertainmentCategory,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ArticlesListScreen.route,
                      arguments: const ArticlesListScreen(
                        newsCategory: NewsCategory.entertainment,
                      ),
                    );
                  },
                ),
                CategoryCard(
                  categoryName: 'Business',
                  imagePath: Assets.businessCategory,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ArticlesListScreen.route,
                      arguments: const ArticlesListScreen(
                        newsCategory: NewsCategory.business,
                      ),
                    );
                  },
                ),
                CategoryCard(
                  categoryName: 'World News',
                  imagePath: Assets.worldNewsCategory,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ArticlesListScreen.route,
                      arguments: const ArticlesListScreen(
                        newsCategory: NewsCategory.topHeadlines,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
