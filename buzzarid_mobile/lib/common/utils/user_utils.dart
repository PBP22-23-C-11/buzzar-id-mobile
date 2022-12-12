import 'package:buzzarid_mobile/common/models/user.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<User> fetchUser(CookieRequest request, int userId) async {
  User user = User(
      id: 0, username: 'guest', name: 'Guest', type: 'guest', isGuest: true);

  try {
    final response = await request
        .get('https://buzzar-id.up.railway.app/api/user-data/$userId/');
    user = User.fromJson(response);
  } catch (error) {
    // Pass
  }

  return user;
}

Future<dynamic> registerOne(CookieRequest request, String username,
    String password1, String password2) async {
  dynamic response = {};
  try {
    response =
        await request.post('https://buzzar-id.up.railway.app/api/register/1/', {
      'username': username,
      'password1': password1,
      'password2': password2,
    });
  } catch (error) {
    // Pass
  }
  if (!response.containsKey('success')) {
    response['success'] = false;
  }
  if (!response.containsKey('message')) {
    response['message'] = 'Couldn\'t connect to server';
  }
  return response;
}

Future<dynamic> registerTwoUMKM(CookieRequest request, String name) async {
  dynamic response = {};
  try {
    response =
        await request.post('https://buzzar-id.up.railway.app/api/register/2/', {
      'type': 'umkm',
      'name': name,
    });
  } catch (error) {
    // Pass
  }
  if (!response.containsKey('success')) {
    response['success'] = false;
  }
  if (!response.containsKey('message')) {
    response['message'] = 'Couldn\'t connect to server';
  }
  return response;
}

Future<dynamic> registerTwoCustomer(
    CookieRequest request, String firstName, String lastName) async {
  dynamic response = {};
  try {
    response =
        await request.post('https://buzzar-id.up.railway.app/api/register/2/', {
      'type': 'customer',
      'first_name': firstName,
      'last_name': lastName,
    });
  } catch (error) {
    // Pass
  }
  if (!response.containsKey('success')) {
    response['success'] = false;
  }
  if (!response.containsKey('message')) {
    response['message'] = 'Couldn\'t connect to server';
  }
  return response;
}
