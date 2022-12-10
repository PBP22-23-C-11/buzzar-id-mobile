import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:buzzarid_mobile/lomba/model/peserta_lomba.dart';
import 'package:buzzarid_mobile/lomba/utils/fetchpeserta.dart';
import 'package:buzzarid_mobile/lomba/utils/updatelomba.dart';
import 'package:buzzarid_mobile/lomba/utils/votelomba.dart';
import 'package:buzzarid_mobile/common/models/user.dart';

class MyDetailPage extends StatefulWidget {
  MyDetailPage({
    super.key,
    required this.namaLomba,
    required this.keterangan,
    required this.tanggal,
    required this.berjalan,
    required this.id,
  });

  final bool berjalan;
  final String namaLomba;
  final DateTime tanggal;
  final String keterangan;
  final String id;

  @override
  State<MyDetailPage> createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
    late Future<List<PesertaLomba>> dataLomba = fetchPeserta(widget.id);

    void updatePeserta() {
      setState(() {
        dataLomba = fetchPeserta(widget.id);
      });
    }

    @override
    Widget build(BuildContext context) {
      final userProvider = context.watch<UserProvider>();

      return Scaffold(
        appBar: AppBar(
            title: Text('Detail Lomba'),
        ),

        // tinggal edit sesuai ketentuan soal
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center (
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  widget.namaLomba,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),
                textAlign: TextAlign.center,
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 7.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Tanggal Dimulai: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: (widget.tanggal).toString().substring(0,10)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 7.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Status: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: widget.berjalan ? "Berlangsung" : "Berakhir"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "Keterangan Lomba:",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 7.0),
              child: Text(
                widget.keterangan,
                style: const TextStyle(fontSize: 15.0)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                "Peserta Lomba:",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)
              ),
            ),
            FutureBuilder(
              future: dataLomba,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData || snapshot.data!.length == 0) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                      child: const 
                        Text(
                          "Tidak ada Peserta",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 15),
                        ),                      
                    );

                  // Terdapat data
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Card(
                              child: ListTile(
                                title: Text(snapshot.data![index].fields.namaKarya),
                                subtitle: Text("Jumlah Vote: " + snapshot.data![index].fields.jumlahVote.toString()),
                                trailing: (userProvider.user.type == 'Customer') ? 
                                  (IconButton(
                                    icon: const Icon(Icons.thumb_up),
                                    color: Colors.blue,
                                    onPressed: () {
                                      voteLomba(userProvider.user.username, snapshot.data![index].pk.toString());
                                      updatePeserta();
                                    },)) :
                                  (Text('')),
                              ),
                            ),
                          );
                        }
                      )
                    );
                  }
                }
              }
            ),
          ],
        ),

        floatingActionButton: (userProvider.user.type == 'Admin' && widget.berjalan) ?
          FloatingActionButton(
            backgroundColor: Colors.amber,
            child: Icon(Icons.done_all),
            onPressed: () {
              updateLomba(widget.id.toString());
              Navigator.pop(context);
            },
          ) :
          Container(),
      );
    }
}