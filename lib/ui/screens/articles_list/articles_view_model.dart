import 'package:info_sphere/utils/imports.dart';

class ArticlesListViewModel extends AppBaseModel {
  final int pageSize = 10;
  final Dio dio = Dio();
  int currentPage = 1;
  bool isLoading = false;
  List<Article> articlesList = [];
  List<Article> displayedArticles = [];

  clearData() {
    currentPage = 1;
    articlesList.clear();
    displayedArticles.clear();
  }

  Future<void> getArticles(String url) async {
    state = NotifierState.loading;
    Map<String, dynamic> params = {
      'apiKey': apiKey,
    };
    var response = await ApiService.getData(dio, url, params: params);
    state = NotifierState.loaded;
    if (response is Success) {
      articlesList = articleListFromJson(response.data ?? []);
      print("articlesList length : ${articlesList.length}");
      displayedArticles.addAll(
        articlesList.sublist(
          0,
          pageSize,
        ),
      );
      print("DisplayedArticle length :${displayedArticles.length}");
    } else if (response is Error) {
      state = NotifierState.error;
      print(response.message);
    } else {
      state = NotifierState.error;
      print("Something went wrong!");
    }
    notifyListeners();
  }

  void loadMoreArticles() {
    print("LoadMore Called");
    if (isLoading) return;
    if (currentPage * pageSize >= (articlesList.length)) return;

    isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 2), () {
      final startIndex = currentPage * pageSize;
      final endIndex = startIndex + pageSize;

      displayedArticles.addAll(
        articlesList.sublist(
          startIndex,
          endIndex > articlesList.length ? articlesList.length : endIndex,
        ),
      );
      print("New DIsplay Length :${displayedArticles.length}");
      currentPage++;
      isLoading = false;
      notifyListeners();
    });
  }
}
