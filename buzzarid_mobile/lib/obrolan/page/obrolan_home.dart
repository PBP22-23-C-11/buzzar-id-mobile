// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'package:buzzarid_mobile/common/components/drawer.dart';
import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:buzzarid_mobile/obrolan/model/obrolan.dart';
import 'package:buzzarid_mobile/obrolan/page/add_obrolan.dart';
import 'package:buzzarid_mobile/obrolan/utilities/fetch_obrolan.dart';
import 'package:buzzarid_mobile/obrolan/widget/obrolan_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObrolanHomePage extends StatefulWidget {
  const ObrolanHomePage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/obrolan';

  @override
  State<ObrolanHomePage> createState() => _ObrolanHomePageState();
}

class _ObrolanHomePageState extends State<ObrolanHomePage> {
  @override
  Widget build(BuildContext context) {
    final username = context.watch<UserProvider>().user.username;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Obrolan'),
      ),
      drawer: const AppDrawer(),
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
                future: fetchObrolan(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Obrolan>? obrl = snapshot.data as List<Obrolan>;

                    return obrl.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Text(
                                'Press <+> button to add a new discussion',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: obrl.length,
                            itemBuilder: (context, index) {
                              return ObrolanCard(obrl[index]);
                            },
                          );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })),
        Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.amber, //New
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Container(
                color: Colors.transparent,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      const Spacer(),
                      FloatingActionButton(
                        heroTag: null,
                        backgroundColor: Colors.purple,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ObrolanHomePage()),
                          );
                        },
                        tooltip: 'Refresh',
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      if (username != 'guest') ...[
                        FloatingActionButton(
                          heroTag: null,
                          backgroundColor: Colors.green,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddObrolanPage()),
                            );
                          },
                          tooltip: 'Add Discussion',
                          child: const Icon(Icons.add, color: Colors.white),
                        )
                      ] else ...[
                        FloatingActionButton(
                          heroTag: null,
                          backgroundColor: Colors.green,
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Please login to add discussion"),
                            ));
                          },
                          tooltip: 'Add Discussion',
                          child: const Icon(Icons.add, color: Colors.white),
                        )
                      ],
                      const Spacer(),
                    ])))),
      ]),
    );
  }
}
