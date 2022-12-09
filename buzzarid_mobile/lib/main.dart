import 'package:buzzarid_mobile/common/models/user.dart';
import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:buzzarid_mobile/lomba/page/home_lomba.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:buzzarid_mobile/common/page/home_page.dart';
import 'package:buzzarid_mobile/common/page/login_page.dart';
import 'package:buzzarid_mobile/lomba/page/home_lomba.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CookieRequest>(create: (_) {
          CookieRequest request = CookieRequest();
          return request;
        }),
        Provider<UserProvider>(create: (_) {
          UserProvider userProvider = UserProvider(
              user: User(
                  username: 'guest',
                  name: 'Guest',
                  type: 'guest',
                  isGuest: true));
          return userProvider;
        }),
      ],
      child: MaterialApp(
        title: 'Buzzar-id',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => const HomePage(),
          '/login': (BuildContext context) => const LoginPage(),
          '/lomba': (BuildContext context) => const HomeLomba(),
        },
      ),
    );
    // return Provider(
    //   create: (_) {
    //     CookieRequest request = CookieRequest();
    //     return request;
    //   },
    //   child: MaterialApp(
    //     title: 'Buzzar-id',
    //     theme: ThemeData(
    //       primarySwatch: Colors.amber,
    //     ),
    //     initialRoute: '/',
    //     routes: {
    //       '/': (BuildContext context) => const HomePage(),
    //       '/login': (BuildContext context) => const LoginPage(),
    //     },
    //   ),
    // );
  }
}
