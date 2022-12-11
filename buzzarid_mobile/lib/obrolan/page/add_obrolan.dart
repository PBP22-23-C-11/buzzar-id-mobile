// ignore_for_file: constant_identifier_names
import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:buzzarid_mobile/obrolan/page/obrolan_home.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddObrolanPage extends StatefulWidget {
  const AddObrolanPage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/add-obrolan';

  @override
  State<AddObrolanPage> createState() => _ObrolanHomePageState();
}

class _ObrolanHomePageState extends State<AddObrolanPage> {
  final _formKey = GlobalKey<FormState>();

  // Saved variables to be submitted
  String _typedToWho = "";
  String _typedTitle = "";
  String _typedMessage = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final username = context.watch<UserProvider>().user.username;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Discussion'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Add your discussion here!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.sticky_note_2),
                      hintText: 'Username receiver',
                      labelText: 'Send to',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _typedToWho = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        _typedToWho = value!;
                      });
                    },
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Username cannot be empty.'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.sticky_note_2),
                      hintText: 'Example: <Reply>',
                      labelText: 'Title',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _typedTitle = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        _typedTitle = value!;
                      });
                    },
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Title cannot be empty.'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.sticky_note_2),
                      hintText: 'Write your message here',
                      labelText: 'Message',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _typedMessage = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        _typedMessage = value!;
                      });
                    },
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Message cannot be empty.'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF0B36A8)),
                    ),
                    onPressed: () async {
                      if (username != "guest") {
                        if (_formKey.currentState!.validate()) {
                          await request
                              .postJson(
                                  "https://buzzar-id.up.railway.app/obrolan/add-disc-flutter",
                                  convert.jsonEncode(<String, String>{
                                    'username': username,
                                    'title': _typedTitle,
                                    'toWho': _typedToWho,
                                    'message': _typedMessage,
                                  }))
                              .then((value) {
                            if (!mounted) return;
                            if (value != null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Discussion saved successfully!"),
                              ));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ObrolanHomePage()),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("An Error Occured"),
                              ));
                            }
                          });
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please login to add discussion"),
                        ));
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF8F00),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ObrolanHomePage()),
          );
        },
        tooltip: 'Back',
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
