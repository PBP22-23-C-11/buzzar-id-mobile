import 'package:buzzarid_mobile/news/models/article.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Article>> fetchArticleList(CookieRequest request, String title,
    String author, String sortBy, String category) async {
  dynamic response;
  List<Article> articleList = [];
  try {
    String url =
        'https://buzzar-id.up.railway.app/news/api/article?title=${title}&sort_by=${sortBy}&category=${category}&umkm=${author}&umkm_type=name';
    print(url);
    response = await request.get(url);
    print(url);
    for (var article in response['articles']) {
      articleList.add(Article.fromJson(article));
    }
  } catch (error) {
    print(error);
    // Pass
  }
  return articleList;
}
