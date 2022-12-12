import 'package:buzzarid_mobile/common/utils/user_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class RegisterOnePage extends StatefulWidget {
  const RegisterOnePage({super.key});

  @override
  State<RegisterOnePage> createState() => _RegisterOnePageState();
}

class _RegisterOnePageState extends State<RegisterOnePage> {
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password1 = '';
  String _password2 = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Step 1'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Username
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    icon: const Icon(Icons.people),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _username = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      _username = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
              ),
              // Password
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _password1 = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      _password1 = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Re-Type Password',
                    icon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _password2 = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      _password2 = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Re-type your password';
                    }
                    if (value != _password1) {
                      return 'Re-typed password is different';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    registerOne(request, _username, _password1, _password2)
                        .then((value) {
                      if (!mounted) return;
                      if (value['success']) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('User Registered'),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(value['message']),
                        ));
                      }
                    });
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
