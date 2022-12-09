import 'package:flutter/material.dart';

class MyDetailPage extends StatefulWidget {
  MyDetailPage({
    super.key,
    required this.namaLomba,
    required this.keterangan,
    required this.tanggal,
    required this.berjalan,
  });

  final bool berjalan;
  final String namaLomba;
  final DateTime tanggal;
  final String keterangan;

  @override
  State<MyDetailPage> createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Detail Lomba'),
        ),

        // tinggal edit sxesuai ketentuan soal
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
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                widget.keterangan,
                style: const TextStyle(fontSize: 15.0)
              ),
            ),
          ],
        ),
      );
    }
}