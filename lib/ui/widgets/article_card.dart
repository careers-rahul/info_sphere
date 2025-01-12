import 'package:info_sphere/utils/imports.dart';
import 'package:intl/intl.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, this.article, this.onViewArticle});

  final Article? article;
  final VoidCallback? onViewArticle;

  @override
  Widget build(BuildContext context) {
    print("Source Name : ${article?.toJson()}");
    return Card(
      color: context.theme.cardColor,
      margin: const EdgeInsets.all(12),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Displaying the image
          if (article?.urlToImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: article?.urlToImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator.adaptive()),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Text(
                    "Some Error Ocurred !",
                  ),
                ),
              ),
            ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article?.source?.name != null && article?.publishedAt != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article?.source?.name ?? '',
                        style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
                      ),
                      Text(
                        DateFormat('dd MMM, yyyy').format(article?.publishedAt ?? DateTime.now()),
                        style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                const SizedBox(height: 5),
                Text(
                  article?.title ?? '',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Description
                if (article?.description != null)
                  Text(
                    article?.description ?? '',
                    style: context.textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: onViewArticle,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: context.theme.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "View Full Article",
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
