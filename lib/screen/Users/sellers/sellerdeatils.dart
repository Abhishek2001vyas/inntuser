import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/home.dart';
import 'package:inntuser/screen/Users/productdeatils.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Api/Addcart.dart';
import '../../../Api/Homepageproductlist.dart';
import '../../../Api/favoriteshop_api.dart';
import '../../../Api/innt_categoryList_api.dart';
import '../../../after/viewall/kidz_filter.dart';
import '../../../firebase/deeplinking.dart';
import '../../../main.dart';
import '../cart_screen.dart';
import '../chatting.dart';
import '../productreport.dart';

class SellerDetails extends StatefulWidget {
  final shopid;
  final shopanme;
  final sourceName;
  const SellerDetails(
      {super.key, this.shopid, this.shopanme, required this.sourceName});

  @override
  State<SellerDetails> createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  late var dropdownvalue = homeapi.categorie.isEmpty
      ? "All categories"
      : homeapi.categorie[0]["cate_value"].toString();
  late Future _feactdata;
  final favshop = Get.put(Inntfavoriteshop());
  String dropdownFilter = "Filter";
  String selectedBagItem = 'Delete item';
  final inntShop_detailslist1 = Get.put(Homepage_api());
  final Addcartinnt_api = Get.put(Addcart());
  final getInntCategory_api = Get.put(fetchInntCategoryList());

  @override
  void dispose() {
    // TODO: implement dispose
    homeapi.inntShop_detailsprofilter.clear();
    homeapi.sellerdeatils_prodfilterlist.clear();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    yyyy();
    super.initState();
  }

