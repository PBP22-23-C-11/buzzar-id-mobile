import 'package:buzzarid_mobile/common/models/user.dart';
import 'package:buzzarid_mobile/common/providers/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:buzzarid_mobile/common/page/home_page.dart';
import 'package:buzzarid_mobile/common/page/login_page.dart';
import 'package:buzzarid_mobile/common/page/register_one_page.dart';
import 'package:buzzarid_mobile/common/page/register_two_page.dart';

import 'package:buzzarid_mobile/news/pages/news_page.dart';
import 'package:buzzarid_mobile/lomba/page/home_lomba.dart';
import 'package:buzzarid_mobile/showcase/pages/showcase.dart';
import 'package:buzzarid_mobile/obrolan/page/obrolan_home.dart';
import 'package:buzzarid_mobile/products/page/product_show.dart';

import 'package:buzzarid_mobile/news/pages/article_post_page.dart';

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
                  id: 0,
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
          '/news': (BuildContext context) => const NewsPage(),
          '/showcase': (BuildContext context) => const ShowcasePage(),
          '/obrolan': (BuildContext context) => const ObrolanHomePage(),
          '/products': (BuildContext context) => const MyProductPage(),
          '/news/post': (BuildContext context) => const ArticlePostPage(),
          '/register/1': (BuildContext context) => const RegisterOnePage(),
          '/register/2': (BuildContext context) => const RegisterTwoPage(),
        },
      ),
    );
  }
}