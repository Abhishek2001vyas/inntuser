import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/after/viewall/filter.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../../Controller/text2.dart';
import '../../after/viewall/fashionlist.dart';
import '../Users/add_address/add_address.dart';
import '../Users/cattegory_screen.dart';

class InntOutInformationShop extends StatefulWidget {
  const InntOutInformationShop({super.key});

  @override
  State<InntOutInformationShop> createState() => _InntOutInformationShopState();
}

class _InntOutInformationShopState extends State<InntOutInformationShop> {
  String selectedItem = 'Move to bag';
  String dropdownvalue = "All categories";
  List<String> categorie = [
    "All categories",
    "Food",
    "Fashion",
    "Beauty",
    "Home Appliances",
    "Gadget",
    "Toys"
  ];
  String dropdownFilter = "Filter";
  List<String> filter = [
    "Filter",
    "Food",
    "Fashion",
    "Beauty",
    "Home Appliances",
    "Gadget",
    "Toys"
  ];
  String selectedBagItem = 'Delete item';

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: Image.asset(
              "assets/images/back.png",
              fit: BoxFit.cover,
              height: 5,
              width: 5,
            ),
          ),
        ),
        backgroundColor: secondryColor,
        elevation: 0,
        // forceMaterialTransparency: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: h / 25,
              width: w / 1.5,
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    hintText: "Search in innt out",
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    fillColor: const Color(0xffeef1f5),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(7))),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const AddAddress());
              },
              child: Image.asset(
                "assets/images/map.png",
                fit: BoxFit.fill,
                color: Colors.white,
                height: h / 25,
                width: w / 15,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              height: h / 4.5,
              width: w / 1,
              child: Image.asset("assets/images/2023-06-14-648870b2eec5b.png",
                  fit: BoxFit.fill),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.grey.shade100, blurRadius: 1)
              ]),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade100,
                        radius: 22,
                        child: Image.asset(
                          "assets/images/shops.png",
                          color: logocolo,
                          height: 22,
                          width: 22,
                        ),
                      ),
                      SizedBox(
                        width: w / 90,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The only genuine store of\nmakeup and perfume",
                            style: A_style_order,
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: h / 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey.shade300,
                              ),
                              Text(
                                "Indore MadhyaPradesh",
                                style: A_style_mid,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      PopupMenuButton(
                        padding: const EdgeInsets.all(0),
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        initialValue: selectedItem,
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                        ),
                        itemBuilder: (_) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              height: h / 25,
                              value: 'Chat',
                              child: const Row(
                                children: [
                                  Text("Chat"),
                                  Spacer(),
                                  Icon(
                                    Icons.message_outlined,
                                    size: 20,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem<String>(
                              height: h / 25,
                              value: 'Share',
                              child: Row(
                                children: [
                                  const Text("Share"),
                                  const Spacer(),
                                  Image.asset(
                                    "assets/images/share.png",
                                    width: w / 27,
                                    height: h / 27,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem<String>(
                              height: h / 25,
                              value: 'Add to favorites',
                              child: Row(
                                children: [
                                  const Text("Add to favorites"),
                                  const Spacer(),
                                  Icon(Icons.star_border,
                                      size: h / 27, color: Colors.black),
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem<String>(
                              height: h / 25,
                              value: 'Report',
                              child: const Row(
                                children: [
                                  Text("Report"),
                                  Spacer(),
                                  Icon(
                                    Icons.report_problem_outlined,
                                    size: 20,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ];
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                  IntrinsicHeight(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: w / 3.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Rating",
                                  style: A_style_mid_black,
                                ),
                                SizedBox(
                                  height: h / 100,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        size: 20,
                                        color: Colors.yellow.shade800),
                                    Icon(Icons.star,
                                        size: 20,
                                        color: Colors.yellow.shade800),
                                    Icon(Icons.star,
                                        size: 20,
                                        color: Colors.yellow.shade800),
                                    Icon(Icons.star,
                                        size: 20,
                                        color: Colors.yellow.shade800),
                                    Icon(Icons.star,
                                        size: 20,
                                        color: Colors.yellow.shade800),
                                  ],
                                ),
                                SizedBox(
                                  height: h / 100,
                                ),
                                Text(
                                  "1356",
                                  style: A_style_mid_black,
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            thickness: 2,
                            indent: 6,
                            endIndent: 6,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: w / 3.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Products",
                                  style: A_style_mid_black,
                                ),
                                SizedBox(
                                  height: h / 100,
                                ),
                                Image.asset(
                                  "assets/images/products.png",
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(
                                  height: h / 100,
                                ),
                                Text(
                                  "85",
                                  style: A_style_mid_black,
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            thickness: 2,
                            indent: 6,
                            endIndent: 6,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: w / 3.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Sales",
                                  style: A_style_mid_black,
                                ),
                                SizedBox(
                                  height: h / 100,
                                ),
                                Image.asset(
                                  "assets/images/sales.png",
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(
                                  height: h / 100,
                                ),
                                Text(
                                  "13.1k",
                                  style: A_style_mid_black,
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            indent: 6,
                            endIndent: 6,
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: w / 3.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Page views",
                                  style: A_style_mid_black,
                                ),
                                SizedBox(
                                  height: h / 100,
                                ),
                                Image.asset(
                                  "assets/images/eyes.png",
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(
                                  height: h / 100,
                                ),
                                Text(
                                  "101k",
                                  style: A_style_mid_black,
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            indent: 6,
                            endIndent: 6,
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: w / 3.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Liked items",
                                  style: A_style_mid_black,
                                ),
                                SizedBox(
                                  height: h / 100,
                                ),
                                const Icon(
                                  Icons.favorite,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: h / 100,
                                ),
                                Text(
                                  "10k",
                                  style: A_style_mid_black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: w / 3.5,
                  child: DropdownButton(
                    style: A_style_medium,
                    underline: const SizedBox(),
                    // Initial Value
                    value: dropdownvalue,
                    hint: const Text('select'),
                    isExpanded: true,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.black, size: 20),

                    // Array list of items
                    items: categorie.map((String? items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items!,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue ?? "";
                      });
                    },
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const Filter());
                  },
                  child: Row(
                    children: [
                      Text(
                        'Filter',
                        style: A_style_medium,
                      ),
                      const Icon(Icons.keyboard_arrow_down,
                          color: Colors.black, size: 20),
                    ],
                  ),
                ),
                SizedBox(
                  width: w / 30,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const FashionList());
                  },
                  child: const Icon(
                    Icons.format_list_bulleted,
                    color: Colors.black,
                  ),
                )
              ],
            ),
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
                    // Get.to(() => const Product_deatils());
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
                              "assets/images/burger.png",
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
                                SizedBox(
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
