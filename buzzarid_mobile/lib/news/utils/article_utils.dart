import 'package:buzzarid_mobile/news/models/article.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Article>> fetchArticleList(CookieRequest request, String title,
    String author, String authorType, String sortBy, String category) async {
  List<Article> articleList = [];
  try {
    String url =
        'https://buzzar-id.up.railway.app/news/api/article?title=$title&sort_by=$sortBy&category=$category&umkm=$author&umkm_type=$authorType';
    final response = await request.get(url);
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
    return Article.fromJson(response);
  } catch (error) {
    return null;
  }
}

Future<List<Article>> getArticleById(CookieRequest request, int id) async {
  List<Article> articleList = []; // length = 1 if available, 0 if not
  try {
    String url = 'https://buzzar-id.up.railway.app/news/api/articles/$id/';
    dynamic response = await request.get(url);
    articleList.add(Article.fromJson(response));
  } catch (error) {
    // Pass
  }
  return articleList;
}

Future<bool> deleteArticleById(CookieRequest request, int id) async {
  try {
    String url =
        'https://buzzar-id.up.railway.app/news/api/articles/$id/delete/';
    await request.get(url);
    return true;
  } catch (error) {
    return false;
  }
}

Future<bool> toggleLike(CookieRequest request, int articleId) async {
  try {
    String url =
        'https://buzzar-id.up.railway.app/news/api/articles/$articleId/likes/toggle/';
    final response = await request.get(url);
    if (response.containsKey('success')) {
      return true;
    }
  } catch (error) {
    // Pass
  }
  return false;
}

Future<dynamic> checkLike(CookieRequest request, int articleId) async {
  try {
    String url =
        'https://buzzar-id.up.railway.app/news/api/articles/$articleId/likes/';
    final response = await request.get(url);
    if (response.containsKey('liked')) {
      return response;
    }
  } catch (error) {
    // Pass
  }
  return null;
}

Future<bool> toggleSubscribe(CookieRequest request, int authorId) async {
  try {
    String url =
        'https://buzzar-id.up.railway.app/news/api/subscribes/$authorId/toggle/';
    final response = await request.get(url);
    if (response.containsKey('status')) {
      return true;
    }
  } catch (error) {
    // Pass
  }
  return false;
}

Future<dynamic> checkSubscribe(CookieRequest request, int authorId) async {
  try {
    String url =
        'https://buzzar-id.up.railway.app/news/api/subscribes/$authorId/';
    final response = await request.get(url);
    if (response.containsKey('subscribed')) {
      return response;
    }
  } catch (error) {
    // Pass
  }
  return null;
}

Future<bool> checkSubscribeable(CookieRequest request, int authorId) async {
  try {
    String url = 'https://buzzar-id.up.railway.app/api/user-data/$authorId/';
    final response = await request.get(url);
    if (response.containsKey('type')) {
      return response['type'] == 'UMKM';
    }
  } catch (error) {
    // Pass
  }
  return false;
}
