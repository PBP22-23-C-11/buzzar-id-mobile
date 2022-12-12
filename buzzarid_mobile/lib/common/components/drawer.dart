import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:buzzarid_mobile/obrolan/page/obrolan_home.dart';
import 'package:buzzarid_mobile/products/page/product_detail.dart';
import 'package:buzzarid_mobile/products/page/product_form.dart';
import 'package:flutter/material.dart';
import 'package:buzzarid_mobile/showcase/pages/showcase.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import '../../products/page/product_show.dart';
import '../models/user.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final userProvider = context.watch<UserProvider>();
    print(userProvider.user.type);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: userProvider.user.isGuest ? Colors.grey : Colors.amber,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 12.0),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    width: 100.0,
                    height: 100.0,
                  ),
                  const SizedBox(height: 12.0),
                  (userProvider.user.isGuest)
                      ? const Text(
                          'Guest',
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        )
                      : Column(
                          children: [
                            Text(
                              (userProvider.user.type != 'None')
                                  ? userProvider.user.name
                                  : userProvider.user.username,
                              style: const TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                            (userProvider.user.type != 'None')
                                ? Text(userProvider.user.type)
                                : Container(),
                          ],
                        ),
                  (userProvider.user.type == 'None')
                      ? Column(
                          children: [
                            const SizedBox(height: 8.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/register/2');
                              },
                              child: const Text(
                                'Choose Role',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(height: 12.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (userProvider.user.isGuest)
                          ? Colors.white
                          : Color.fromARGB(255, 248, 81, 69),
                    ),
                    onPressed: () async {
                      if (userProvider.user.isGuest) {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/login');
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                        Map<String, dynamic> response = {};
                        try {
                          response = await request.logout(
                              'https://buzzar-id.up.railway.app/api/logout/');
                          userProvider.user = User(
                              id: 0,
                              username: 'guest',
                              name: 'Guest',
                              type: 'guest',
                              isGuest: true);
                        } catch (error) {
                          // Pass
                        }
                        if (!response.containsKey('status')) {
                          response['status'] = false;
                        }
                        if (!response.containsKey('message')) {
                          response['message'] = 'Couldn\'t connect to server';
                        }
                        if (!response['status']) {
                          if (!mounted) return;
                          final snackBar = SnackBar(
                            content: Text(response['message']),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: Text(
                      (userProvider.user.isGuest) ? 'Login' : 'Logout',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  (userProvider.user.isGuest)
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/register/1');
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 12.0),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('Lomba'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/lomba');
            },
          ),
          ListTile(
            title: const Text("Showcase"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShowcasePage()),
              );
            },
          ),
          ListTile(
            title: const Text('News'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/news');
            },
          ),
          ListTile(
            title: const Text("Product"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyProductPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Obrolan'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ObrolanHomePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
