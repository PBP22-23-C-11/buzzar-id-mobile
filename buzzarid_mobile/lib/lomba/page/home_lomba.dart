import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:buzzarid_mobile/common/components/drawer.dart';
import 'package:buzzarid_mobile/lomba/page/lomba.dart';

class HomeLomba extends StatefulWidget {
    const HomeLomba({super.key});

    @override
    State<HomeLomba> createState() => _HomeLombaState();
}

class _HomeLombaState extends State<HomeLomba> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
              title: Text('Home Lomba'),
          ),
          drawer: const AppDrawer(),
          body: Container(
            padding: const EdgeInsets.all(32),
            child: Center (
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: new Text(
                        "Selamat Datang di Halaman Lomba",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        )
                    )
                  ),
                  Flexible(
                    child: new Text("Silahkan Login terlebih dahulu untuk mengakses seluruh fitur yang atau hanya lihat lomba yang sedang berlangsung."),
                  ),
                  Container(  
                    padding: const EdgeInsets.only(top: 32),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: Text(
                        "Lihat Lomba",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        Route route = MaterialPageRoute(builder: (context) => LombaPage());
                        Navigator.push(context, route);
                      },
                    ),  
                  ),  
                ],
              ),
            ),
          ),
        );
    }
}