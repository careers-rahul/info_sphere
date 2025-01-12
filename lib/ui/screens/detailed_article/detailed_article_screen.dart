import 'package:info_sphere/ui/widgets/no_internet_widget.dart';
import 'package:info_sphere/utils/imports.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailedArticleScreen extends StatefulWidget {
  const DetailedArticleScreen({super.key, required this.article});

  static const route = "DetailedArticleScreen";

  final Article article;

  @override
  State<DetailedArticleScreen> createState() => _DetailedArticleScreenState();
}

class _DetailedArticleScreenState extends State<DetailedArticleScreen> {
  late WebViewController webViewController;
  @override
  void initState() {
    print(widget.article.url);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailedArticleViewModel>().state = NotifierState.loading;
    });
    loadRequest();
    super.initState();
  }

  loadRequest() {
    var view = context.read<DetailedArticleViewModel>();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            // view.isLoading = true;
          },
          onPageFinished: (url) {
            setState(() {
              // view.isLoading = false; // Page finished loading
              view.state = NotifierState.loaded;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.article.url ?? ''));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.source?.name ?? 'Full Article'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.route,
                (Route<dynamic> route) => false, // Removes all previous routes
              );
            },
            icon: const Icon(Icons.home_filled),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<DetailedArticleViewModel>(builder: (context, view, child) {
        if (view.state == NotifierState.loading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (!view.hasConnection) {
          return Center(
            child: NoInternetWidget(
              retry: loadRequest(),
            ),
          );
        }

        return WebViewWidget(
          controller: webViewController,
        );
      }),
    );
  }
}
