import 'package:buzzarid_mobile/common/components/drawer.dart';
import 'package:buzzarid_mobile/products/other/product_fetch.dart';
import 'package:buzzarid_mobile/products/page/product_show.dart';
import 'package:flutter/material.dart';

class MyProductDetailPage extends StatefulWidget {
  const MyProductDetailPage({Key? key}) : super(key: key);

  @override
  _MyProductDetailPageState createState() => _MyProductDetailPageState();
}

class _MyProductDetailPageState extends State<MyProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text("Our UMKM's Product"), actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyProductPage()));
                },
                child: const Icon(
                  Icons.cancel_outlined,
                  size: 26.0,
                ),
              )),
        ]),
        drawer: const AppDrawer(),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder(
              future: fetchProducts(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return Column(
                      children: const [
                        Text(
                          "Your product will show here!",
                          textAlign: TextAlign.center,
                          textScaleFactor: 2.0,
                          style: TextStyle(
                              color: Color.fromARGB(255, 129, 125, 116),
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.amber,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(children: [
                              ListTile(
                                title: Text(
                                  "${snapshot.data![index].fields.productName}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "★ By : ${snapshot.data![index].fields.umkmName}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 232, 161),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "★ Price : ${snapshot.data![index].fields.price}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 232, 161),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "${snapshot.data![index].fields.description}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 15),
                            ])));
                  }
                }
              },
            )));
  }
}
