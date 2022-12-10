import 'package:buzzarid_mobile/common/components/drawer.dart';
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

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Form"),
      ),
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
                                price = int.parse(value!);
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "'Price' cannot empty!";
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
                                return "'Price' cannot empty!";
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
                        final response = await request.post(
                          "https://buzzar-id.up.railway.app/products/add/",
                          {
                            'UMKM_name': nameUMKM,
                            'product_name': nameProduct,
                            'price': price,
                            'description': description,
                          },
                        );
                      },
                    )),
              ]))),
    );
  }
}
