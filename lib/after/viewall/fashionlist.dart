import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/productdeatils.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../screen/Users/cattegory_screen.dart';

class FashionList extends StatefulWidget {
  const FashionList({super.key});

  @override
  State<FashionList> createState() => _FashionListState();
}

class _FashionListState extends State<FashionList> {
  String selectedItem = 'Move to bag';
  String dropdownvalue = "All categories";

  String selectedBagItem = 'Delete item';

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Kidz Wear Fashion Shop",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 9,
                mainAxisSpacing: 9,
                childAspectRatio: (MediaQuery.of(context).size.width / 1) /
                    (MediaQuery.of(context).size.height / 1.2),
              ),
              itemCount: jeansCategory.length,
              itemBuilder: (BuildContext context, int index) {
                double containerWidth = MediaQuery.of(context).size.width /
                    2; // Adjust the width as needed

                return InkWell(
                  onTap: () {
                    Get.to(() => const Product_deatils(sourceName: "0",));
                  },
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade300, blurRadius: 2)
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.asset(
                              jeansCategory[index]["image"].toString(),
                              fit: BoxFit.cover,
                              height: h / 5,
                              width: w / 2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: h / 80, right: w / 50, left: w / 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: SizedBox(
                                    width: w / 2.09,
                                    child: Text(
                                      jeansCategory[index]["products"],
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          fontFamily: "Amazon_med"),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: w,
                                  child: Text(
                                    jeansCategory[index]["types"],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: "Ember_Light",
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 1,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      jeansCategory[index]["price"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Amazon_bold",
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      width: w / 60,
                                    ),
                                    Text(
                                      jeansCategory[index]["discount"],
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontFamily: "Amazon_bold",
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.grey,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      width: w / 60,
                                    ),
                                    // Text(
                                    //   jeansCategory[index]["offer"],
                                    //   style: const TextStyle(
                                    //       fontSize: 12,
                                    //       color: Colors.green,
                                    //       fontFamily: "Amazon_bold",
                                    //       overflow:
                                    //           TextOverflow.ellipsis),
                                    //   maxLines: 1,
                                    // ),
                                  ],
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      "Size : ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          //decoration: TextDecoration.lineThrough,
                                          fontFamily: "Ember_Display_Medium"),
                                    ),
                                    Text(
                                      " M",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Ember_Display_Medium"),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.shopping_bag,
                                        color: logocolo,
                                        size: h / 35,
                                      ),
                                      PopupMenuButton(
                                        color: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        initialValue: selectedItem,
                                        icon: const Icon(
                                          Icons.more_horiz,
                                          color: Colors.black,
                                        ),
                                        itemBuilder: (_) {
                                          return <PopupMenuEntry<String>>[
                                            const PopupMenuItem<String>(
                                              value: 'Move to bag',
                                              child: Text('Move to bag'),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: 'See reviews',
                                              child: Text('See reviews'),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: 'Report',
                                              child: Text('Report'),
                                            ),
                                          ];
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
