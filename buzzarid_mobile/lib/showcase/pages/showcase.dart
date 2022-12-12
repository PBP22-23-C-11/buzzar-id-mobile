import 'package:buzzarid_mobile/common/components/drawer.dart';
import 'package:buzzarid_mobile/showcase/models/UMKM.dart';
import 'package:buzzarid_mobile/showcase/models/cardsAndCategoryHelper.dart';
import 'package:buzzarid_mobile/showcase/utils/fetchUMKM.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../common/providers/user_provider.dart';

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({
    super.key,
    required this.category,
  });

  final String category;

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  late Future<List<UMKM>> futureData;



  Future<void> submit(CookieRequest request, int id) async {
    final response = await request.postJson(
        'https://buzzar-id.up.railway.app/showcase/rate_shop_flutter/',
        jsonEncode({
          "id": id,
        })
    );
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchUMKM(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final userProv = context.watch<UserProvider>();
    final userType = userProv.user.type;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      drawer: const AppDrawer(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
                future: futureData,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.data!.length == 0) {
                      return const Center(
                        child: Text(
                          "There's currently no UMKM registered",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w200,
                          ),
                        )
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0)
                                      ),
                                      child:
                                      Stack(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                              top: 82.0,
                                              bottom: 16.0,
                                              left: 16.0,
                                              right: 16.0,
                                            ),
                                            margin: const EdgeInsets.only(top: 66.0),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                catCol[snapshot.data![index].fields.category]![0],
                                                catCol[snapshot.data![index].fields.category]![1]
                                              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.circular(16.0),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 10.0,
                                                  offset: Offset(0.0, 10.0),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  snapshot.data![index].fields.shopName,
                                                  style: const TextStyle(
                                                    fontSize: 30.0,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(height: 3.0),
                                                Text(
                                                  snapshot.data![index].fields.category,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                const SizedBox(height: 12.0),
                                                Text(
                                                  snapshot.data![index].fields.description,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                const SizedBox(height: 12.0),
                                                Text(
                                                  "${snapshot.data![index].fields.umkmUrl}"
                                                      "\n${snapshot.data![index].fields.number}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 12.0
                                                  ),
                                                ),
                                                const SizedBox(height: 24.0),
                                                Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      TextButton( // Edit ke Django
                                                          onPressed: () {
                                                            if (userType == "Customer") {
                                                              submit(request, snapshot.data![index].pk);
                                                              Navigator.pop(context);
                                                              Navigator.pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ShowcasePage(category: widget.category)
                                                                  )
                                                              );
                                                            }
                                                            else {
                                                              Navigator.pop(context);
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return Dialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(16.0)
                                                                        ),
                                                                        child: GestureDetector(
                                                                          onTap: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Container(
                                                                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                                                            decoration: BoxDecoration(
                                                                              gradient: const LinearGradient(colors: [
                                                                                Colors.lightBlueAccent,
                                                                                Colors.blueGrey
                                                                              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                                                              shape: BoxShape.rectangle,
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                              boxShadow: const [
                                                                                BoxShadow(
                                                                                  color: Colors.black26,
                                                                                  blurRadius: 10.0,
                                                                                  offset: Offset(0.0, 10.0),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            child: const Center(
                                                                              child: Text(
                                                                                "Sorry, you have to be a Customer.\n\n"
                                                                                    "Please reload after you logged in as Customer.",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                    fontWeight: FontWeight.w400,
                                                                                    fontSize: 26
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                    );
                                                                  }
                                                              );
                                                            }
                                                          },
                                                          child: const Text(
                                                            "Give Star",
                                                            style: TextStyle(
                                                                color: Colors.black
                                                            ),
                                                          )
                                                      ),
                                                      TextButton(
                                                          onPressed: () { Navigator.pop(context); },
                                                          child: const Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: Colors.black
                                                            ),
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                              top: 7.0,
                                              left: 16.0,
                                              right: 16.0,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(snapshot.data![index].fields.image),
                                                radius: 66.0,
                                              )
                                          )
                                        ],
                                      )
                                  );
                                }
                            );
                          },
                          child: Container(
                              margin: const EdgeInsets.only(bottom: 32),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  catCol[snapshot.data![index].fields.category]![0],
                                  catCol[snapshot.data![index].fields.category]![1]
                                  ], begin: Alignment.centerLeft, end: Alignment.centerRight
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: catCol[snapshot.data![index].fields.category]![1].withOpacity(0.4),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                    offset: const Offset(4,4),
                                  )
                                ],
                                borderRadius: const BorderRadius.all(Radius.circular(24)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.category_rounded,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            snapshot.data![index].fields.category,
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const WidgetSpan(
                                              child:  Icon(
                                                Icons.star_rate_rounded,
                                                color: Colors.white,
                                                size: 26,
                                               ),
                                             ),
                                             TextSpan(
                                               text: "${snapshot.data![index].fields.ratingCount}"
                                             )
                                           ]
                                         )
                                       ),
                                    ],
                                  ),
                                  Text(
                                    "${snapshot.data![index].fields.umkmUrl}",
                                    style: const TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${snapshot.data![index].fields.shopName}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                        ),
                      );
                    }
                  }
                },
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Back",
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}