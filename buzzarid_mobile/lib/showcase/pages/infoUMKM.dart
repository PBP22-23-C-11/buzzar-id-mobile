import 'package:flutter/material.dart';
import 'package:buzzarid_mobile/common/components/drawer.dart';

class InfoUMKM extends StatefulWidget {
  const InfoUMKM({
    super.key,
    required this.owner,
    required this.shopName,
    required this.category,
    required this.description,
    required this.umkmUrl,
    required this.number,
    required this.image,
    required this.ratingTotal,
    required this.ratingCount,
  });

  final int owner;
  final String shopName;
  final String category;
  final String description;
  final String umkmUrl;
  final String number;
  final String image;
  final int ratingTotal;
  final int ratingCount;

  @override
  State<InfoUMKM> createState() => _InfoUMKMState();
}

class _InfoUMKMState extends State<InfoUMKM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UMKM"),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Text(widget.shopName),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      left: 10,
                      right: 10,
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Back"
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}