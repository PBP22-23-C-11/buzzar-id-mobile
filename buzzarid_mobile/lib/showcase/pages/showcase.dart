import 'package:buzzarid_mobile/common/components/drawer.dart';
import 'package:buzzarid_mobile/showcase/models/umkm.dart';
import 'package:buzzarid_mobile/showcase/utils/fetchUmkm.dart';
import 'package:buzzarid_mobile/showcase/pages/infoUMKM.dart';
import 'package:flutter/material.dart';

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  late Future<List<UMKM>> futureDate;

  @override
  void initState() {
    super.initState();
    futureDate = fetchUMKM();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Showcase"),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: futureDate,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return Column(
                children: const [
                  Text(
                    "There's currently no UMKM registered",
                    style: TextStyle(
                      color: Color(0xff59A5D8),
                      fontSize: 20
                    )
                  ),
                  SizedBox(height: 9),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoUMKM(
                          owner: snapshot.data![index].fields.owner,
                          shopName: snapshot.data![index].fields.shopName,
                          category: snapshot.data![index].fields.category,
                          description: snapshot.data![index].fields.description,
                          umkmUrl: snapshot.data![index].fields.umkmUrl,
                          number: snapshot.data![index].fields.number,
                          image: snapshot.data![index].fields.image,
                          ratingTotal: snapshot.data![index].fields.ratingTotal,
                          ratingCount: snapshot.data![index].fields.ratingCount,
                        )
                      )
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 27, vertical: 9),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      border: Border.all(
                        width: 2.0,
                        color: Colors.lightBlueAccent,
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data![index].fields.shopName}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}