import 'package:buzzarid_mobile/showcase/pages/showcase.dart';
import 'package:buzzarid_mobile/showcase/pages/showcaseHome.dart';
import 'package:flutter/material.dart';
import 'package:buzzarid_mobile/common/components/drawer.dart';
import 'package:buzzarid_mobile/showcase/models/cardsAndCategoryHelper.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';


class AddUMKMPage extends StatefulWidget {
  const AddUMKMPage({super.key});

  @override
  State<AddUMKMPage> createState() => _AddUMKMPageState();
}

class _AddUMKMPageState extends State<AddUMKMPage> {
  final _formKey = GlobalKey<FormState>();
  String _shopName = "";
  String _category = "";
  String _description = "";
  String _umkmUrl = "";
  String _number = "";
  String _image = "";

  Future<void> submit(CookieRequest request) async {
    final response = await request.postJson(
        'https://buzzar-id.up.railway.app/showcase/add_shop_flutter/',
      jsonEncode({
        "shop_name": _shopName,
        "category": _category,
        "description": _description,
        "umkm_url": _umkmUrl,
        "number":_number,
        "image":_image,
      })
    );
  }

  List<DropdownMenuItem<int>> categoriesChoice = [
    const DropdownMenuItem(
      value: 1,
      child: Text("Food and Beverages"),
    ),
    const DropdownMenuItem(
      value: 2,
      child: Text("Fashion"),
    ),
    const DropdownMenuItem(
      value: 3,
      child: Text("Agriculture"),
    ),
    const DropdownMenuItem(
      value: 4,
      child: Text("Electronic"),
    ),
    const DropdownMenuItem(
      value: 5,
      child: Text("Furniture"),
    ),
    const DropdownMenuItem(
      value: 6,
      child: Text("Service"),
    ),
    const DropdownMenuItem(
      value: 7,
      child: Text("Other"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add UMKM"),
      ),
      drawer: const AppDrawer(),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget> [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Shop's Name",
                        hintText: "Enter Shop's Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        border: OutlineInputBorder()
                    ),
                    onSaved: (String? value) {
                      setState(() {
                        _shopName = value!;
                      });
                    },
                    onChanged: (String? value) {
                      setState(() {
                        _shopName = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Shop's name cannot be empty!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        hintText: "Choose Category",
                        labelText: "Category",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        border: OutlineInputBorder()
                    ),
                    items: categoriesChoice,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    onChanged: (int? value) {
                      setState(() {
                        _category = categories[value!];
                      });
                    },
                    onSaved: (int? value) {
                      setState(() {
                        _category = categories[value!];
                      });
                    },
                    validator: (value) {
                      if (value == null || value == 0) {
                        return "Choose a category";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    maxLines: null,
                    decoration: const InputDecoration(
                        labelText: "Shop's Description",
                        hintText: "Enter Shop's Description",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        border: OutlineInputBorder()
                    ),
                    onSaved: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Shop's description cannot be empty!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Shop's URL",
                        hintText: "Enter Shop's URL",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        border: OutlineInputBorder()
                    ),
                    onSaved: (String? value) {
                      setState(() {
                        _umkmUrl = value!;
                      });
                    },
                    onChanged: (String? value) {
                      setState(() {
                        _umkmUrl = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Shop's URL cannot be empty!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Shop's Number",
                        hintText: "Enter Shop's Number",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly],
                    onSaved: (String? value) {
                      setState(() {
                        _number = value!;
                      });
                    },
                    onChanged: (String? value) {
                      setState(() {
                        _number = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Shop's number cannot be empty!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Shop's Image URL",
                        hintText: "Enter Shop's Image URL",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        border: OutlineInputBorder()
                    ),
                    onSaved: (String? value) {
                      setState(() {
                        _image = value!;
                      });
                    },
                    onChanged: (String? value) {
                      setState(() {
                        _image = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Shop's Image URL cannot be empty!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: 'Back',
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              )
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              child:
                              Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      top: 82.0,
                                      bottom: 16.0,
                                      left: 16.0,
                                      right: 16.0,
                                    ),
                                    margin: const EdgeInsets.only(top: 66.0),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        catCol[_category]![0],
                                        catCol[_category]![1]
                                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(16.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10.0,
                                          offset: Offset(0.0, 10.0),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          _shopName,
                                          style: const TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 3.0),
                                        Text(
                                          _category,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        const SizedBox(height: 12.0),
                                        Text(
                                          _description,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        const SizedBox(height: 12.0),
                                        Text(
                                          "$_umkmUrl\n$_number",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 12.0
                                          ),
                                        ),
                                        const SizedBox(height: 24.0),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    submit(request);
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => const ShowcaseHome()));
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ShowcasePage(category: _category)
                                                        )
                                                    );
                                                  },
                                                  child: const Text(
                                                    "Continue",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                    ),
                                                  )
                                              ),
                                              TextButton(
                                                  onPressed: () { Navigator.pop(context); },
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      top: 7.0,
                                      left: 16.0,
                                      right: 16.0,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(_image),
                                        radius: 66.0,
                                      )
                                  )
                                ],
                              )
                          );
                        },
                      );
                    }
                  },
                  tooltip: 'Add',
                  child: const Icon(Icons.add),
                )
            ),
          ],
        ),
      )
    );
  }
}