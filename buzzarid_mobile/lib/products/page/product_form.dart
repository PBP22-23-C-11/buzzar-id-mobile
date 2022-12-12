import 'package:buzzarid_mobile/common/components/drawer.dart';
import 'package:buzzarid_mobile/products/page/product_detail.dart';
import 'package:buzzarid_mobile/products/page/product_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MyProductFormPage extends StatefulWidget {
  const MyProductFormPage({super.key});

  @override
  State<MyProductFormPage> createState() => _MyProductFormPageState();
}

class _MyProductFormPageState extends State<MyProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameUMKMController = TextEditingController();
  final _nameProductController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String nameUMKM = "";
  String nameProduct = "";
  int price = 0;
  String description = "";

  void product_post(request, nameUMKM, nameProduct, price, description) async {
    await request
        .post("https://buzzar-id.up.railway.app/products/add-flutter/", {
      "UMKM_name": nameUMKM,
      "product_name": nameProduct,
      "price": price,
      "description": description,
    });
    print("Over here");
  }

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text("Product Form"), actions: <Widget>[
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
      body: Form(
          key: _formKey,
          child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _nameUMKMController,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.add_business_rounded),
                              labelText: "UMKM Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                nameUMKM = value!;
                              });
                            },
                            onSaved: (String? value) {
                              setState(() {
                                nameUMKM = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "'UMKM Name' cannot empty!";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _nameProductController,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.add_shopping_cart_rounded),
                              labelText: "Product Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                nameProduct = value!;
                              });
                            },
                            onSaved: (String? value) {
                              setState(() {
                                nameProduct = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "'Product Name' cannot empty!";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _priceController,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.attach_money_rounded),
                              labelText: "Product Price",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (String? value) {
                              setState(() {
                                price = int.parse(value!);
                              });
                            },
                            onSaved: (String? value) {
                              setState(() {
                                price = value! as int;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "'Product Price' cannot empty!";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.description_rounded),
                              labelText: "Product Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            onChanged: (String? value) {
                              setState(() {
                                description = value!;
                              });
                            },
                            onSaved: (String? value) {
                              setState(() {
                                description = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "'Product Description' cannot empty!";
                              }
                              return null;
                            },
                          ),
                        ])),
                const Spacer(), // Extra space between column
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.save_alt_rounded),
                        label: const Text("Save"),
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Colors.amber,
                          padding: const EdgeInsets.all(20.0),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            product_post(
                              request,
                              nameUMKM,
                              nameProduct,
                              price.toString(),
                              description,
                            );
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 15,
                                      child: Container(
                                          child: ListView(
                                        padding: const EdgeInsets.all(20.0),
                                        shrinkWrap: true,
                                        children: [
                                          const Icon(
                                            Icons.check_rounded,
                                            color: Colors.green,
                                            size: 50,
                                          ),
                                          const Center(
                                            child: Text(
                                              "Succesfully Added",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          ElevatedButton.icon(
                                            icon: const Icon(Icons
                                                .featured_play_list_rounded),
                                            label:
                                                const Text("See your Product"),
                                            style: ElevatedButton.styleFrom(
                                              onPrimary: Colors.white,
                                              primary: Colors.amber,
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                            ),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MyProductDetailPage()),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          ElevatedButton.icon(
                                            icon: const Icon(Icons.add_rounded),
                                            label: const Text(
                                                "Add Another Product"),
                                            style: ElevatedButton.styleFrom(
                                              onPrimary: Colors.white,
                                              primary: Colors.amber,
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                            ),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MyProductFormPage()),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          ElevatedButton.icon(
                                            icon: const Icon(Icons
                                                .arrow_back_ios_new_rounded),
                                            label: const Text(
                                                "Back to Product Page"),
                                            style: ElevatedButton.styleFrom(
                                              onPrimary: Colors.white,
                                              primary: Colors.amber,
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                            ),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MyProductPage()),
                                              );
                                            },
                                          ),
                                        ],
                                      )));
                                });
                          }
                        })),
              ]))),
    );
  }
}
