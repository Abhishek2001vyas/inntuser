import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/sellers/sellercontroller.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../../Controller/text2.dart';
import 'cattegory_screen.dart';

class ProfileSavedItems extends StatefulWidget {
  const ProfileSavedItems({super.key});

  @override
  State<ProfileSavedItems> createState() => _ProfileSavedItemsState();
}

var dismis = GlobalKey<FormState>();

class _ProfileSavedItemsState extends State<ProfileSavedItems>
    with TickerProviderStateMixin {
  // final changeviews = Get.put(wishlist());
  bool isChecked = false;
  final changeviews = Get.put(Seller());
  String selectedItem = 'Move to bag';
  String selectedBagItem = 'Delete item';
  bool qq = false;

  @override
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        titleSpacing: 10,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                const Spacer(),
                const Text("Saved"),
                const Spacer(),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: h / 25,
                  width: w / 1.48,
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Search in innt",
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black),
                        fillColor: const Color(0xffeef1f5),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(7))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: w / 15,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: PopupMenuButton(
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        initialValue: selectedBagItem,
                        icon: const Icon(
                          Icons.filter_list_outlined,
                          color: white,
                        ),
                        itemBuilder: (_) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              height: h / 25,
                              value: 'Low to High',
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    size: 4,
                                  ),
                                  SizedBox(
                                    width: w / 80,
                                  ),
                                  const Text("Low to High"),
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem<String>(
                              height: h / 25,
                              value: 'High to low',
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    size: 4,
                                  ),
                                  SizedBox(
                                    width: w / 80,
                                  ),
                                  const Text("High to Low"),
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem<String>(
                              height: h / 25,
                              value: 'Most recent',
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    size: 4,
                                  ),
                                  SizedBox(
                                    width: w / 80,
                                  ),
                                  const Text("Most recent"),
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem<String>(
                              height: h / 25,
                              value: 'Least recent',
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    size: 4,
                                  ),
                                  SizedBox(
                                    width: w / 80,
                                  ),
                                  const Text("Least recent"),
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem<String>(
                              height: h / 25,
                              value: 'Price',
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    size: 4,
                                  ),
                                  SizedBox(
                                    width: w / 80,
                                  ),
                                  const Text('Price'),
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem<String>(
                              height: h / 25,
                              value: 'Shop',
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    size: 4,
                                  ),
                                  SizedBox(
                                    width: w / 80,
                                  ),
                                  const Text(
                                    'Shop',
                                  ),
                                ],
                              ),
                            ),
                          ];
                        },
                      ),
                    ),
                    Container(
                      width: w / 10,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      padding: const EdgeInsets.only(left: 13),
                      child: Obx(
                        () => changeviews.changeview.value == 0
                            ? IconButton(
                                onPressed: () {
                                  changeviews.change(1);
                                },
                                icon: const Icon(
                                  Icons.grid_view_rounded,
                                  size: 25,
                                  color: white,
                                ))
                            : IconButton(
                                onPressed: () {
                                  changeviews.change(0);
                                },
                                icon: const Icon(
                                  Icons.format_list_bulleted,
                                  color: white,
                                )),
                      ),
                    ),
                    qq == false
                        ? Container(
                            width: w / 10,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            padding: const EdgeInsets.only(left: 18),
                            child: PopupMenuButton(
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              initialValue: selectedBagItem,
                              child: const Icon(
                                Icons.more_vert,
                                color: white,
                              ),
                              itemBuilder: (_) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    onTap: () {
                                      setState(() {
                                        qq = true;
                                      });
                                    },
                                    height: h / 25,
                                    value: 'Items to delete',
                                    child: Text('Items to delete',
                                        style: A_style_medium),
                                  ),
                                  const PopupMenuDivider(),
                                  PopupMenuItem<String>(
                                    onTap: () {
                                      setState(() {
                                        qq = true;
                                      });
                                    },
                                    height: h / 25,
                                    value: 'Send to bag',
                                    child: Text('Send to bag',
                                        style: A_style_medium),
                                  ),
                                ];
                              },
                            ),
                          )
                        : Container(
                            width: w / 10,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            padding: const EdgeInsets.only(left: 18),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    qq = false;
                                  });
                                },
                                child: const Icon(Icons.close)),
                          ),
                  ],
                ),

                // Container(
                //   width: 29,
                //   child: ,
                // ),
                // Container(
                //   width: 29,
                //   child: ,
                // ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h / 90,
            ),
            qq == true
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,

                    //  physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Checkbox(
                            focusColor: logocolo,
                            activeColor: logocolo,
                            checkColor: Colors.white,
                            value: isChecked,
                            onChanged: (newValue) {
                              setState(() {
                                isChecked = newValue!;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              width: w / 1.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 3)
                                  ]),
                              child: Container(
                                height: h / 4.3,
                                padding:
                                    const EdgeInsets.only(left: 4, top: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: h / 7,
                                        width: w / 5,
                                        margin: const EdgeInsets.all(2),
                                        child: Image.asset(
                                          "assets/images/makeup.png",
                                          fit: BoxFit.fill,
                                        )),
                                    SizedBox(
                                      width: w / 100,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: h / 100,
                                        ),
                                        SizedBox(
                                          width: w / 3,
                                          child: const Text(
                                            "MAKEUP COMBO MAKEUP COMBO MAKEUP COMBO",
                                            maxLines: 1,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                fontFamily: "Amazon_med"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: h / 100,
                                        ),
                                        const Text(
                                          "Brand: Estha dot",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontFamily: "Amazon_med"),
                                        ),
                                        SizedBox(
                                          height: h / 100,
                                        ),
                                        const Row(
                                          children: [
                                            Text(
                                              "\$2,480.00  ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: "Amazon_med"),
                                            ),
                                            Text(
                                              "\$2,500.00",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor: Colors.grey,
                                                  fontFamily: "Amazon_med"),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: h / 100,
                                        ),
                                        const Text(
                                          "Size : M",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              //decoration: TextDecoration.lineThrough,
                                              fontFamily: "Ember_Light"),
                                        ),
                                        SizedBox(
                                          height: h / 35,
                                        ),
                                        SizedBox(
                                          width: w / 1.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    border: Border.all(
                                                        color: logocolo)),
                                                child: Text(
                                                  "Move to bag",
                                                  style: TextStyle(
                                                      color: logocolo,
                                                      fontSize: h / 70,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Text(
                                                  "See similiar",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: h / 70,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Container(
                                                child: PopupMenuButton(
                                                  padding: EdgeInsets.only(
                                                      top: h / 60, left: 5),
                                                  color: Colors.white,
                                                  surfaceTintColor:
                                                      Colors.white,
                                                  initialValue: selectedItem,
                                                  icon: const Icon(
                                                    Icons.more_horiz,
                                                    color: Colors.black,
                                                  ),
                                                  itemBuilder: (_) {
                                                    return <PopupMenuEntry<
                                                        String>>[
                                                      PopupMenuItem<String>(
                                                        height: h / 25,
                                                        value: 'Chat',
                                                        child: const Row(
                                                          children: [
                                                            Text("Chat"),
                                                            Spacer(),
                                                            Icon(
                                                              Icons
                                                                  .message_outlined,
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
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
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const PopupMenuDivider(),
                                                      PopupMenuItem<String>(
                                                        height: h / 25,
                                                        value: 'innt vibe',
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                "innt vibe"),
                                                            const Spacer(),
                                                            Image.asset(
                                                              "assets/images/share.png",
                                                              width: w / 27,
                                                              height: h / 27,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const PopupMenuDivider(),
                                                      PopupMenuItem<String>(
                                                        height: h / 25,
                                                        value: 'Delete',
                                                        child: const Row(
                                                          children: [
                                                            Text(
                                                                "Delete"),
                                                            Spacer(),
                                                            Icon(
                                                              Icons.delete,
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ];
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    })
                : const SizedBox(),
            Obx(
              () => changeviews.changeview.value == 0
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Get.to(() => Product_deatils());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 3)
                                  ]),
                              child: Dismissible(
                                key: Key(index.toString()),
                                secondaryBackground: Container(
                                  color: Colors.red.shade700,
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                                background: Container(
                                  color: Colors.green,
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                                child: Container(
                                  height: h / 4.3,
                                  padding: const EdgeInsets.only(
                                      left: 4, top: 4, bottom: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: h / 5.3,
                                          width: w / 3,
                                          margin: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Image.asset(
                                            "assets/images/makeup.png",
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        width: w / 70,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: h / 100,
                                          ),
                                          SizedBox(
                                            width: w / 2,
                                            child: const Text(
                                              "MAKEUP COMBO MAKEUP COMBO MAKEUP COMBO",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  fontFamily: "Amazon_med"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h / 100,
                                          ),
                                          const Text(
                                            "Brand: Estha dot",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontFamily: "Amazon_med"),
                                          ),
                                          SizedBox(
                                            height: h / 100,
                                          ),
                                          const Row(
                                            children: [
                                              Text(
                                                "\$2,480.00  ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: "Amazon_med"),
                                              ),
                                              Text(
                                                "\$2,500.00",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        Colors.grey,
                                                    fontFamily: "Amazon_med"),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h / 100,
                                          ),
                                          const Text(
                                            "Size : M",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                //decoration: TextDecoration.lineThrough,
                                                fontFamily: "Ember_Light"),
                                          ),
                                          SizedBox(
                                            height: h / 40,
                                          ),
                                          SizedBox(
                                            width: w / 1.7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                      border: Border.all(
                                                          color: logocolo)),
                                                  child: Text(
                                                    "Move to bag",
                                                    style: TextStyle(
                                                        color: logocolo,
                                                        fontSize: h / 70,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                      border: Border.all(
                                                          color: Colors.grey)),
                                                  child: Text(
                                                    "See similiar",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: h / 70,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  child: PopupMenuButton(
                                                    padding: EdgeInsets.only(
                                                        top: h / 60, left: 5),
                                                    color: Colors.white,
                                                    surfaceTintColor:
                                                        Colors.white,
                                                    initialValue: selectedItem,
                                                    icon: const Icon(
                                                      Icons.more_horiz,
                                                      color: Colors.black,
                                                    ),
                                                    itemBuilder: (_) {
                                                      return <PopupMenuEntry<
                                                          String>>[
                                                        PopupMenuItem<String>(
                                                          height: h / 25,
                                                          value: 'Chat',
                                                          child: const Row(
                                                            children: [
                                                              Text(
                                                                  "Chat"),
                                                              Spacer(),
                                                              Icon(
                                                                Icons
                                                                    .message_outlined,
                                                                size: 20,
                                                                color: Colors
                                                                    .black,
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
                                                              const Text(
                                                                  "Share"),
                                                              const Spacer(),
                                                              Image.asset(
                                                                "assets/images/share.png",
                                                                width: w / 27,
                                                                height: h / 27,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const PopupMenuDivider(),
                                                        PopupMenuItem<String>(
                                                          height: h / 25,
                                                          value: 'innt vibe',
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                  "innt vibe"),
                                                              const Spacer(),
                                                              Image.asset(
                                                                "assets/images/share.png",
                                                                width: w / 27,
                                                                height: h / 27,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const PopupMenuDivider(),
                                                        PopupMenuItem<String>(
                                                          height: h / 25,
                                                          value: 'Delete',
                                                          child: const Row(
                                                            children: [
                                                              Text(
                                                                  "Delete"),
                                                              Spacer(),
                                                              Icon(
                                                                Icons.delete,
                                                                size: 20,
                                                                color: Colors
                                                                    .black,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ];
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 9,
                        mainAxisSpacing: 9,
                        childAspectRatio:
                            (MediaQuery.of(context).size.width / 1) /
                                (MediaQuery.of(context).size.height / 1.35),
                      ),
                      itemCount: jeansCategory.length,
                      itemBuilder: (BuildContext context, int index) {
                        double containerWidth =
                            MediaQuery.of(context).size.width /
                                2; // Adjust the width as needed

                        return InkWell(
                          onTap: () {
                          //  Get.to(() => const Product_deatils());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300, blurRadius: 3)
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.asset(
                                      jeansCategory[index]["image"].toString(),
                                      fit: BoxFit.cover,
                                      height: h / 5.3,
                                      width: w / 3,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: h / 80, right: w / 50, left: w / 50),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            jeansCategory[index]["price"],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: "Amazon_bold",
                                                overflow:
                                                    TextOverflow.ellipsis),
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
                                                overflow:
                                                    TextOverflow.ellipsis),
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
                                                fontFamily:
                                                    "Ember_Display_Medium"),
                                          ),
                                          Text(
                                            " M",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily:
                                                    "Ember_Display_Medium"),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: w / 1.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      color: logocolo)),
                                              child: Text(
                                                "Move to bag",
                                                style: TextStyle(
                                                    color: logocolo,
                                                    fontSize: h / 90,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Text(
                                                "See similiar",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: h / 90,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            SizedBox(
                                              width: w / 10,
                                              child: PopupMenuButton(
                                                padding: EdgeInsets.only(
                                                    top: h / 60, left: w / 25),
                                                color: Colors.white,
                                                surfaceTintColor: Colors.white,
                                                initialValue: selectedItem,
                                                icon: const Icon(
                                                  Icons.more_horiz,
                                                  color: Colors.black,
                                                ),
                                                itemBuilder: (_) {
                                                  return <PopupMenuEntry<
                                                      String>>[
                                                    PopupMenuItem<String>(
                                                      height: h / 25,
                                                      value: 'Chat',
                                                      child: const Row(
                                                        children: [
                                                          Text("Chat"),
                                                          Spacer(),
                                                          Icon(
                                                            Icons
                                                                .message_outlined,
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
                                                      value: 'innt vibe',
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                              "innt vibe"),
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
                                                      value: 'Delete',
                                                      child: const Row(
                                                        children: [
                                                          Text("Delete"),
                                                          Spacer(),
                                                          Icon(
                                                            Icons.delete,
                                                            size: 20,
                                                            color: Colors.black,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ];
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
