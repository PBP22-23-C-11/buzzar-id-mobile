import 'package:buzzarid_mobile/common/components/drawer.dart';
import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:buzzarid_mobile/products/other/product_fetch.dart';
import 'package:buzzarid_mobile/products/page/product_detail.dart';
import 'package:buzzarid_mobile/products/page/product_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductPage extends StatefulWidget {
  const MyProductPage({super.key});

  @override
  State<MyProductPage> createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Product"),
        ),
        drawer: const AppDrawer(),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            width: width,
            child: SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(height: 10),
                const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.amber,
                  size: 90,
                ),
                const SizedBox(height: 20),
                const Text(
                  "UMKM's Product",
                  textAlign: TextAlign.center,
                  textScaleFactor: 2.0,
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0),
                ),
                const SizedBox(height: 20),
                const Text(
                  "UMKM are productive businesses owned by individuals or business entities that have met the requirements as micro businesses.  Basically, UMKM are businesses carried out by individuals, groups, small business entities, and households.  The existence of UMKM in Indonesia is taken into account, because they contribute greatly to economic growth.",
                  textAlign: TextAlign.center,
                  textScaleFactor: 2.0,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 7.5),
                ),
                const SizedBox(height: 10),
                const Text(
                  "This page is useful for UMKM to display their products infront of online customers. If you're logged in, you can see all products from our UMKM. And if you're an UMKM, you can place your products here!",
                  textAlign: TextAlign.center,
                  textScaleFactor: 2.0,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 7.5),
                ),
                const SizedBox(height: 20),
                if (userProvider.user.type == 'UMKM' ||
                    userProvider.user.type == 'Admin') ...[
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_rounded),
                    label: const Text("Add your Product"),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.amber,
                      padding: const EdgeInsets.all(18.0),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyProductFormPage()),
                      );
                    },
                  ),
                ],
                const SizedBox(height: 20),
                if (userProvider.user.type == 'UMKM' ||
                    userProvider.user.type == 'Customer' ||
                    userProvider.user.type == 'Admin') ...[
                  ElevatedButton.icon(
                    icon: const Icon(Icons.featured_play_list_rounded),
                    label: const Text("Our UMKM's Product"),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.amber,
                      padding: const EdgeInsets.all(18.0),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyProductDetailPage()),
                      );
                    },
                  ),
                ],
                const SizedBox(height: 20),
              ],
            ))));
  }
}
