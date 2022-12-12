import 'package:flutter/material.dart';
import 'package:buzzarid_mobile/common/components/drawer.dart';
import 'package:buzzarid_mobile/showcase/models/cardsAndCategoryHelper.dart';
import 'package:buzzarid_mobile/showcase/pages/showcase.dart';
import 'package:buzzarid_mobile/showcase/pages/addUMKM.dart';
import 'package:provider/provider.dart';
import 'package:buzzarid_mobile/common/providers/user_provider.dart';

class ShowcaseHome extends StatefulWidget {
  const ShowcaseHome({super.key});

  @override
  State<ShowcaseHome> createState() => _ShowcaseHomeState();
}

class _ShowcaseHomeState extends State<ShowcaseHome> {
  final double _borderRadius = 24;

  @override
  Widget build(BuildContext context) {
    final userProv = context.watch<UserProvider>();
    final userType = userProv.user.type;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Showcase"),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: const [
                Text(
                  "Welcome To Showcase!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Take a look at creative UMKMs from Indonesia brought by Buzzar!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => ShowcasePage(
                          category: items[index].category)
                      )
                    );
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(_borderRadius),
                              gradient: LinearGradient(colors: [
                                items[index].startColor,
                                items[index].endColor
                              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                              boxShadow: [
                                BoxShadow(
                                  color: items[index].endColor,
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            top: 0,
                            child: CustomPaint(
                              size: const Size(100, 150),
                              painter: CustomCardShapePainter(_borderRadius,
                                items[index].startColor, items[index].endColor),
                            ),
                          ),
                          Positioned.fill(
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.category_rounded,
                                    size: 64,
                                  )
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        items[index].category,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 22,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        items[index].explanation,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add UMKM",
        child: const Icon(Icons.add),
        onPressed: () {
          if (userType=="UMKM") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddUMKMPage()
              )
            );
          }
          else {
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
                          "Sorry, you have to be an UMKM and haven't registered a shop as the owner.\n\n"
                          "Please reload after you logged in as UMKM.",
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
      ),
    );
  }
}

