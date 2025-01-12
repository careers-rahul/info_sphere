import 'package:info_sphere/ui/widgets/no_articles_found_widget.dart';
import 'package:info_sphere/ui/widgets/no_internet_widget.dart';
import 'package:info_sphere/ui/widgets/something_went_wrong.dart';
import 'package:info_sphere/utils/imports.dart';

class ArticlesListScreen extends StatefulWidget {
  const ArticlesListScreen({super.key, required this.newsCategory});

  static const route = "ArticlesListScreen";
  final NewsCategory newsCategory;

  @override
  State<ArticlesListScreen> createState() => _ArticlesListScreenState();
}

class _ArticlesListScreenState extends State<ArticlesListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var view = context.read<ArticlesListViewModel>();
      view.clearData();
      view.getArticles(getUrl(widget.newsCategory));
    });
    super.initState();
  }

  String getUrl(NewsCategory newsCategory) {
    if (newsCategory == NewsCategory.topHeadlines) {
      return AppUrls.worldNews;
    } else if (newsCategory == NewsCategory.business) {
      return AppUrls.business;
    } else if (newsCategory == NewsCategory.sports) {
      return AppUrls.sports;
    } else if (newsCategory == NewsCategory.entertainment) {
      return AppUrls.entertainment;
    } else if (newsCategory == NewsCategory.technology) {
      return AppUrls.technology;
    } else {
      return AppUrls.technology;
    }
  }

  String getTitle(NewsCategory newsCategory) {
    if (newsCategory == NewsCategory.topHeadlines) {
      return worldNews;
    } else if (newsCategory == NewsCategory.business) {
      return business;
    } else if (newsCategory == NewsCategory.sports) {
      return sports;
    } else if (newsCategory == NewsCategory.entertainment) {
      return entertainment;
    } else if (newsCategory == NewsCategory.technology) {
      return technology;
    } else {
      return worldNews;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle(widget.newsCategory)),
      ),
      body: Consumer<ArticlesListViewModel>(
        builder: (context, view, child) {
          if (view.state == NotifierState.loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (!view.hasConnection) {
            return Center(
              child: NoInternetWidget(
                retry: () {
                  if (view.hasConnection) {
                    view.getArticles(getUrl(widget.newsCategory));
                  }
                },
              ),
            );
          }

          if (view.state == NotifierState.error) {
            return Center(
              child: SomethingWentWrong(
                onTryAgain: () {
                  view.getArticles(getUrl(widget.newsCategory));
                },
              ),
            );
          }

          if (view.articlesList.isEmpty) {
            return Center(
              child: NoArticlesFoundWidget(
                onTryAgain: () {
                  view.getArticles(getUrl(widget.newsCategory));
                },
              ),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollEndNotification &&
                  scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent) {
                view.loadMoreArticles();
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                view.clearData();
                view.getArticles(getUrl(widget.newsCategory));
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 32),
                      itemCount: view.displayedArticles.length + (view.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == view.displayedArticles.length) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final article = view.displayedArticles.elementAt(index);
                        return ArticleCard(
                          article: article,
                          onViewArticle: article.url != null
                              ? () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailedArticleScreen.route,
                                    arguments: DetailedArticleScreen(
                                      article: article,
                                    ),
                                  );
                                }
                              : null,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
