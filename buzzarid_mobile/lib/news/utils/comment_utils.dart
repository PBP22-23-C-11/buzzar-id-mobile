import 'package:buzzarid_mobile/news/models/comment.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Comment>> getArticleComments(
    CookieRequest request, int articleId) async {
  List<Comment> commentList = [];
  try {
    String url =
        'https://buzzar-id.up.railway.app/news/api/articles/$articleId/comments/';
    final response = await request.get(url);
    for (var comment in response['comments']) {
      commentList.add(Comment.fromJson(comment));
    }
  } catch (error) {
    // Pass
  }
  return commentList;
}

Future<Comment?> postArticleComment(
    CookieRequest request, int articleId, String body) async {
  try {
    String url =
        'https://buzzar-id.up.railway.app/news/api/articles/$articleId/comments/';
    dynamic response = await request.post(url, {
      'body': body,
    });
    return Comment.fromJson(response);
  } catch (error) {
    return null;
  }
}

Future<bool> deleteArticleComment(
    CookieRequest request, int articleId, int commentId) async {
  try {
    String url =
        'https://buzzar-id.up.railway.app/news/api/articles/$articleId/comments/$commentId/delete/';
    await request.get(url);
    return true;
  } catch (error) {
    return false;
  }
}