  yyyy() {
    // homeapi.inntShop_detailsprofilter.clear();
    // homeapi.sellerdeatils_prodfilterlist.clear();
  }
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          "${widget.shopanme}",
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder(
            future: inntShop_detailslist1.inntShop_details_List(widget.shopid),
            builder: (context, snapshot) {
              //inntShop_detailslist1.selectedwhishsize.clear();

              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: logocolo,
                    ))
                  : snapshot.hasError
                      ? Text("no error ${snapshot.error}")
                      : Obx(
                          () {
                            return inntShop_detailslist1
                                    .inntShop_detailsListlist.isEmpty
                                ? Text(" NO DATA ${snapshot.error}")
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: darkomdee.darkomde == true
                                            ? Colors.black
                                            : Colors.white,
                                        height: h / 4.5,
                                        width: w / 1,
                                        child: inntShop_detailslist1
                                                        .inntShop_detailsListlist
                                                        .elementAt(
                                                            0)["data"]["shop_data"]
                                                    ["upload_frontId"] !=
                                                null
                                            ? Image.network(
                                                "$image_url${inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["shop_data"]["upload_frontId"].toString()}",
                                                fit: BoxFit.fill)
                                            : const Text("No image"),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: darkomdee.darkomde == true
                                                ? Colors.black
                                                : Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade100,
                                                  blurRadius: 1)
                                            ]),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey.shade100,
                                                  radius: 22,
                                                  backgroundImage: NetworkImage(
                                                    "$image_url${inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["shop_data"]["upload_frontId"].toString()}",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w / 90,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: w / 2,
                                                      child: Text(
                                                        inntShop_detailslist1
                                                            .inntShop_detailsListlist
                                                            .elementAt(0)[
                                                                "data"]
                                                                ["shop_data"]
                                                                ["shop_name"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            //letterSpacing: 1.5,
                                                            //color: Colors.white,
                                                            color: darkomdee
                                                                        .darkomde ==
                                                                    true
                                                                ? Colors.white
                                                                : Colors.grey
                                                                    .shade700,
                                                            fontFamily:
                                                                "Amazon_med",
                                                            fontSize: 16),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h / 100,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        openMap(
                                                            context,
                                                            double.parse(inntShop_detailslist1
                                                                .inntShop_detailsListlist
                                                                .elementAt(0)[
                                                                    "data"]
                                                                    ["shop_data"]
                                                                    ["lat"]
                                                                .toString()),
                                                            double.parse(inntShop_detailslist1
                                                                .inntShop_detailsListlist
                                                                .elementAt(0)[
                                                                    "data"]
                                                                    ["shop_data"]
                                                                    ["lon"]
                                                                .toString()));
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            color: Colors
                                                                .grey.shade300,
                                                            size: 18,
                                                          ),
                                                          SizedBox(
                                                            width: w / 2,
                                                            child: Text(
                                                              inntShop_detailslist1
                                                                  .inntShop_detailsListlist
                                                                  .elementAt(0)[
                                                                      "data"][
                                                                      "shop_data"]
                                                                      [
                                                                      "shop_address"]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  //letterSpacing: 1.5,
                                                                  //color: Colors.white,
                                                                  color: darkomdee
                                                                              .darkomde ==
                                                                          true
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .grey
                                                                          .shade700,
                                                                  fontFamily:
                                                                      "Amazon_med",
                                                                  fontSize: 14),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                PopupMenuButton(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  color: Colors.white,
                                                  surfaceTintColor:
                                                      Colors.white,
                                                  icon: Icon(
                                                    Icons.more_horiz,
                                                    color: darkomdee.darkomde ==
                                                            true
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                  itemBuilder: (_) {
                                                    return <PopupMenuEntry<
                                                        String>>[
                                                      PopupMenuItem<String>(
                                                        onTap: () {
                                                          Get.to(UserChat(
                                                              status: 1,
                                                              shopname: inntShop_detailslist1
                                                                      .inntShop_detailsListlist
                                                                      .elementAt(
                                                                          0)["data"]["shop_data"]
                                                                  ["shop_name"],
                                                              venderid:
                                                                  widget.shopid,
                                                              venderimage: inntShop_detailslist1
                                                                      .inntShop_detailsListlist
                                                                      .elementAt(
                                                                          0)["data"]["shop_data"]
                                                                  [
                                                                  "upload_frontId"]));
                                                          //chat_api.chatsendlist();
                                                        },
                                                        height: h / 25,
                                                        value: 'Chat',
                                                        child: Row(
                                                          children: [
                                                            Text("Chat"),
                                                            Spacer(),
                                                            Icon(
                                                              Icons
                                                                  .message_outlined,
                                                              weight: w / 27,
                                                              color:
                                                                  Colors.black,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const PopupMenuDivider(),
                                                      PopupMenuItem<String>(
                                                        onTap: () {
                                                          deepp().generateLink(
                                                              "https://inntuser.page.link/SellerDetails?shopId=${widget.shopid}&shopanme=${widget.shopanme}");
                                                        },
                                                        height: h / 25,
                                                        value: 'Share',
                                                        child: Row(
                                                          children: [
                                                            const Text("Share"),
                                                            const Spacer(),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/share.png",
                                                                width: w / 26,
                                                                height: h / 26,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const PopupMenuDivider(),
                                                      PopupMenuItem<String>(
                                                        onTap: () async {
                                                          await favshop
                                                              .Innt_favoriteshop(
                                                            widget.shopid,
                                                          );
                                                        },
                                                        height: h / 25,
                                                        value:
                                                            'Add to favorites',
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                "Add to favorites"),
                                                            const Spacer(),
                                                            Icon(
                                                                Icons
                                                                    .star_border,
                                                                weight: w / 27,
                                                                color: Colors
                                                                    .black),
                                                          ],
                                                        ),
                                                      ),
                                                      const PopupMenuDivider(),
                                                      PopupMenuItem<String>(
                                                        onTap: () {
                                                          Get.to(Report(
                                                            shopid:
                                                                widget.shopid,
                                                            status: 1,
                                                          ));
                                                        },
                                                        height: h / 25,
                                                        value: 'Report',
                                                        child: Row(
                                                          children: [
                                                            Text("Report"),
                                                            Spacer(),
                                                            Icon(
                                                              Icons
                                                                  .report_problem_outlined,
                                                              weight: w / 27,
                                                              color:
                                                                  Colors.black,
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Rating",
                                                          style: TextStyle(
                                                              //letterSpacing: 1.5,
                                                              //color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: darkomdee
                                                                          .darkomde ==
                                                                      true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  "Amazon_med",
                                                              fontSize: 14),
                                                        ),
                                                        SizedBox(
                                                          height: h / 100,
                                                        ),
                                                        RatingBar.builder(
                                                          itemSize: 18,
                                                          initialRating: double.parse(
                                                              inntShop_detailslist1
                                                                  .inntShop_detailsListlist
                                                                  .elementAt(0)[
                                                                      "data"][
                                                                      "average_ratings"]
                                                                  .toString()),
                                                          minRating: 0,
                                                          unratedColor:
                                                              Colors.grey,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          ignoreGestures: true,
                                                          itemPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      2.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            Icons.star_rate,
                                                            color: Colors.yellow
                                                                .shade800,
                                                          ),
                                                          onRatingUpdate:
                                                              (double value) {},
                                                        ),
                                                        SizedBox(
                                                          height: h / 100,
                                                        ),
                                                        Text(
                                                          inntShop_detailslist1
                                                              .inntShop_detailsListlist
                                                              .elementAt(0)[
                                                                  "data"][
                                                                  "raters_count"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              //letterSpacing: 1.5,
                                                              //color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: darkomdee
                                                                          .darkomde ==
                                                                      true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  "Amazon_med",
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    const VerticalDivider(
                                                      thickness: 2,
                                                      indent: 6,
                                                      endIndent: 6,
                                                      color: Colors.grey,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Products",
                                                          style: TextStyle(
                                                              //letterSpacing: 1.5,
                                                              //color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: darkomdee
                                                                          .darkomde ==
                                                                      true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  "Amazon_med",
                                                              fontSize: 14),
                                                        ),
                                                        SizedBox(
                                                          height: h / 100,
                                                        ),
                                                        Image.asset(
                                                            "assets/images/products.png",
                                                            height: 20,
                                                            width: 20,
                                                            color: darkomdee
                                                                        .darkomde ==
                                                                    true
                                                                ? Colors.white
                                                                : Colors.black),
                                                        SizedBox(
                                                          height: h / 100,
                                                        ),
                                                        Text(
                                                          inntShop_detailslist1
                                                              .inntShop_detailsListlist
                                                              .elementAt(0)[
                                                                  "data"][
                                                                  "products_count"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              //letterSpacing: 1.5,
                                                              //color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: darkomdee
                                                                          .darkomde ==
                                                                      true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  "Amazon_med",
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    const VerticalDivider(
                                                      thickness: 2,
                                                      indent: 6,
                                                      endIndent: 6,
                                                      color: Colors.grey,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Sales",
                                                          style: TextStyle(
                                                              //letterSpacing: 1.5,
                                                              //color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: darkomdee
                                                                          .darkomde ==
                                                                      true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  "Amazon_med",
                                                              fontSize: 14),
                                                        ),
                                                        SizedBox(
                                                          height: h / 100,
                                                        ),
                                                        Image.asset(
                                                            "assets/images/sales.png",
                                                            height: 20,
                                                            width: 20,
                                                            color: darkomdee
                                                                        .darkomde ==
                                                                    true
                                                                ? Colors.white
                                                                : Colors.black),
                                                        SizedBox(
                                                          height: h / 100,
                                                        ),
                                                        Text(
                                                          inntShop_detailslist1
                                                              .inntShop_detailsListlist
                                                              .elementAt(0)[
                                                                  "data"][
                                                                  "sales_count"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              //letterSpacing: 1.5,
                                                              //color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: darkomdee
                                                                          .darkomde ==
                                                                      true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  "Amazon_med",
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    const VerticalDivider(
                                                      indent: 6,
                                                      endIndent: 6,
                                                      thickness: 2,
                                                      color: Colors.grey,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Page views",
                                                          style: TextStyle(
                                                              //letterSpacing: 1.5,
                                                              //color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: darkomdee
                                                                          .darkomde ==
                                                                      true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  "Amazon_med",
                                                              fontSize: 14),
                                                        ),
                                                        SizedBox(
                                                          height: h / 100,
                                                        ),
                                                        Image.asset(
                                                            "assets/images/eyes.png",
                                                            height: 20,
                                                            width: 20,
                                                            color: darkomdee
                                                                        .darkomde ==
                                                                    true
                                                                ? Colors.white
                                                                : Colors.black),
                                                        SizedBox(
                                                          height: h / 100,
                                                        ),
                                                        Text(
                                                          inntShop_detailslist1
                                                              .inntShop_detailsListlist
                                                              .elementAt(0)[
                                                                  "data"]
                                                                  ["view_count"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              //letterSpacing: 1.5,
                                                              //color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: darkomdee
                                                                          .darkomde ==
                                                                      true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  "Amazon_med",
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    const VerticalDivider(
                                                      indent: 6,
                                                      endIndent: 6,
                                                      thickness: 2,
                                                      color: Colors.grey,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Liked item",
                                                          style: TextStyle(
                                                              //letterSpacing: 1.5,
                                                              //color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: darkomdee
                                                                          .darkomde ==
                                                                      true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  "Amazon_med",
                                                              fontSize: 14),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        SizedBox(
                                                          height: h / 100,
                                                        ),
                                                        Icon(Icons.favorite,
                                                            size: 20,
                                                            color: darkomdee
                                                                        .darkomde ==
                                                                    true
                                                                ? Colors.white
                                                                : Colors.black),
                                                        SizedBox(
                                                          height: h / 100,
                                                        ),
                                                        Text(
                                                          inntShop_detailslist1
                                                              .inntShop_detailsListlist
                                                              .elementAt(0)[
                                                                  "data"]
                                                                  ["like_count"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              //letterSpacing: 1.5,
                                                              //color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: darkomdee
                                                                          .darkomde ==
                                                                      true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  "Amazon_med",
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: w / 2.7,
                                            child: DropdownButton(
                                              iconEnabledColor:
                                                  darkomdee.darkomde == true
                                                      ? Colors.white
                                                      : Colors.black,
                                              dropdownColor:
                                                  darkomdee.darkomde == true
                                                      ? Colors.black
                                                      : Colors.white,
                                              style: TextStyle(
                                                  //letterSpacing: 1.5,
                                                  //color: Colors.white,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      darkomdee.darkomde == true
                                                          ? Colors.white
                                                          : Colors.black,
                                                  fontFamily: "Amazon_med",
                                                  fontSize: 16),
                                              underline: const SizedBox(),
                                              // Initial Value
                                              value: dropdownvalue,
                                              hint: const Text('select'),
                                              isExpanded: true,
                                              // Down Arrow Icon
                                              icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color:
                                                      darkomdee.darkomde == true
                                                          ? Colors.white
                                                          : Colors.black,
                                                  size: 20),

                                              // Array list of items
                                              items: homeapi.categorie
                                                  .map((items) {
                                                return DropdownMenuItem(
                                                  value: items["cate_value"],
                                                  child: Text(
                                                    items["cate_name"],
                                                    maxLines: 2,
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                print("doijfijdsgiuj$newValue");
                                                dropdownvalue =
                                                    newValue.toString();
                                                homeapi
                                                    .inntShop_detailsprofilter
                                                    .clear();
                                                homeapi
                                                    .sellerdeatils_prodfilterlist
                                                    .clear();
                                                dropdownvalue !=
                                                        "All categories"
                                                    ? homeapi
                                                        .inntShop_details_prodfilter(
                                                            widget.shopid,
                                                            dropdownvalue ??
                                                                "All categories")
                                                    : null;
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        kidzFilter(
                                                      shopid: widget.shopid,
                                                      higher: homeapi
                                                              .productWithHighestSalePrice1[
                                                          "sale_price"],
                                                      lower: homeapi
                                                              .productWithLowestSalePrice1[
                                                          "sale_price"],
                                                    ),
                                                  ));
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Filter',
                                                  style: TextStyle(
                                                      //letterSpacing: 1.5,
                                                      //color: Colors.white,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          darkomdee.darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontFamily: "Amazon_med",
                                                      fontSize: 16),
                                                ),
                                                Icon(Icons.keyboard_arrow_down,
                                                    color: darkomdee.darkomde ==
                                                            true
                                                        ? Colors.white
                                                        : Colors.black,
                                                    size: 20),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Obx(
                                          () =>
                                              homeapi.sellerdeatils_prodfilterlist
                                                          .isNotEmpty &&
                                                      homeapi.sellerdeatils_prodfilterlist[0]
                                                                  ["result"]
                                                              .toString() ==
                                                          "true".toString()
                                                  ? GridView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      physics:
                                                          const ScrollPhysics(),
                                                      shrinkWrap: true,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        crossAxisSpacing: 9,
                                                        mainAxisSpacing: 9,
                                                        childAspectRatio:
                                                            (MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    1) /
                                                                (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    1.3),
                                                      ),
                                                      itemCount: homeapi
                                                          .sellerdeatils_prodfilterlist[
                                                              0]["data"]
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              index) {
                                                        double containerWidth =
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2; // Adjust the width as needed

                                                        return InkWell(
                                                          onTap: () {
                                                            Get.to(() =>
                                                                Product_deatils(
                                                                  sourceName: widget
                                                                      .sourceName,
                                                                  shopid: inntShop_detailslist1
                                                                      .sellerdeatils_prodfilterlist
                                                                      .elementAt(0)[
                                                                          "data"]
                                                                          [
                                                                          index]
                                                                          [
                                                                          "venderId"]
                                                                      .toString(),
                                                                  subsubcateid: inntShop_detailslist1
                                                                      .sellerdeatils_prodfilterlist
                                                                      .elementAt(0)[
                                                                          "data"]
                                                                          [
                                                                          index]
                                                                          [
                                                                          "productId"]
                                                                      .toString(),
                                                                  conn: 0
                                                                      .toString(),
                                                                ));
                                                          },
                                                          child: Material(
                                                            elevation: 1,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      blurRadius:
                                                                          2)
                                                                ],
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius: const BorderRadius
                                                                        .only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(10)),
                                                                    child: Image
                                                                        .network(
                                                                      image_url +
                                                                          inntShop_detailslist1
                                                                              .sellerdeatils_prodfilterlist
                                                                              .elementAt(0)["data"][index]['image1']
                                                                              .toString(),
                                                                      fit: BoxFit
                                                                          .fitHeight,
                                                                      height:
                                                                          h / 5,
                                                                      width:
                                                                          w / 2,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: h /
                                                                            80,
                                                                        right: w /
                                                                            50,
                                                                        left: w /
                                                                            50),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              w / 2.09,
                                                                          child:
                                                                              Text(
                                                                            inntShop_detailslist1.sellerdeatils_prodfilterlist.elementAt(0)["data"][index]['product_name'].toString(),
                                                                            style: const TextStyle(
                                                                                overflow: TextOverflow.ellipsis,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 14,
                                                                                fontFamily: "Amazon_med"),
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              w,
                                                                          child:
                                                                              Text(
                                                                            inntShop_detailslist1.sellerdeatils_prodfilterlist.elementAt(0)["data"][index]['description'].toString(),
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: const TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 12,
                                                                                fontFamily: "Ember_Light",
                                                                                overflow: TextOverflow.ellipsis),
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "\$${inntShop_detailslist1.sellerdeatils_prodfilterlist.elementAt(0)["data"][index]['unit_price']}",
                                                                              style: const TextStyle(color: Colors.black, fontSize: 14, fontFamily: "Amazon_bold", overflow: TextOverflow.ellipsis),
                                                                              maxLines: 1,
                                                                            ),
                                                                            SizedBox(
                                                                              width: w / 60,
                                                                            ),
                                                                            Text(
                                                                              "\$${inntShop_detailslist1.sellerdeatils_prodfilterlist.elementAt(0)["data"][index]['sale_price']}",
                                                                              style: const TextStyle(color: Colors.grey, fontSize: 14, fontFamily: "Amazon_bold", decoration: TextDecoration.lineThrough, decorationColor: Colors.grey, overflow: TextOverflow.ellipsis),
                                                                              maxLines: 1,
                                                                            ),
                                                                            SizedBox(
                                                                              width: w / 60,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              w,
                                                                          child:
                                                                              Row(
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
                                                                                icon: const Icon(
                                                                                  Icons.more_horiz,
                                                                                  color: Colors.black,
                                                                                ),
                                                                                itemBuilder: (_) {
                                                                                  return <PopupMenuEntry<String>>[
                                                                                    PopupMenuItem<String>(
                                                                                      onTap: () async {
                                                                                        if (inntShop_detailslist1.sellerdeatils_prodfilterlist.elementAt(0)["data"][index]["product_variation"]!.isNotEmpty) {
                                                                                          cartlist.selectedarr.clear();
                                                                                          inntShop_detailslist1.sellerdeatils_prodfilterlist.elementAt(0)["data"][index]["product_variation"].map((attribute) {
                                                                                            Map<String, dynamic> newAttribute = Map.from(attribute);
                                                                                            cartlist.selectedarr.add({
                                                                                              "name": newAttribute["attribute_name"].toString(),
                                                                                              "value": newAttribute["attribute_values"][0].toString(),
                                                                                            });
                                                                                          }).toList();
                                                                                        }
                                                                                        print("jihihjihvsih ${cartlist.selectedarr}");

                                                                                        await Addcartinnt_api.Addcartinnt(inntShop_detailslist1.inntShop_detailsprofilter.elementAt(0)["data"][index]["productId"], widget.sourceName);
                                                                                      },
                                                                                      value: 'Move to bag',
                                                                                      child: const Text('Move to bag'),
                                                                                    ),
                                                                                    PopupMenuItem<String>(
                                                                                      onTap: () {
                                                                                        Get.to(() => Product_deatils(
                                                                                              sourceName: widget.sourceName,
                                                                                              shopid: inntShop_detailslist1.sellerdeatils_prodfilterlist.elementAt(0)["data"][index]["venderId"].toString(),
                                                                                              subsubcateid: inntShop_detailslist1.sellerdeatils_prodfilterlist.elementAt(0)["data"][index]["productId"].toString(),
                                                                                              conn: 1050.toString(),
                                                                                            ));
                                                                                      },
                                                                                      value: 'See reviews',
                                                                                      child: const Text('See reviews'),
                                                                                    ),
                                                                                    PopupMenuItem<String>(
                                                                                      onTap: () {
                                                                                        Get.to(Report(
                                                                                          productid: inntShop_detailslist1.sellerdeatils_prodfilterlist.elementAt(0)["data"][index]["productId"].toString(),
                                                                                          shopid: widget.shopid,
                                                                                          status: 0,
                                                                                        ));
                                                                                      },
                                                                                      value: 'Report',
                                                                                      child: const Text('Report'),
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
                                                  : homeapi.sellerdeatils_prodfilterlist
                                                              .isNotEmpty &&
                                                          homeapi.sellerdeatils_prodfilterlist[0]
                                                                      ["result"]
                                                                  .toString() !=
                                                              "true".toString()
                                                      ? const Text(
                                                          "No Products")
                                                      : homeapi.inntShop_detailsprofilter
                                                                  .isEmpty &&
                                                              dropdownvalue !=
                                                                  "All categories"
                                                          ? const Text(
                                                              "No Products")
                                                          : homeapi.inntShop_detailsprofilter
                                                                      .isNotEmpty &&
                                                                  dropdownvalue !=
                                                                      "All categories"
                                                              ? GridView.builder(
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
                                                                  itemCount: inntShop_detailslist1
                                                                      .inntShop_detailsprofilter[
                                                                          0][
                                                                          "data"]
                                                                      .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          index) {
                                                                    double containerWidth = MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2; // Adjust the width as needed

                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                            Product_deatils(
                                                                              sourceName: widget.sourceName,
                                                                              shopid: inntShop_detailslist1.inntShop_detailsprofilter.elementAt(0)["data"][index]["venderId"].toString(),
                                                                              subsubcateid: inntShop_detailslist1.inntShop_detailsprofilter.elementAt(0)["data"][index]["productId"].toString(),
                                                                              conn: 0.toString(),
                                                                            ));
                                                                      },
                                                                      child:
                                                                          Material(
                                                                        elevation:
                                                                            1,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Colors.white),
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            boxShadow: [
                                                                              BoxShadow(color: Colors.grey.shade300, blurRadius: 2)
                                                                            ],
                                                                            color: darkomdee.darkomde == true
                                                                                ? Colors.black
                                                                                : Colors.white,
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                height: h / 5,
                                                                                width: w / 2,
                                                                                child: ClipRRect(
                                                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                  child: Image.network(
                                                                                    image_url + inntShop_detailslist1.inntShop_detailsprofilter.elementAt(0)["data"][index]['image1'].toString(),
                                                                                    fit: BoxFit.fitHeight,
                                                                                    height: h / 5,
                                                                                    width: w / 2,
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
                                                                                      child: Text(
                                                                                        inntShop_detailslist1.inntShop_detailsprofilter.elementAt(0)["data"][index]['product_name'].toString(),
                                                                                        style: TextStyle(overflow: TextOverflow.ellipsis, color: darkomdee.darkomde == true ? Colors.white : Colors.black, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: "Amazon_med"),
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: w,
                                                                                      child: Text(
                                                                                        inntShop_detailslist1.inntShop_detailsprofilter.elementAt(0)["data"][index]['description'].toString(),
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.black, fontSize: 12, fontFamily: "Ember_Light", overflow: TextOverflow.ellipsis),
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          "\$${inntShop_detailslist1.inntShop_detailsprofilter.elementAt(0)["data"][index]['sale_price']}",
                                                                                          style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.black, fontSize: 14, fontFamily: "Amazon_bold", overflow: TextOverflow.ellipsis),
                                                                                          maxLines: 1,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: w / 60,
                                                                                        ),
                                                                                        Text(
                                                                                          "\$${inntShop_detailslist1.inntShop_detailsprofilter.elementAt(0)["data"][index]['unit_price']}",
                                                                                          style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.grey, fontSize: 14, fontFamily: "Amazon_bold", decoration: TextDecoration.lineThrough, decorationColor: Colors.grey, overflow: TextOverflow.ellipsis),
                                                                                          maxLines: 1,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: w / 60,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: w,
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.shopping_bag,
                                                                                            color: logocolo,
                                                                                            size: h / 35,
                                                                                          ),
                                                                                          PopupMenuButton(
                                                                                            color: Colors.white,
                                                                                            surfaceTintColor: Colors.white,
                                                                                            icon: const Icon(
                                                                                              Icons.more_horiz,
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                            itemBuilder: (_) {
                                                                                              return <PopupMenuEntry<String>>[
                                                                                                PopupMenuItem<String>(
                                                                                                  onTap: () async {
                                                                                                    if (inntShop_detailslist1.sellerdeatils_prodfilterlist.elementAt(0)["data"][index]["product_variation"]!.isNotEmpty) {
                                                                                                      cartlist.selectedarr.clear();
                                                                                                      inntShop_detailslist1.sellerdeatils_prodfilterlist.elementAt(0)["data"][index]["product_variation"].map((attribute) {
                                                                                                        Map<String, dynamic> newAttribute = Map.from(attribute);
                                                                                                        cartlist.selectedarr.add({
                                                                                                          "name": newAttribute["attribute_name"].toString(),
                                                                                                          "value": newAttribute["attribute_values"][0].toString(),
                                                                                                        });
                                                                                                      }).toList();
                                                                                                    }
                                                                                                    print("jihihjihvsih ${cartlist.selectedarr}");
                                                                                                    await Addcartinnt_api.Addcartinnt(inntShop_detailslist1.inntShop_detailsprofilter.elementAt(0)["data"][index]["productId"], widget.sourceName);
                                                                                                  },
                                                                                                  value: 'Move to bag',
                                                                                                  child: const Text('Move to bag'),
                                                                                                ),
                                                                                                PopupMenuItem<String>(
                                                                                                  onTap: () {
                                                                                                    Get.to(() => Product_deatils(
                                                                                                          sourceName: widget.sourceName,
                                                                                                          shopid: inntShop_detailslist1.inntShop_detailsprofilter.elementAt(0)["data"][index]["venderId"].toString(),
                                                                                                          subsubcateid: inntShop_detailslist1.inntShop_detailsprofilter.elementAt(0)["data"][index]["productId"].toString(),
                                                                                                          conn: 1050.toString(),
                                                                                                        ));
                                                                                                  },
                                                                                                  value: 'See reviews',
                                                                                                  child: const Text('See reviews'),
                                                                                                ),
                                                                                                PopupMenuItem<String>(
                                                                                                  onTap: () {
                                                                                                    Get.to(Report(
                                                                                                      productid: inntShop_detailslist1.inntShop_detailsprofilter.elementAt(0)["data"][index]["productId"].toString(),
                                                                                                      shopid: widget.shopid,
                                                                                                      status: 0,
                                                                                                    ));
                                                                                                  },
                                                                                                  value: 'Report',
                                                                                                  child: const Text('Report'),
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
                                                              : GridView.builder(
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
                                                                            1.2),
                                                                  ),
                                                                  itemCount: inntShop_detailslist1
                                                                      .inntShop_detailsListlist
                                                                      .elementAt(0)[
                                                                          "data"]
                                                                          [
                                                                          "productlist"]
                                                                      .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          index) {
                                                                    double containerWidth = MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2; // Adjust the width as needed

                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                            Product_deatils(
                                                                              sourceName: widget.sourceName,
                                                                              shopid: inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]["venderId"].toString(),
                                                                              subsubcateid: inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]["productId"].toString(),
                                                                              conn: 0.toString(),
                                                                            ));
                                                                      },
                                                                      child:
                                                                          Material(
                                                                        elevation:
                                                                            1,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Colors.white),
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            boxShadow: [
                                                                              BoxShadow(color: Colors.grey.shade300, blurRadius: 2)
                                                                            ],
                                                                            color: darkomdee.darkomde == true
                                                                                ? Colors.black
                                                                                : Colors.white,
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                  height: h / 5,
                                                                                  width: w / 2,
                                                                                  child: ClipRRect(
                                                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                    child: Image.network(
                                                                                      "$image_url${inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]['image1']}",
                                                                                      fit: BoxFit.fitHeight,
                                                                                      height: h / 5,
                                                                                      width: w / 2,
                                                                                    ),
                                                                                  )),
                                                                              Padding(
                                                                                padding: EdgeInsets.only(top: h / 80, right: w / 50, left: w / 50),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: w / 2.09,
                                                                                      child: Text(
                                                                                        inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]['product_name'].toString(),
                                                                                        style: TextStyle(overflow: TextOverflow.ellipsis, color: darkomdee.darkomde == true ? Colors.white : Colors.black, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: "Amazon_med"),
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: w,
                                                                                      child: Text(
                                                                                        inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]['description'].toString(),
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.black, fontSize: 12, fontFamily: "Ember_Light", overflow: TextOverflow.ellipsis),
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          "\$${inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]['sale_price']}",
                                                                                          style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.black, fontSize: 14, fontFamily: "Amazon_bold", overflow: TextOverflow.ellipsis),
                                                                                          maxLines: 1,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: w / 60,
                                                                                        ),
                                                                                        Text(
                                                                                          "\$${inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]['unit_price']}",
                                                                                          style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.grey, fontSize: 14, fontFamily: "Amazon_bold", decoration: TextDecoration.lineThrough, decorationColor: Colors.grey, overflow: TextOverflow.ellipsis),
                                                                                          maxLines: 1,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: w / 60,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: w,
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.shopping_bag,
                                                                                            color: logocolo,
                                                                                            size: h / 35,
                                                                                          ),
                                                                                          PopupMenuButton(
                                                                                            color: Colors.white,
                                                                                            surfaceTintColor: Colors.white,
                                                                                            icon: Icon(
                                                                                              Icons.more_horiz,
                                                                                              color: darkomdee.darkomde == true ? Colors.white : Colors.black,
                                                                                            ),
                                                                                            itemBuilder: (_) {
                                                                                              return <PopupMenuEntry<String>>[
                                                                                                PopupMenuItem<String>(
                                                                                                  onTap: () async {
                                                                                                    if (inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]["product_variation"]!.isNotEmpty) {
                                                                                                      cartlist.selectedarr.clear();
                                                                                                      inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]["product_variation"].map((attribute) {
                                                                                                        Map<String, dynamic> newAttribute = Map.from(attribute);
                                                                                                        cartlist.selectedarr.add({
                                                                                                          "name": newAttribute["attribute_name"].toString(),
                                                                                                          "value": newAttribute["attribute_values"][0].toString(),
                                                                                                        });
                                                                                                      }).toList();
                                                                                                    }
                                                                                                    print("jihihjihvsih ${cartlist.selectedarr}");
                                                                                                    await Addcartinnt_api.Addcartinnt(inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]["productId"], widget.sourceName);
                                                                                                  },
                                                                                                  value: 'Move to bag',
                                                                                                  child: const Text('Move to bag'),
                                                                                                ),
                                                                                                PopupMenuItem<String>(
                                                                                                  onTap: () {
                                                                                                    Get.to(() => Product_deatils(
                                                                                                          sourceName: widget.sourceName,
                                                                                                          shopid: inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]["venderId"].toString(),
                                                                                                          subsubcateid: inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]["productId"].toString(),
                                                                                                          conn: 1050.toString(),
                                                                                                        ));
                                                                                                  },
                                                                                                  value: 'See reviews',
                                                                                                  child: const Text('See reviews'),
                                                                                                ),
                                                                                                PopupMenuItem<String>(
                                                                                                  onTap: () {
                                                                                                    Get.to(Report(
                                                                                                      productid: inntShop_detailslist1.inntShop_detailsListlist.elementAt(0)["data"]["productlist"][index]["productId"].toString(),
                                                                                                      shopid: widget.shopid,
                                                                                                      status: 0,
                                                                                                    ));
                                                                                                  },
                                                                                                  value: 'Report',
                                                                                                  child: const Text('Report'),
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
                                                                ))
                                    ],
                                  );
                          },
                        );
            },
          )),
    );
  }

  static Future<void> openMap(
      BuildContext context, double lat, double lng) async {
    String url = '';
    String urlAppleMaps = '';
    if (Platform.isAndroid) {
      url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else {
      urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';
      url = 'comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else if (await canLaunchUrl(Uri.parse(urlAppleMaps))) {
        await launchUrl(Uri.parse(urlAppleMaps));
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
