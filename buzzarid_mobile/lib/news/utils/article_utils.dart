import 'package:buzzarid_mobile/news/models/article.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Article>> fetchArticleList(CookieRequest request, String title,
    String author, String sortBy, String category) async {
  dynamic response;
  List<Article> articleList = [];
  try {
    String url =
        'https://buzzar-id.up.railway.app/news/api/article?title=$title&sort_by=$sortBy&category=$category&umkm=$author&umkm_type=name';
    response = await request.get(url);
    for (var article in response['articles']) {
      articleList.add(Article.fromJson(article));
    }
  } catch (error) {
    // Pass
  }
  return articleList;
}

Future<Article?> postArticle(
    CookieRequest request, String title, String body, String imageUrl) async {
  try {
    String url = 'https://buzzar-id.up.railway.app/news/api/article/';
    dynamic response = await request.post(url, {
      'title': title,
      'body': body,
      'image': imageUrl,
    });
    print(response);
    return Article.fromJson(response);
  } catch (error) {
    return null;
  }
}
