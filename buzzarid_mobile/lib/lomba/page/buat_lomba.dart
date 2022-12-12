import 'package:flutter/material.dart';
import 'package:buzzarid_mobile/lomba/utils/sendlomba.dart';

class BuatLomba extends StatefulWidget {
    const BuatLomba({super.key});

    @override
    State<BuatLomba> createState() => _BuatLombaState();
}

class _BuatLombaState extends State<BuatLomba> {
  final _loginFormKey = GlobalKey<FormState>();

  String _nama = '';
  String _ket = '';

    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
              title: Text('Buat Lomba'),
          ),
          body: Center(
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nama Lomba
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Nama Lomba",
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
                          return 'Nama Lomba tidak boleh kosong';
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
                  ElevatedButton(
                    onPressed: () {
                      if (_nama == '' || _ket == '') {
                        final snackBar = SnackBar(
                          content: Text("Gagal membuat lomba, silahkan cek isian Anda"),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        sendLomba(_nama, _ket);
                        Navigator.pop(context);
                      }
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