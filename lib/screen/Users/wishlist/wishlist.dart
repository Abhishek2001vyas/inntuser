import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/Api/wishlist.dart';
import 'package:inntuser/screen/Users/wishlist/wishlist_controller.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../../Api/Addcart.dart';
import '../../../Api/meassage_api.dart';
import '../../../Controller/text2.dart';
import '../../../main.dart';
import '../cart_screen.dart';
import '../chatting.dart';
import '../productdeatils.dart';
import '../sellers/sellercontroller.dart';
import '../simillarproduct.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

var dismis = GlobalKey<FormState>();

class _WishlistState extends State<Wishlist> with TickerProviderStateMixin {
  bool isChecked = false;
  final changeviews = Get.put(Seller());

  String? selectedBagItem;
  bool qq = false;
  final wishh = Get.put(wishlist_api());
  final Addcartinnt_api = Get.put(Addcart());
  String? _selectedSize;
  final chat_api = Get.put(meassage_api());
  final changeviews1 = Get.put(wishlist());
  TextEditingController searchwishlist = TextEditingController();
  @override
  void dispose() {
    //wishh.wishprofsearch.clear();
    searchwishlist.text = "";
    wishh.wishproffilter.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 10,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            const Row(
              children: [
                Spacer(),
                Text("Saved"),
                Spacer(),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: h / 25,
                  width: w / 1.48,
                  child: TextFormField(
                    controller: searchwishlist,
                    onChanged: (value) {
                      wishh.wishproffilter.clear();
                      wishh.wishlistsearchww(value);
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Search in wishlist",
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
                        icon: const Icon(
                          Icons.filter_list_outlined,
                          color: white,
                        ),
                        itemBuilder: (_) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              onTap: () {
                                wishh.wishlistfilter(1);
                                setState(() {});
                              },
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
                              onTap: () {
                                wishh.wishlistfilter(2);
                                setState(() {});
                              },
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
                              onTap: () {
                                wishh.wishlistfilter(3);
                                setState(() {});
                              },
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
                              onTap: () {
                                wishh.wishlistfilter(4);
                                setState(() {});
                              },
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
                                  wishh.wishproffilter.clear();
                                  changeviews.change(1);
                                },
                                icon: const Icon(
                                  Icons.grid_view_rounded,
                                  size: 25,
                                  color: white,
                                ))
                            : IconButton(
                                onPressed: () {
                                  wishh.wishproffilter.clear();
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
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            padding: const EdgeInsets.only(left: 18),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    qq = true;
                                  });
                                },
                                child: const Icon(Icons.more_vert)),
                          )
                        : Container(
                            width: w / 10,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
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
            Obx(
              () => wishh.loading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : wishh.wishproffilter.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: wishh.wishproffilter[0]["data"].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => Product_deatils(
                                      sourceName: "0",
                                      shopid: wishh.wishproffilter
                                          .elementAt(index)["productId"]
                                              ["venderId"]
                                          .toString(),
                                      subsubcateid: wishh.wishproffilter
                                          .elementAt(index)["productId"]["_id"],
                                    ));
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
                                    onDismissed: (direction) async {
                                      print("hhhh${direction.name}");

                                      if (wishh.wishproffilter
                                          .elementAt(index)["productId"]
                                              ["product_variation"]!
                                          .isNotEmpty) {
                                        cartlist.selectedarr.clear();
                                        wishh.wishproffilter
                                            .elementAt(index)["productId"]
                                                ["product_variation"]
                                            .map((attribute) {
                                          Map<String, dynamic> newAttribute =
                                              Map.from(attribute);
                                          cartlist.selectedarr.add({
                                            "name":
                                                newAttribute["attribute_name"]
                                                    .toString(),
                                            "value":
                                                newAttribute["attribute_values"]
                                                        [0]
                                                    .toString(),
                                          });
                                        }).toList();
                                      }
                                      print(
                                          "jihihjihvsih ${cartlist.selectedarr}");

                                      direction.name.toString() == "endToStart"
                                          ? await wishh.wishlike(
                                              wishh.wishproffilter
                                                ..elementAt(index)["productId"]
                                                    ["_id"],
                                              wishh.wishproffilter.elementAt(
                                                      index)["productId"]
                                                  ["venderId"],
                                            )
                                          : Addcartinnt_api.Addcartinnt1(wishh
                                                  .wishproffilter
                                                  .elementAt(index)["productId"]
                                              ["_id"]);
                                      setState(() {});
                                    },
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
                                            Icons.shopping_bag_outlined,
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
                                              child: Image.network(
                                                "$image_url${wishh.wishproffilter[0]["data"].elementAt(index)["productId"]["image1"]}",
                                                fit: BoxFit.fitHeight,
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
                                                child: Text(
                                                  "${wishh.wishproffilter[0]["data"].elementAt(index)["productId"]["product_name"]}",
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      fontFamily: "Amazon_med"),
                                                ),
                                              ),
                                              SizedBox(
                                                height: h / 100,
                                              ),
                                              Text(
                                                "Brand: ${wishh.wishproffilter[0]["data"].elementAt(index)["productId"]["brand_name"]}",
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontFamily: "Amazon_med"),
                                              ),
                                              SizedBox(
                                                height: h / 100,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "\$${wishh.wishproffilter[0]["data"].elementAt(index)["productId"]["sale_price"]}  ",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            "Amazon_med"),
                                                  ),
                                                  Text(
                                                    "\$${wishh.wishproffilter[0]["data"].elementAt(index)["productId"]["unit_price"]}",
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        decorationColor:
                                                            Colors.grey,
                                                        fontFamily:
                                                            "Amazon_med"),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: h / 100,
                                              ),
                                              SizedBox(
                                                width: w / 1.7,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        if (wishh.wishproffilter
                                                            .elementAt(index)[
                                                                "productId"][
                                                                "product_variation"]!
                                                            .isNotEmpty) {
                                                          cartlist.selectedarr
                                                              .clear();
                                                          wishh.wishproffilter
                                                              .elementAt(index)[
                                                                  "productId"][
                                                                  "product_variation"]
                                                              .map((attribute) {
                                                            Map<String, dynamic>
                                                                newAttribute =
                                                                Map.from(
                                                                    attribute);
                                                            cartlist.selectedarr
                                                                .add({
                                                              "name": newAttribute[
                                                                      "attribute_name"]
                                                                  .toString(),
                                                              "value": newAttribute[
                                                                      "attribute_values"][0]
                                                                  .toString(),
                                                            });
                                                          }).toList();
                                                        }
                                                        print(
                                                            "jihihjihvsih ${cartlist.selectedarr}");
                                                        await Addcartinnt_api.Addcartinnt(
                                                            wishh.wishproffilter[0]
                                                                        ["data"]
                                                                    .elementAt(
                                                                        index)[
                                                                "productId"]["_id"],
                                                            "0");
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            border: Border.all(
                                                                color:
                                                                    logocolo)),
                                                        child: Text(
                                                          "Move to bag",
                                                          style: TextStyle(
                                                              color: logocolo,
                                                              fontSize: h / 70,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(Simillarproducts(
                                                          subsubcatid: wishh
                                                                  .wishproffilter[
                                                                      0]["data"]
                                                                  .elementAt(
                                                                      index)["productId"]
                                                              [
                                                              "sub_subcategoryId"],
                                                        ));
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey)),
                                                        child: Text(
                                                          "See similiar",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: h / 70,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: PopupMenuButton(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: h / 60,
                                                                left: 5),
                                                        color: Colors.white,
                                                        surfaceTintColor:
                                                            Colors.white,
                                                        icon: const Icon(
                                                          Icons.more_horiz,
                                                          color: Colors.black,
                                                        ),
                                                        itemBuilder: (_) {
                                                          return <PopupMenuEntry<
                                                              String>>[
                                                            PopupMenuItem<
                                                                String>(
                                                              onTap: () {
                                                                Get.to(UserChat(
                                                                  status: 1,
                                                                  shopname: wishh
                                                                      .wishproffilter
                                                                      .elementAt(
                                                                          index)["shopInfo"]["shopname"],
                                                                  venderid: wishh
                                                                      .wishproffilter
                                                                      .elementAt(
                                                                          index)["shopInfo"]["venderId"],
                                                                  venderimage: wishh
                                                                      .wishproffilter
                                                                      .elementAt(
                                                                          index)["shopInfo"]["image"],
                                                                ));
                                                                //chat_api.chatsendlist();
                                                              },
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
                                                                    color: Colors
                                                                        .black,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            const PopupMenuDivider(),
                                                            PopupMenuItem<
                                                                String>(
                                                              height: h / 25,
                                                              value: 'Share',
                                                              child: Row(
                                                                children: [
                                                                  const Text(
                                                                      "Share"),
                                                                  const Spacer(),
                                                                  Image.asset(
                                                                    "assets/images/share.png",
                                                                    width:
                                                                        w / 27,
                                                                    height:
                                                                        h / 27,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const PopupMenuDivider(),
                                                            PopupMenuItem<
                                                                String>(
                                                              height: h / 25,
                                                              value: 'Delete',
                                                              child: const Row(
                                                                children: [
                                                                  Text(
                                                                      "Delete"),
                                                                  Spacer(),
                                                                  Icon(
                                                                    Icons
                                                                        .delete,
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
                      : wishh.wishprofsearch.isNotEmpty &&
                              wishh.wishprofsearch[0]["data"].isEmpty &&
                              searchwishlist.text.isNotEmpty
                          ? const Center(child: Text("No product"))
                          : wishh.wishprofsearch.isNotEmpty &&
                                  searchwishlist.text.isNotEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      wishh.wishprofsearch[0]["data"].length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(() => Product_deatils(
                                              sourceName: "0",
                                              shopid: wishh.wishprofsearch
                                                  .elementAt(index)["productId"]
                                                      ["venderId"]
                                                  .toString(),
                                              subsubcateid: wishh.wishprofsearch
                                                      .elementAt(
                                                          index)["productId"]
                                                  ["_id"],
                                            ));
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    blurRadius: 3)
                                              ]),
                                          child: Dismissible(
                                            onDismissed: (direction) async {
                                              print("hhhh${direction.name}");

                                              if (wishh.wishlistlist
                                                  .elementAt(index)["productId"]
                                                      ["product_variation"]!
                                                  .isNotEmpty) {
                                                cartlist.selectedarr.clear();
                                                wishh.wishlistlist
                                                    .elementAt(index)[
                                                        "productId"]
                                                        ["product_variation"]
                                                    .map((attribute) {
                                                  Map<String, dynamic>
                                                      newAttribute =
                                                      Map.from(attribute);
                                                  cartlist.selectedarr.add({
                                                    "name": newAttribute[
                                                            "attribute_name"]
                                                        .toString(),
                                                    "value": newAttribute[
                                                            "attribute_values"][0]
                                                        .toString(),
                                                  });
                                                }).toList();
                                              }
                                              print(
                                                  "jihihjihvsih ${cartlist.selectedarr}");

                                              direction.name.toString() ==
                                                      "endToStart"
                                                  ? await wishh.wishlike(
                                                      wishh.wishprofsearch
                                                        ..elementAt(index)[
                                                            "productId"]["_id"],
                                                      wishh.wishprofsearch
                                                                  .elementAt(
                                                                      index)[
                                                              "productId"]
                                                          ["venderId"],
                                                    )
                                                  : Addcartinnt_api
                                                      .Addcartinnt1(wishh
                                                              .wishprofsearch
                                                              .elementAt(index)[
                                                          "productId"]["_id"]);
                                              setState(() {});
                                            },
                                            key: Key(index.toString()),
                                            secondaryBackground: Container(
                                              color: Colors.red.shade700,
                                              child: const Align(
                                                alignment:
                                                    Alignment.centerRight,
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
                                                    Icons.shopping_bag_outlined,
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      height: h / 5.3,
                                                      width: w / 3,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              4),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Image.network(
                                                        "$image_url${wishh.wishprofsearch[0]["data"].elementAt(index)["productId"]["image1"]}",
                                                        fit: BoxFit.fitHeight,
                                                      )),
                                                  SizedBox(
                                                    width: w / 70,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: h / 100,
                                                      ),
                                                      SizedBox(
                                                        width: w / 2,
                                                        child: Text(
                                                          "${wishh.wishprofsearch[0]["data"].elementAt(index)["productId"]["product_name"]}",
                                                          maxLines: 1,
                                                          style: const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  "Amazon_med"),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: h / 100,
                                                      ),
                                                      Text(
                                                        "Brand: ${wishh.wishprofsearch[0]["data"].elementAt(index)["productId"]["brand_name"]}",
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                "Amazon_med"),
                                                      ),
                                                      SizedBox(
                                                        height: h / 100,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "\$${wishh.wishprofsearch[0]["data"].elementAt(index)["productId"]["sale_price"]}  ",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Amazon_med"),
                                                          ),
                                                          Text(
                                                            "\$${wishh.wishprofsearch[0]["data"].elementAt(index)["productId"]["unit_price"]}",
                                                            style: const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                decorationColor:
                                                                    Colors.grey,
                                                                fontFamily:
                                                                    "Amazon_med"),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: h / 100,
                                                      ),
                                                      SizedBox(
                                                        width: w / 1.7,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                if (wishh
                                                                    .wishlistlist
                                                                    .elementAt(index)[
                                                                        "productId"]
                                                                        [
                                                                        "product_variation"]!
                                                                    .isNotEmpty) {
                                                                  cartlist
                                                                      .selectedarr
                                                                      .clear();
                                                                  wishh
                                                                      .wishlistlist
                                                                      .elementAt(index)[
                                                                          "productId"]
                                                                          [
                                                                          "product_variation"]
                                                                      .map(
                                                                          (attribute) {
                                                                    Map<String,
                                                                            dynamic>
                                                                        newAttribute =
                                                                        Map.from(
                                                                            attribute);
                                                                    cartlist
                                                                        .selectedarr
                                                                        .add({
                                                                      "name": newAttribute[
                                                                              "attribute_name"]
                                                                          .toString(),
                                                                      "value": newAttribute["attribute_values"]
                                                                              [
                                                                              0]
                                                                          .toString(),
                                                                    });
                                                                  }).toList();
                                                                }
                                                                print(
                                                                    "jihihjihvsih ${cartlist.selectedarr}");
                                                                await Addcartinnt_api.Addcartinnt(
                                                                    wishh
                                                                        .wishprofsearch[
                                                                            0][
                                                                            "data"]
                                                                        .elementAt(
                                                                            index)["productId"]["_id"],
                                                                    "0");
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            3),
                                                                    border: Border.all(
                                                                        color:
                                                                            logocolo)),
                                                                child: Text(
                                                                  "Move to bag",
                                                                  style: TextStyle(
                                                                      color:
                                                                          logocolo,
                                                                      fontSize:
                                                                          h /
                                                                              70,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Get.to(
                                                                    Simillarproducts(
                                                                  subsubcatid: wishh
                                                                      .wishprofsearch[
                                                                          0][
                                                                          "data"]
                                                                      .elementAt(
                                                                          index)["productId"]["sub_subcategoryId"],
                                                                ));
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            3),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey)),
                                                                child: Text(
                                                                  "See similiar",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          h /
                                                                              70,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child:
                                                                  PopupMenuButton(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: h /
                                                                            60,
                                                                        left:
                                                                            5),
                                                                color: Colors
                                                                    .white,
                                                                surfaceTintColor:
                                                                    Colors
                                                                        .white,
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .more_horiz,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                itemBuilder:
                                                                    (_) {
                                                                  return <PopupMenuEntry<
                                                                      String>>[
                                                                    PopupMenuItem<
                                                                        String>(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(
                                                                            UserChat(
                                                                          status:
                                                                              1,
                                                                          shopname: wishh
                                                                              .wishprofsearch
                                                                              .elementAt(index)["shopInfo"]["shopname"],
                                                                          venderid: wishh
                                                                              .wishprofsearch
                                                                              .elementAt(index)["shopInfo"]["venderId"],
                                                                          venderimage: wishh
                                                                              .wishprofsearch
                                                                              .elementAt(index)["shopInfo"]["image"],
                                                                        ));
                                                                        //chat_api.chatsendlist();
                                                                      },
                                                                      height:
                                                                          h / 25,
                                                                      value:
                                                                          'Chat',
                                                                      child:
                                                                          const Row(
                                                                        children: [
                                                                          Text(
                                                                              "Chat"),
                                                                          Spacer(),
                                                                          Icon(
                                                                            Icons.message_outlined,
                                                                            size:
                                                                                20,
                                                                            color:
                                                                                Colors.black,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const PopupMenuDivider(),
                                                                    PopupMenuItem<
                                                                        String>(
                                                                      height:
                                                                          h / 25,
                                                                      value:
                                                                          'Share',
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Text(
                                                                              "Share"),
                                                                          const Spacer(),
                                                                          Image
                                                                              .asset(
                                                                            "assets/images/share.png",
                                                                            width:
                                                                                w / 27,
                                                                            height:
                                                                                h / 27,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const PopupMenuDivider(),
                                                                    PopupMenuItem<
                                                                        String>(
                                                                      height:
                                                                          h / 25,
                                                                      value:
                                                                          'Delete',
                                                                      child:
                                                                          const Row(
                                                                        children: [
                                                                          Text(
                                                                              "Delete"),
                                                                          Spacer(),
                                                                          Icon(
                                                                            Icons.delete,
                                                                            size:
                                                                                20,
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
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : FutureBuilder(
                                  future: wishh.wishlikelist(),
                                  builder: (context, snapshot) {
                                    Addcartinnt_api.selectedwhishsize.clear();
                                    return snapshot.connectionState ==
                                            ConnectionState.waiting
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                                color: logocolo),
                                          )
                                        : Obx(() => wishh.wishlistlist.isEmpty
                                            ? const Center(
                                                child: Text("No products"))
                                            : Column(
                                                children: [
                                                  qq == true
                                                      ? ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: wishh
                                                              .wishlistlist
                                                              .length,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          itemBuilder:
                                                              (context, index) {
                                                            //wishh.wishlistlist.elementAt(0).data!.elementAt(0).productId.tax.elementAt(0).

                                                            return Row(
                                                              children: [
                                                                Obx(() =>
                                                                    Checkbox(
                                                                      focusColor:
                                                                          logocolo,
                                                                      activeColor:
                                                                          logocolo,
                                                                      checkColor:
                                                                          Colors
                                                                              .white,
                                                                      value: changeviews1.mutipledeletelist.contains(wishh
                                                                          .wishlistlist
                                                                          .elementAt(index)[
                                                                              "productId"]
                                                                              [
                                                                              "_id"]
                                                                          .toString()),
                                                                      onChanged:
                                                                          (newValue) {
                                                                        if (changeviews1.mutipledeletelist.contains(wishh
                                                                            .wishlistlist
                                                                            .elementAt(index)["productId"]["_id"]
                                                                            .toString())) {
                                                                          changeviews1.mutipledeletelist.remove(wishh
                                                                              .wishlistlist
                                                                              .elementAt(index)["productId"]["_id"]
                                                                              .toString());
                                                                        } else {
                                                                          changeviews1.mutipledelete(
                                                                              wishh.wishlistlist.elementAt(index)["productId"]["_id"].toString(),
                                                                              index);
                                                                        }

                                                                        print(changeviews1
                                                                            .mutipledeletelist
                                                                            .toString());
                                                                      },
                                                                    )),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        w / 1.2,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius: BorderRadius.circular(8),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Colors.grey.shade300,
                                                                              blurRadius: 3)
                                                                        ]),
                                                                    child:
                                                                        Container(
                                                                      height: h /
                                                                          4.3,
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              4,
                                                                          top:
                                                                              4,
                                                                          bottom:
                                                                              4),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                              height: h / 7,
                                                                              width: w / 5,
                                                                              margin: const EdgeInsets.all(2),
                                                                              child: Image.network(
                                                                                "$image_url${wishh.wishlistlist.elementAt(index)["productId"]["image1"]}",
                                                                                fit: BoxFit.fill,
                                                                              )),
                                                                          SizedBox(
                                                                            width:
                                                                                w / 100,
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
                                                                                child: Text(
                                                                                  "${wishh.wishlistlist.elementAt(index)["productId"]["product_name"]}",
                                                                                  maxLines: 1,
                                                                                  style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: "Amazon_med"),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: h / 100,
                                                                              ),
                                                                              Text(
                                                                                "Brand: ${wishh.wishlistlist.elementAt(index)["productId"]["brand_name"]}",
                                                                                style: const TextStyle(color: Colors.grey, fontSize: 14, fontFamily: "Amazon_med"),
                                                                              ),
                                                                              SizedBox(
                                                                                height: h / 100,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "\$${wishh.wishlistlist.elementAt(index)["productId"]["sale_price"]}  ",
                                                                                    style: const TextStyle(color: Colors.black, fontSize: 16, fontFamily: "Amazon_med"),
                                                                                  ),
                                                                                  Text(
                                                                                    "\$${wishh.wishlistlist.elementAt(index)["productId"]["unit_price"]}",
                                                                                    style: const TextStyle(color: Colors.grey, fontSize: 16, decoration: TextDecoration.lineThrough, decorationColor: Colors.grey, fontFamily: "Amazon_med"),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: h / 100,
                                                                              ),
                                                                              SizedBox(
                                                                                width: w / 1.7,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        Get.to(Simillarproducts(
                                                                                          subsubcatid: wishh.wishlistlist.elementAt(index)["productId"]["sub_subcategoryId"],
                                                                                        ));
                                                                                      },
                                                                                      child: Container(
                                                                                        padding: const EdgeInsets.all(4),
                                                                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3), border: Border.all(color: Colors.grey)),
                                                                                        child: Text(
                                                                                          "See similiar",
                                                                                          style: TextStyle(color: Colors.grey, fontSize: h / 70, fontWeight: FontWeight.w500),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      child: PopupMenuButton(
                                                                                        padding: EdgeInsets.only(top: h / 60, left: 5),
                                                                                        color: Colors.white,
                                                                                        surfaceTintColor: Colors.white,
                                                                                        // initialValue: selectedItem,
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
                                                                                              value: 'innt vibe',
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  const Text("innt vibe"),
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
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          })
                                                      : Obx(
                                                          () => changeviews
                                                                      .changeview
                                                                      .value ==
                                                                  0
                                                              ? ListView
                                                                  .builder(
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount: wishh
                                                                      .wishlistlist
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                            Product_deatils(
                                                                              sourceName: "0",
                                                                              shopid: wishh.wishlistlist.elementAt(index)["productId"]["venderId"].toString(),
                                                                              subsubcateid: wishh.wishlistlist.elementAt(index)["productId"]["_id"],
                                                                            ));
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                10.0),
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              boxShadow: [
                                                                                BoxShadow(color: Colors.grey.shade300, blurRadius: 3)
                                                                              ]),
                                                                          child:
                                                                              Dismissible(
                                                                            onDismissed:
                                                                                (direction) async {
                                                                              print("hhhh${direction.name}");
                                                                              print("jihihjihvsih");
                                                                              if (wishh.wishlistlist.elementAt(index)["productId"]["product_variation"]!.isNotEmpty) {
                                                                                cartlist.selectedarr.clear();
                                                                                wishh.wishlistlist.elementAt(index)["productId"]["product_variation"].map((attribute) {
                                                                                  Map<String, dynamic> newAttribute = Map.from(attribute);
                                                                                  cartlist.selectedarr.add({
                                                                                    "name": newAttribute["attribute_name"].toString(),
                                                                                    "value": newAttribute["attribute_values"][0].toString(),
                                                                                  });
                                                                                }).toList();
                                                                              }
                                                                              print("jihihjihvsih ${cartlist.selectedarr}");

                                                                              direction.name.toString() == "endToStart"
                                                                                  ? await wishh.wishlike(
                                                                                      wishh.wishlistlist.elementAt(index)["productId"]["_id"],
                                                                                      wishh.wishlistlist.elementAt(index)["productId"]["venderId"],
                                                                                    )
                                                                                  : Addcartinnt_api.Addcartinnt1(wishh.wishlistlist.elementAt(index)["productId"]["_id"]);
                                                                              setState(() {});
                                                                            },
                                                                            key:
                                                                                Key(index.toString()),
                                                                            secondaryBackground:
                                                                                Container(
                                                                              color: Colors.red.shade700,
                                                                              child: const Align(
                                                                                alignment: Alignment.centerRight,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                                                  child: Icon(
                                                                                    Icons.delete,
                                                                                    color: Colors.white,
                                                                                    size: 40,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            background:
                                                                                Container(
                                                                              color: Colors.green,
                                                                              child: const Align(
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                                                  child: Icon(
                                                                                    Icons.shopping_bag_outlined,
                                                                                    color: Colors.white,
                                                                                    size: 40,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              height: h / 4.3,
                                                                              padding: const EdgeInsets.only(left: 4, top: 4, bottom: 4),
                                                                              decoration: BoxDecoration(
                                                                                color: darkomdee.darkomde == true ? Colors.black : Colors.white,
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                      height: h / 5.3,
                                                                                      width: w / 3,
                                                                                      margin: const EdgeInsets.all(4),
                                                                                      decoration: BoxDecoration(
                                                                                        color: darkomdee.darkomde == true ? Colors.black : Colors.white,
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        "$image_url${wishh.wishlistlist.elementAt(index)["productId"]["image1"]}",
                                                                                        fit: BoxFit.fitHeight,
                                                                                      )),
                                                                                  SizedBox(
                                                                                    width: w / 70,
                                                                                  ),
                                                                                  Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        height: h / 100,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: w / 2,
                                                                                        child: Text(
                                                                                          "${wishh.wishlistlist.elementAt(index)["productId"]["product_name"]}",
                                                                                          maxLines: 1,
                                                                                          style: TextStyle(overflow: TextOverflow.ellipsis, color: darkomdee.darkomde == true ? Colors.white : Colors.black, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: "Amazon_med"),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: h / 100,
                                                                                      ),
                                                                                      Text(
                                                                                        "Brand: ${wishh.wishlistlist.elementAt(index)["productId"]["brand_name"]}",
                                                                                        style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.grey, fontSize: 14, fontFamily: "Amazon_med"),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: h / 100,
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            "\$${wishh.wishlistlist.elementAt(index)["productId"]["sale_price"]}  ",
                                                                                            style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.black, fontSize: 16, fontFamily: "Amazon_med"),
                                                                                          ),
                                                                                          Text(
                                                                                            "\$${wishh.wishlistlist.elementAt(index)["productId"]["unit_price"]}",
                                                                                            style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.grey, fontSize: 16, decoration: TextDecoration.lineThrough, decorationColor: Colors.grey, fontFamily: "Amazon_med"),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: h / 100,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: w / 1.7,
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            GestureDetector(
                                                                                              onTap: () async {
                                                                                                if (wishh.wishlistlist.elementAt(index)["productId"]["product_variation"]!.isNotEmpty) {
                                                                                                  cartlist.selectedarr.clear();
                                                                                                  wishh.wishlistlist.elementAt(index)["productId"]["product_variation"].map((attribute) {
                                                                                                    Map<String, dynamic> newAttribute = Map.from(attribute);
                                                                                                    cartlist.selectedarr.add({
                                                                                                      "name": newAttribute["attribute_name"].toString(),
                                                                                                      "value": newAttribute["attribute_values"][0].toString(),
                                                                                                    });
                                                                                                  }).toList();
                                                                                                }
                                                                                                print("jihihjihvsih ${cartlist.selectedarr}");
                                                                                                await Addcartinnt_api.Addcartinnt(wishh.wishlistlist.elementAt(index)["productId"]["_id"], "0");
                                                                                              },
                                                                                              child: Container(
                                                                                                padding: const EdgeInsets.all(4),
                                                                                                decoration: BoxDecoration(color: darkomdee.darkomde == true ? Colors.black : Colors.white, borderRadius: BorderRadius.circular(3), border: Border.all(color: darkomdee.darkomde == true ? Colors.white : logocolo)),
                                                                                                child: Text(
                                                                                                  "Move to bag",
                                                                                                  style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : logocolo, fontSize: h / 70, fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            GestureDetector(
                                                                                              onTap: () {
                                                                                                Get.to(Simillarproducts(
                                                                                                  subsubcatid: wishh.wishlistlist.elementAt(index)["productId"]["sub_subcategoryId"],
                                                                                                ));
                                                                                              },
                                                                                              child: Container(
                                                                                                padding: const EdgeInsets.all(4),
                                                                                                decoration: BoxDecoration(color: darkomdee.darkomde == true ? Colors.black : Colors.white, borderRadius: BorderRadius.circular(3), border: Border.all(color: Colors.grey)),
                                                                                                child: Text(
                                                                                                  "See similiar",
                                                                                                  style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.grey, fontSize: h / 70, fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                              child: PopupMenuButton(
                                                                                                padding: EdgeInsets.only(top: h / 60, left: 5),
                                                                                                color: darkomdee.darkomde == true ? Colors.black : Colors.white,
                                                                                                surfaceTintColor: Colors.white,
                                                                                                icon: Icon(
                                                                                                  Icons.more_horiz,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                                itemBuilder: (_) {
                                                                                                  return <PopupMenuEntry<String>>[
                                                                                                    PopupMenuItem<String>(
                                                                                                      onTap: () {
                                                                                                        Get.to(UserChat(
                                                                                                          status: 1,
                                                                                                          shopname: wishh.wishlistlist.elementAt(index)["shopInfo"]["shopname"],
                                                                                                          venderid: wishh.wishlistlist.elementAt(index)["shopInfo"]["venderId"],
                                                                                                          venderimage: wishh.wishlistlist.elementAt(index)["shopInfo"]["image"],
                                                                                                        ));
                                                                                                        //chat_api.chatsendlist();
                                                                                                      },
                                                                                                      height: h / 25,
                                                                                                      value: 'Chat',
                                                                                                      child: Row(
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            "Chat",
                                                                                                            style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.black),
                                                                                                          ),
                                                                                                          const Spacer(),
                                                                                                          Icon(
                                                                                                            Icons.message_outlined,
                                                                                                            size: 20,
                                                                                                            color: darkomdee.darkomde == true ? Colors.white : Colors.black,
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
                                                                                                          Text(
                                                                                                            "Share",
                                                                                                            style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.black),
                                                                                                          ),
                                                                                                          const Spacer(),
                                                                                                          Image.asset(
                                                                                                            "assets/images/share.png",
                                                                                                            width: w / 27,
                                                                                                            height: h / 27,
                                                                                                            color: darkomdee.darkomde == true ? Colors.white : Colors.black,
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                    const PopupMenuDivider(),
                                                                                                    PopupMenuItem<String>(
                                                                                                      onTap: () async {
                                                                                                        await wishh.wishlike(
                                                                                                          wishh.wishlistlist.elementAt(index)["productId"]["_id"],
                                                                                                          wishh.wishlistlist.elementAt(index)["productId"]["venderId"],
                                                                                                        );
                                                                                                        setState(() {});
                                                                                                      },
                                                                                                      height: h / 25,
                                                                                                      value: 'Delete',
                                                                                                      child: Row(
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            "Delete",
                                                                                                            style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.black),
                                                                                                          ),
                                                                                                          const Spacer(),
                                                                                                          Icon(
                                                                                                            Icons.delete,
                                                                                                            size: 20,
                                                                                                            color: darkomdee.darkomde == true ? Colors.white : Colors.black,
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
                                                              : GridView
                                                                  .builder(
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  physics:
                                                                      const ScrollPhysics(),
                                                                  shrinkWrap:
                                                                      true,
                                                                  gridDelegate:
                                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount:
                                                                        2,
                                                                    crossAxisSpacing:
                                                                        9,
                                                                    mainAxisSpacing:
                                                                        9,
                                                                    childAspectRatio: (MediaQuery.of(context).size.width /
                                                                            1) /
                                                                        (MediaQuery.of(context).size.height /
                                                                            1.3),
                                                                  ),
                                                                  itemCount: wishh
                                                                      .wishlistlist
                                                                      .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    double containerWidth = MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2; // Adjust the width as needed

                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                            Product_deatils(
                                                                              sourceName: "0",
                                                                              shopid: wishh.wishlistlist.elementAt(index)["productId"]["venderId"].toString(),
                                                                              subsubcateid: wishh.wishlistlist.elementAt(index)["productId"]["_id"],
                                                                            ));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                color: Colors.grey.shade300,
                                                                                blurRadius: 3)
                                                                          ],
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Center(
                                                                              child: ClipRRect(
                                                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                child: Image.network(
                                                                                  "$image_url${wishh.wishlistlist.elementAt(index)["productId"]["image1"]}",
                                                                                  fit: BoxFit.fitHeight,
                                                                                  height: h / 5.3,
                                                                                  width: w / 3,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: h / 80, right: w / 50, left: w / 50),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: w / 2.09,
                                                                                    height: h / 20,
                                                                                    child: Text(
                                                                                      wishh.wishlistlist.elementAt(index)["productId"]["product_name"].toString(),
                                                                                      style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: "Amazon_med"),
                                                                                      maxLines: 2,
                                                                                    ),
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        "\$${wishh.wishlistlist.elementAt(index)["productId"]["sale_price"]}",
                                                                                        style: const TextStyle(color: Colors.black, fontSize: 14, fontFamily: "Amazon_bold", overflow: TextOverflow.ellipsis),
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: w / 60,
                                                                                      ),
                                                                                      Text(
                                                                                        "\$${wishh.wishlistlist.elementAt(index)["productId"]["unit_price"]}",
                                                                                        style: const TextStyle(color: Colors.grey, fontSize: 14, fontFamily: "Amazon_bold", decoration: TextDecoration.lineThrough, decorationColor: Colors.grey, overflow: TextOverflow.ellipsis),
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: w / 60,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: w / 1.8,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        GestureDetector(
                                                                                          onTap: () async {
                                                                                            if (wishh.wishlistlist.elementAt(index)["productId"]["product_variation"]!.isNotEmpty) {
                                                                                              cartlist.selectedarr.clear();
                                                                                              wishh.wishlistlist.elementAt(index)["productId"]["product_variation"].map((attribute) {
                                                                                                Map<String, dynamic> newAttribute = Map.from(attribute);
                                                                                                cartlist.selectedarr.add({
                                                                                                  "name": newAttribute["attribute_name"].toString(),
                                                                                                  "value": newAttribute["attribute_values"][0].toString(),
                                                                                                });
                                                                                              }).toList();
                                                                                            }
                                                                                            print("jihihjihvsih ${cartlist.selectedarr}");

                                                                                            await Addcartinnt_api.Addcartinnt(wishh.wishlistlist.elementAt(0).data!.elementAt(index)["productId"]["_id"], "0");
                                                                                          },
                                                                                          child: Container(
                                                                                            padding: const EdgeInsets.all(4),
                                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3), border: Border.all(color: logocolo)),
                                                                                            child: Text(
                                                                                              "Move to bag",
                                                                                              style: TextStyle(color: logocolo, fontSize: h / 90, fontWeight: FontWeight.w500),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          width: 2,
                                                                                        ),
                                                                                        GestureDetector(
                                                                                          onTap: () {
                                                                                            Get.to(Simillarproducts(
                                                                                              subsubcatid: wishh.wishlistlist.elementAt(index)["productId"]["sub_subcategoryId"],
                                                                                            ));
                                                                                          },
                                                                                          child: Container(
                                                                                            padding: const EdgeInsets.all(4),
                                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3), border: Border.all(color: Colors.grey)),
                                                                                            child: Text(
                                                                                              "See similiar",
                                                                                              style: TextStyle(color: Colors.grey, fontSize: h / 90, fontWeight: FontWeight.w500),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: w / 10,
                                                                                          child: PopupMenuButton(
                                                                                            padding: EdgeInsets.only(top: h / 60, left: w / 25),
                                                                                            color: Colors.white,
                                                                                            surfaceTintColor: Colors.white,
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
                                                        )
                                                ],
                                              ));
                                  },
                                ),
            )
          ],
        ),
      ),
      bottomSheet: qq == true
          ? Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Addcartinnt_api.wishaddcartselcted();
                      changeviews1.mutipledeletelist.clear();
                      setState(() {
                        qq = false;
                      });

                      //  _showDeletePopup(context);
                    },
                    child: Container(
                      width: w / 3,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: logocolo,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            "Add to bag",
                            style: A_style_medium_white,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await wishh.wishdeleteselcted(
                        changeviews1.mutipledeletelist.join(",").toString(),
                      );
                      // _showMoveToBagPopup(context);
                      setState(() {
                        qq = false;
                      });
                      changeviews1.mutipledeletelist.clear();
                    },
                    child: Container(
                      width: w / 3,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.red.shade700,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                          Text(
                            "Delete",
                            style: A_style_medium_white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : null,
    );
  }
}
