import 'package:buzzarid_mobile/common/utils/user_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:buzzarid_mobile/common/providers/user_provider.dart';

class RegisterTwoPage extends StatefulWidget {
  const RegisterTwoPage({super.key});

  @override
  State<RegisterTwoPage> createState() => _RegisterTwoPageState();
}

class _RegisterTwoPageState extends State<RegisterTwoPage> {
  final _formKey = GlobalKey<FormState>();

  String _type = 'umkm';
  String _name = '';
  String _firstName = '';
  String _lastName = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Step 2'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Role Choose
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: _type == 'umkm'
                              ? Colors.amber
                              : Colors.transparent,
                        ),
                        onPressed: () {
                          setState(() {
                            _type = 'umkm';
                          });
                        },
                        child: const Text(
                          'UMKM',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: _type == 'customer'
                              ? Colors.amber
                              : Colors.transparent,
                        ),
                        onPressed: () {
                          setState(() {
                            _type = 'customer';
                          });
                        },
                        child: const Text(
                          'Customer',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              (_type == 'umkm')
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Name",
                              icon: const Icon(Icons.people),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _name = value!;
                              });
                            },
                            onSaved: (String? value) {
                              setState(() {
                                _name = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "First Name",
                              icon: const Icon(Icons.people),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _firstName = value!;
                              });
                            },
                            onSaved: (String? value) {
                              setState(() {
                                _firstName = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'First name is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Last Name",
                              icon: const Icon(Icons.people),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _lastName = value!;
                              });
                            },
                            onSaved: (String? value) {
                              setState(() {
                                _lastName = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Last name is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_type == 'umkm') {
                      registerTwoUMKM(request, _name).then((value) {
                        if (value['success']) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('UMKM Role Chosen'),
                          ));
                          fetchUser(request, userProvider.user.id)
                              .then(((value) {
                            userProvider.user = value;
                            Navigator.pop(context);
                          }));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(value['message']),
                          ));
                        }
                      });
                    } else {
                      registerTwoCustomer(request, _firstName, _lastName)
                          .then((value) {
                        if (value['success']) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Customer Role Chosen'),
                          ));
                          fetchUser(request, userProvider.user.id)
                              .then(((value) {
                            userProvider.user = value;
                            Navigator.pop(context);
                          }));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(value['message']),
                          ));
                        }
                      });
                    }
                  }
                },
                child: const Text('Choose Role'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
