import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DaftarLomba extends StatefulWidget {
    const DaftarLomba({super.key, required this.id,});

    final String id;

    @override
    State<DaftarLomba> createState() => _DaftarLombaState();
}

class _DaftarLombaState extends State<DaftarLomba> {
  final _loginFormKey = GlobalKey<FormState>();

  String _nama = '';
  String _ket = '';
  String _situs = '';

    @override
    Widget build(BuildContext context) {
      final userProvider = context.watch<UserProvider>();

        return Scaffold(
          appBar: AppBar(
              title: Text('Daftar Lomba'),
          ),
          body: Center(
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Nama Karya
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Nama Karya",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _nama = value!;
                        });
                      },
                      onSaved: (String? value) {
                        setState(() {
                          _nama = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Karya tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),

                  // Keterangan
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
                    child: TextFormField(
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: "Keterangan",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _ket = value!;
                        });
                      },
                      onSaved: (String? value) {
                        setState(() {
                          _ket = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Keterangan tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),

                  // Situs
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Situs Karya",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _situs = value!;
                        });
                      },
                      onSaved: (String? value) {
                        setState(() {
                          _situs = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Situs Karya tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),

                  // Submit Button
                  ElevatedButton(
                    onPressed: () async {

                      String msg = '';
                      if (_nama == '' || _ket == '') {
                        msg = 'error';
                      } else {
                        var map = new Map<String, dynamic>();
                        map['umkm'] = userProvider.user.username;
                        map['nama-karya'] = _nama;
                        map['keterangan'] = _ket;
                        map['situs-karya'] = _situs;

                        final response = await http.post(
                          Uri.parse('https://buzzar-id.up.railway.app/lomba/flutter/daftar/' + widget.id),
                          body: map,
                        );

                        msg = response.body;
                      }

                      final snackBar = SnackBar(
                        content: Text(msg),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: const Text('Buat Lomba'),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}