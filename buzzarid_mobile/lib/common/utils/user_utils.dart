import 'package:buzzarid_mobile/common/models/user.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<User> fetchUser(CookieRequest request) async {
  User user = User(
      id: 0, username: 'guest', name: 'Guest', type: 'guest', isGuest: true);

  try {
    final response =
        await request.get('https://buzzar-id.up.railway.app/api/user-data/');
    if (response.containsKey('data')) {
      user = User.fromJson(response['data']);
    }
  } catch (error) {
    // Pass
  }

  return user;
}
