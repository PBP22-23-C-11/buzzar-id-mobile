import 'package:buzzarid_mobile/news/models/article.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Article>> fetchArticleList(CookieRequest request) async {
  dynamic response;
  try {
    response = await request
        .get('https://buzzar-id.up.railway.app/news/api/articles/');
  } catch (error) {
    // Pass
  }
  List<Article> articleList = [];
  for (var article in response) {
    articleList.add(Article.fromJson(article));
  }
  return articleList;
}
