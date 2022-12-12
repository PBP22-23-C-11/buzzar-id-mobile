import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import '../models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Images
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0),
                child: Image.asset('assets/images/LOGO5.png', height: 200),
              ),
              // Username
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Username",
                    icon: const Icon(Icons.people),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _username = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      _username = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
              ),
              // Password
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
                child: TextFormField(
                  obscureText: !isPasswordVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Password",
                    icon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _password = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      _password = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var response = {};
                  try {
                    response = await request
                        .login('https://buzzar-id.up.railway.app/api/login/', {
                      'username': _username,
                      'password': _password,
                    });
                  } catch (error) {
                    // Pass
                  }
                  if (!response.containsKey('status')) {
                    response['status'] = false;
                  }
                  if (!response.containsKey('message')) {
                    response['message'] = 'Couldn\'t connect to server';
                  }
                  if (!mounted) return;
                  if (request.loggedIn) {
                    userProvider.user = User.fromJson(response['data']);
                    Navigator.pop(context);
                  } else {
                    userProvider.user = User(
                        id: 0,
                        username: 'guest',
                        name: 'Guest',
                        type: 'guest',
                        isGuest: true);
                    final snackBar = SnackBar(
                      content: Text(response['message']),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
