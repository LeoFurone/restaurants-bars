import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:restaurants_bars/fire_store_database.dart';
import 'package:restaurants_bars/main.dart';
import 'package:restaurants_bars/style.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'Controllers/mainPageController.dart';
import 'Modals/product.dart';
import 'Routes/app_routes.dart';

class Page1 extends StatelessWidget {
  Page1({Key? key}) : super(key: key);

  // final ItemScrollController contentScrollController = ItemScrollController();
  final ScrollController contentController = ScrollController();
  final MainPageController mainPageController = Get.put(MainPageController());
  Map<int, List<dynamic>> heightSections = {};
  int selectedItem = 0;

  Future<DocumentSnapshot> fetchConfig() async {
    return FirebaseFirestore.instance
        .collection('borelli-taquaritinga')
        .doc('config')
        .get();
  }

  Future<QuerySnapshot> fetchSections() async {
    return FirebaseFirestore.instance
        .collection('borelli-taquaritinga')
        .doc('config')
        .collection('sections')
        .get();
  }

  Future<QuerySnapshot> fetchProductsBySection(String section) async {
    return FirebaseFirestore.instance
        .collection('borelli-taquaritinga')
        .doc('config')
        .collection('products')
        .where("section", isEqualTo: section)
        .get();
  }

  Future<String> getImage(String url) async {
    return await FireStoreDatabase().getData(url);
  }

  Future<Map> fetchAllData() async {
    Map returnFunction = {};
    DocumentSnapshot dataConfig = await fetchConfig();
    returnFunction["config"] = {
      "tittle": dataConfig.get('tittle'),
      "icon": dataConfig.get('icon'),
      "type": dataConfig.get('type'),
    };

    QuerySnapshot dataSections = await fetchSections();
    Map mapSections = {};
    for (int j = 0; j < dataSections.size; j++) {
      // listSections.add(dataSections.docs[j].data());
      mapSections[dataSections.docs[j]["priority"]] = [
        dataSections.docs[j]["tittle"],
        dataSections.docs[j].id
      ];
    }

    returnFunction["sections"] = mapSections;

    // String coverURL = await getImage('borelli-taquaritinga/poc_cover.png');
    // String pocURL = await getImage('borelli-taquaritinga/poc_profile.png');
    // returnFunction["images"] = {
    //   "cover": coverURL,
    //   "profile": pocURL,
    // };

    print(returnFunction);
    return returnFunction;
  }

