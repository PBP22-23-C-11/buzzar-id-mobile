import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:buzzarid_mobile/common/components/drawer.dart';
import 'package:buzzarid_mobile/lomba/model/lomba_data.dart';
import 'package:buzzarid_mobile/lomba/utils/fetchdata.dart';
import 'package:buzzarid_mobile/common/models/user.dart';
import 'package:buzzarid_mobile/lomba/page/detail_lomba.dart';
import 'package:buzzarid_mobile/lomba/utils/sendlomba.dart';
import 'package:buzzarid_mobile/lomba/page/buat_lomba.dart';

class LombaPage extends StatefulWidget {
    const LombaPage({super.key});

    @override
    State<LombaPage> createState() => _LombaPageState();
}

class _LombaPageState extends State<LombaPage> {
    late Future<List<Lomba>> dataLomba = fetchLomba();
    final myController = TextEditingController();

    void filteredLomba() {
      setState(() {
        dataLomba = fetchLomba();
      });
    }

    Padding makeCard(namaLomba, keterangan, tanggal, berjalan, id) {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyDetailPage(
                  namaLomba: namaLomba,
                  keterangan: keterangan,
                  tanggal: tanggal,
                  berjalan: berjalan,
                  id: id.toString(),
                )),
              ).then((value) {
                filteredLomba();
              });
            },
            title: Text(namaLomba),
            trailing: Icon(Icons.keyboard_arrow_right),
            subtitle: (berjalan) ? Text("Berlangsung") : Text("Berakhir"),
          ),
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      final userProvider = context.watch<UserProvider>();
  
      return Scaffold(
        appBar: AppBar(
            title: Text("Perlombaan"),
        ),
        // drawer: const AppDrawer(),
        body: Column(
          children: <Widget>[

            // Jika guest
            (userProvider.user.isGuest) ? 
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Data Perlombaan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ) :

              // Jika non guest
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Data Perlombaan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            controller: myController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Masukkan kata kunci',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: IconButton(
                            icon: const Icon(Icons.search),
                            color: Colors.amber,
                            onPressed: () {
                              filteredLomba();
                            },
                            splashRadius: 20.0,
                          ),
                        ),
                      ]
                    )
                  ),
                  (userProvider.user.type == 'Admin') ?
                  Padding(padding: const EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: Text(
                        "Buat Lomba Baru",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BuatLomba())).then((value) {
                          filteredLomba();
                        });
                      },
                    ),
                  ) :
                  Padding(padding: const EdgeInsets.only(left: 5.0),)
                ]
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
                  if (!snapshot.hasData) {
                    return Column(
                      children: const [
                        Text(
                          "Tidak ada Lomba",
                          style: TextStyle(
                              color: Color(0xff59A5D8),
                              fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );

                  // Jika bukan admin, hanya tampilkan yg berjalan
                  } else {
                    if (!(userProvider.user.type == 'Admin')) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) {
                            if (snapshot.data![index].fields.berjalan) {

                              // Cek apakah pakai pencarian
                              if (((snapshot.data![index].fields.namaLomba).toLowerCase()).contains((myController.text).toLowerCase())) {
                                return makeCard(snapshot.data![index].fields.namaLomba,
                                  snapshot.data![index].fields.keterangan,
                                  snapshot.data![index].fields.tanggal,
                                  snapshot.data![index].fields.berjalan,
                                  snapshot.data![index].pk,
                                );
                                
                              // Kembalikan element kosong
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                );
                              }

                            // Kembalikan element kosong
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 0.0),
                              );
                            }
                          } 
                        )
                      );
                    
                    // jika admin, tampilin semua
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) {
                            
                            // Cek apakah pakai pencarian
                            if (((snapshot.data![index].fields.namaLomba).toLowerCase()).contains((myController.text).toLowerCase())) {
                              return makeCard(snapshot.data![index].fields.namaLomba,
                                snapshot.data![index].fields.keterangan,
                                snapshot.data![index].fields.tanggal,
                                snapshot.data![index].fields.berjalan,
                                snapshot.data![index].pk,
                              );
                            
                            // Kembalikan element kosong
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 0.0),
                              );
                            }
                          }
                        )
                      );
                    }
                  }
                }
              }
            )
          ]
        ),
      );
    }
}