  void calculateHeightSections(String id, int index, int nProducts) {
    // heightSections[id] = [(118 * nProducts.toDouble()) + 2 + 67, index];
    heightSections[index] = [(118 * nProducts.toDouble()) + 2 + 67, id];
    // print(heightSections);
  }

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = 450;

    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var safeArea = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 768,
              minWidth: 300,
            ),
            child: FutureBuilder<Map>(
              future: fetchAllData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<dynamic, dynamic>? dados = snapshot.data;

                  return Column(
                    children: [
                      Container(
                        height: safeArea,
                        width: tamanhoTela,
                        color: mainColor,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: tamanhoTela,
                            height: heightScreen * 0.15,
                            child: FutureBuilder(
                              future: getImage('borelli-taquaritinga/poc_cover.png'),
                              builder: (context, snapshot_cover) {
                                if (snapshot_cover.connectionState == ConnectionState.done) {
                                  return Image.network(snapshot_cover.data.toString(),
                                      fit: BoxFit.cover);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                          Opacity(
                            opacity: 0.75,
                            child: Container(
                              width: tamanhoTela,
                              height: heightScreen * 0.15,
                              color: mainColor,
                            ),
                          ),
                          Container(
                            height: heightScreen * 0.15,
                            width: tamanhoTela,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dados?["config"]["tittle"],
                                          style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                                iconDefinition(
                                                    dados?["config"]["icon"]),
                                                color: Colors.white,
                                                size: 24),
                                            SizedBox(width: 4),
                                            Text(
                                              dados?["config"]["type"],
                                              style: GoogleFonts.quicksand(
                                                color: Colors.white,
                                                fontSize: 12,
                                                // fontWeight: FontWeight.w600,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: FutureBuilder(
                                      future: getImage(
                                          'borelli-taquaritinga/poc_profile.png'),
                                      builder: (context, snapshotProfile) {
                                        if (snapshotProfile.connectionState ==
                                            ConnectionState.done) {
                                          return CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(snapshotProfile.data.toString()),
                                          );
                                        } else {
                                          return CircleAvatar(
                                            radius: 50,
                                            backgroundColor: mainColor,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 44,
                        width: tamanhoTela,
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 30,
                          // color: Colors.blue,
                          child: ListView.builder(
                            itemCount: dados?["sections"].length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  double distance = 0;
                                  for (int cont = 0; cont < index; cont++) {
                                    distance = distance +
                                        double.parse(heightSections[cont]![0]
                                            .toString());
                                  }

                                  contentController.animateTo(distance,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: InkWell(
                                      child: itemMenu(
                                          true, dados?["sections"][index][0])),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      myLine(tamanhoTela),
                      Expanded(
                        child: Container(
                          width: tamanhoTela,
                          color: Colors.white,
                          child: ListView.builder(
                            controller: contentController,
                            itemCount: dados?["sections"].length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return FutureBuilder<QuerySnapshot>(
                                  future: fetchProductsBySection(
                                      dados?["sections"][index][1]),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.data!.docs.length > 0) {
                                        calculateHeightSections(
                                            dados?["sections"][index][1],
                                            index,
                                            snapshot.data!.docs.length);

                                        List<Product> products = [];

                                        for (int n_docs = 0;
                                            n_docs < snapshot.data!.docs.length;
                                            n_docs++) {
                                          Product newProduct = Product(
                                              snapshot.data!.docs[n_docs].id,
                                              snapshot.data!.docs[n_docs]
                                                  ["tittle"],
                                              snapshot.data!.docs[n_docs]
                                                  ["description"],
                                              snapshot.data!.docs[n_docs]
                                                  ["min_price"],
                                              snapshot.data!.docs[n_docs]
                                                  ["image"]);
                                          products.add(newProduct);
                                        }
                                        return sectionPoc(
                                            tamanhoTela,
                                            dados?["sections"][index][0],
                                            products);
                                      } else {
                                        return Container();
                                      }
                                    } else {
                                      return Container();
                                    }
                                  });
                              // return sectionPoc(tamanhoTela, dados?["sections"][index][0], productsTest);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    width: tamanhoTela,
                    height: heightScreen,
                    color: Colors.black,
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/restaurants-bars.appspot.com/o/lf_white.png?alt=media&token=c4319578-4641-43a0-8e24-4d3f58188441'),
                  );
                }
              },
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // contentController.jumpTo(106.14999999999998);
      //     // contentController.animateTo(mainPageController.heightSections['H8nvVjZVpyi4SsE3fRuL']![0], duration: Duration(seconds: 1), curve: Curves.ease);
      //     contentController.animateTo(heightSections['W8jr8fd3NQF6Kasd8JZl']![0] + 23, duration: Duration(seconds: 1), curve: Curves.ease);
      //     // contentScrollController.scrollTo(index: 1, duration: Duration(seconds: 2));
      //     // contentScrollController.printInfo();
      //   },
      // ),
    );
  }

  Container myLine(double tamanhoTela) {
    return Container(
      width: tamanhoTela,
      color: Colors.white,
      alignment: Alignment.center,
      child: Container(
        width: tamanhoTela,
        height: 1,
        decoration: const BoxDecoration(
            color: Colors.white70,
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 4)]),
      ),
    );
  }

  IconData iconDefinition(String icon) {
    switch (icon) {
      // só add abaixo do case, não precisa abrir {}
      case "ice_cream":
        return LineAwesomeIcons.ice_cream;
      case "hamburger":
        return LineAwesomeIcons.hamburger;
      default:
        return LineAwesomeIcons.book;
    }
  }

  Container sectionPoc(
      double widthScreen, String tittle, List<Product> products) {
    return Container(
      width: widthScreen,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 31),
          Container(
            height: 28,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                tittle,
                style: GoogleFonts.quicksand(
                  color: mainColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // por causa do single chield scroll view na árvore!!
            itemCount: products.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == 0) {
                // preço lateral (sem foto)
                return Column(
                  children: [
                    myLine(widthScreen), // 2
                    contentItemProduct(widthScreen, products, index), // 116
                    myLine(widthScreen) // 2
                  ],
                );
              } else {
                // com foto
                return Column(
                  children: [
                    contentItemProduct(widthScreen, products, index), // 116
                    myLine(widthScreen)
                  ],
                );
              }
              // return Text(products[index].tittle);
            },
          ),
        ],
      ),
    );
  }

  Container contentItemProduct(
      double widthScreen, List<Product> products, int index) {
    return Container(
      height: 116,
      // width: widthScreen,
      color: Color.fromRGBO(244, 244, 244, 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // 16
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      height: 24,
                      width: double.infinity,
                      // color: Colors.blue,
                      child: Text(
                        products[index].tittle,
                        style: GoogleFonts.quicksand(
                          color: mainColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      height: 30,
                      // color: Colors.red,
                      child: Text(
                        products[index].description,
                        style: GoogleFonts.quicksand(
                          color: mainColor,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // 8
                  Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Column(
                        children: [
                          minValueWidget(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                LineAwesomeIcons.wavy_money_bill,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "R\$ " +
                                    products[index]
                                        .price
                                        .toStringAsFixed(2)
                                        .replaceAll('.', ','),
                                style: GoogleFonts.quicksand(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            products[index].image
                ? Flexible(
                    flex: 1,
                    child: LayoutBuilder(builder: (_, constraints) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          color: mainColor,
                          width: constraints.maxWidth,
                          height: constraints.maxWidth,
                          child: FutureBuilder<String>(
                            future: getImage('borelli-taquaritinga/products/' +
                                products[index].id +
                                ".png"),
                            builder: (context, snapshot2) {
                              if (snapshot2.connectionState ==
                                  ConnectionState.done) {
                                return Image.network(snapshot2.data.toString(),
                                    fit: BoxFit.cover);
                              }
                              return Container();
                            },
                          ),
                        ),
                      );
                    }),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Text minValueWidget() {
    return Text(
      'A PARTIR DE',
      style: GoogleFonts.quicksand(
        color: Colors.white,
        fontSize: 8,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container itemMenu(bool selected, String title) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: selected
            ? const Color.fromRGBO(233, 233, 233, 1)
            : const Color.fromRGBO(233, 233, 233, 0.66),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: GoogleFonts.quicksand(
              fontSize: 12,
              color: selected ? mainColor : Color.fromRGBO(47, 67, 40, 0.66),
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
