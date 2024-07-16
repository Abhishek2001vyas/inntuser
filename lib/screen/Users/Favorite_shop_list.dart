import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/sellers/sellercontroller.dart';
import 'package:inntuser/screen/Users/sellers/sellerdeatils.dart';
import 'package:inntuser/screen/Users/shopreport.dart';

import '../../../Api/favoriteshop_api.dart';
import '../../../Controller/text2.dart';
import '../../../ulits/constant.dart';
import '../../firebase/deeplinking.dart';
import '../../main.dart';
import '../favshoplist_filter.dart';
import 'chatting.dart';

class Favshop extends StatefulWidget {
  const Favshop({super.key});

  @override
  State<Favshop> createState() => _FavshopState();
}

class _FavshopState extends State<Favshop> {
  String selectedItem = 'Share';
  String selectedSellerItem = 'Share';
  TextEditingController search = TextEditingController();
  final changeviews = Get.put(Seller());

  // final shoplist=Get.put(Inntfavoriteshop());
  final favshop = Get.put(Inntfavoriteshop());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.favoriteshops),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.white,
                    height: h / 20,
                    width: w / 1.4,
                    child: TextFormField(
                      controller: search,
                      onChanged: (value) {
                        favshop.searchfavshop(value);
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          hintText: "Search",
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.black),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(7))),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(favSellerfilter(
                              lower: favshop.shopdistancemin["distances"],
                              higher: favshop.shopdistancemax["distances"],
                            ));
                          },
                          child: const Icon(
                            Icons.filter_list,
                            color: Colors.black,
                          ),
                        ),
                        Obx(
                          () => favshop.changeviews.value == 0
                              ? IconButton(
                                  onPressed: () {
                                    favshop.changes(1);
                                  },
                                  icon: const Icon(
                                    Icons.grid_view_rounded,
                                    color: Colors.black,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    favshop.changes(0);
                                  },
                                  icon: const Icon(
                                    Icons.format_list_bulleted,
                                    color: Colors.black,
                                  )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(() => favshop.favsellerfilterlist.isNotEmpty &&
                    favshop.favsellerfilterlist[0]["result"].toString() ==
                        "true".toString()
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favshop.favsellerfilterlist
                        .elementAt(0)["data"]!
                        .length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var dataa = favshop.favsellerfilterlist
                          .elementAt(0)["data"]!
                          .elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          print(" ${dataa.shopId.toString()}");
                          Get.to(SellerDetails(
                            sourceName: "0",
                            shopid: dataa["shopId"].toString(),
                            shopanme: dataa["shop_name"],
                          ));
                        },
                        child: Container(
                          width: w,
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300, blurRadius: 3)
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: h / 5,
                                width: w / 2.5,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: dataa["frontImage"] != null
                                        ? Image.network(
                                            "$image_url${dataa["frontImage"].toString()}",
                                            fit: BoxFit.fill,
                                            height: h / 5,
                                            width: w / 2.5)
                                        : SizedBox(
                                            height: h / 5,
                                            width: w / 2.5,
                                            child: const Text("No image"),
                                          )),
                              ),
                              SizedBox(
                                width: w / 90,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: w / 2.2,
                                    child: Text(
                                      "${dataa["shop_name"].toString()} ",
                                      style: Big_A_style_medium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: h / 100,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        CupertinoIcons.location_solid,
                                        size: 15,
                                        color: Colors.grey.shade500,
                                      ),
                                      SizedBox(
                                        width: w / 2.3,
                                        child: Text(
                                          " ${dataa["shop_address"].toString()}",
                                          style: A_style_mid,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h / 100,
                                  ),
                                  Text("${dataa["distances"] ?? "0.0"} km",
                                      style: A_style_mid_black),
                                  SizedBox(
                                    height: h / 100,
                                  ),
                                  Row(
                                    children: [
                                      // SizedBox(width: w/20,),
                                      RatingBar.builder(
                                        itemSize: 18,
                                        initialRating: double.parse(
                                            dataa["average_ratings"]
                                                    .toString() ??
                                                '0.0'),
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        ignoreGestures: true,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star_rate,
                                          color: Colors.yellow.shade800,
                                        ),
                                        onRatingUpdate: (double value) {},
                                      ),
                                      Text("(${dataa["raters"] ?? "0"})",
                                          style: TextStyle(
                                              //letterSpacing: 1.5,
                                              //color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.blue.shade800,
                                              fontFamily: "Amazon_med",
                                              fontSize: 16)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("${dataa["sales"] ?? "0"} sales",
                                          style: A_style_mid_black),
                                      SizedBox(
                                        width: w / 4.7,
                                      ),
                                      PopupMenuButton(
                                        padding: const EdgeInsets.all(0),
                                        color: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        icon: const Icon(
                                          Icons.more_horiz,
                                          color: Colors.black,
                                        ),
                                        itemBuilder: (_) {
                                          return <PopupMenuEntry<String>>[
                                            PopupMenuItem<String>(
                                              onTap: () {
                                                Get.to(UserChat(
                                                    status: 1,
                                                    shopname:
                                                        dataa["shop_name"],
                                                    venderid: dataa["shopId"],
                                                    venderimage:
                                                        dataa["frontImage"]));
                                                //chat_api.chatsendlist();
                                              },
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
                                              onTap: () {
                                                deepp().generateLink(
                                                    "https://inntuser.page.link/SellerDetails?shopId=${dataa["shopId"]}&shopanme=${dataa["shop_name"]}");
                                              },
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
                                              onTap: () async {
                                                await favshop.Innt_favoriteshop(
                                                    dataa["shopId"]);
                                              },
                                              height: h / 25,
                                              value: 'Add to favorites',
                                              child: Row(
                                                children: [
                                                  const Text(
                                                      "Add to favorites"),
                                                  const Spacer(),
                                                  Icon(Icons.star_border,
                                                      size: h / 27,
                                                      color: Colors.black),
                                                ],
                                              ),
                                            ),
                                            const PopupMenuDivider(),
                                            PopupMenuItem<String>(
                                              onTap: () {
                                                Get.to(shopReport(
                                                  shopid: dataa["shopId"],
                                                  status: 0,
                                                ));
                                              },
                                              height: h / 25,
                                              value: 'Report',
                                              child: const Row(
                                                children: [
                                                  Text("Report"),
                                                  Spacer(),
                                                  Icon(
                                                    Icons
                                                        .report_problem_outlined,
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
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : favshop.favsellerfilterlist.isNotEmpty &&
                        favshop.favsellerfilterlist[0]["result"].toString() !=
                            "true".toString()
                    ? const Text("No seller")
                    : Obx(() => favshop.favshopsearchlisttt.isEmpty &&
                                search.text.isNotEmpty
                            ? const Text("No Shop")
                            : favshop.favshopsearchlisttt.isNotEmpty &&
                                    search.text.isNotEmpty
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        favshop.favshopsearchlisttt.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var dataa = favshop.favshopsearchlisttt
                                          .elementAt(index);
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(SellerDetails(
                                            sourceName: "0",
                                            shopid: dataa["shopId"],
                                            shopanme: dataa["shop_name"],
                                          ));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          margin: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    blurRadius: 3)
                                              ]),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  child: dataa["frontImage"] !=
                                                          null
                                                      ? Image.network(
                                                          "$image_url${dataa["frontImage"].toString()}",
                                                          fit: BoxFit.fill,
                                                          height: h / 5,
                                                          width: w / 2.5)
                                                      : SizedBox(
                                                          height: h / 5,
                                                          width: w / 2.5,
                                                          child: const Text(
                                                              "No image"),
                                                        )),
                                              SizedBox(
                                                width: w / 90,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: w / 2.2,
                                                    child: Text(
                                                      "${dataa["shop_name"].toString()} ",
                                                      style: TextStyle(
                                                          //letterSpacing: 1.5,
                                                          //color: Colors.white,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: darkomdee
                                                                      .darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontFamily:
                                                              "Amazon_med",
                                                          fontSize: 18),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: h / 100,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Icon(
                                                        CupertinoIcons
                                                            .location_solid,
                                                        size: 15,
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                      SizedBox(
                                                        width: w / 2.3,
                                                        child: Text(
                                                          " ${dataa["shop_address"].toString()}",
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
                                                              fontSize: 14),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: h / 100,
                                                  ),
                                                  Text(
                                                      "${dataa["distances"].toString()} km",
                                                      style: TextStyle(
                                                          //letterSpacing: 1.5,
                                                          //color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: darkomdee
                                                                      .darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontFamily:
                                                              "Amazon_med",
                                                          fontSize: 14)),
                                                  SizedBox(
                                                    height: h / 100,
                                                  ),
                                                  Row(
                                                    children: [
                                                      // SizedBox(width: w/20,),
                                                      RatingBar.builder(
                                                        itemSize: 18,
                                                        initialRating: double.parse(
                                                            dataa["average_ratings"]
                                                                    .toString() ??
                                                                "0.0"),
                                                        minRating: 0,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        unratedColor:
                                                            Colors.grey,
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
                                                          color: Colors
                                                              .yellow.shade800,
                                                        ),
                                                        onRatingUpdate:
                                                            (double value) {},
                                                      ),
                                                      Text(
                                                          "(${dataa["raters"] ?? "0.0"})",
                                                          style: TextStyle(
                                                              //letterSpacing: 1.5,
                                                              //color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: Colors.blue
                                                                  .shade800,
                                                              fontFamily:
                                                                  "Amazon_med",
                                                              fontSize: 16)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          "${dataa["sales"]} sales",
                                                          style:
                                                              A_style_mid_black),
                                                      SizedBox(
                                                        width: w / 4.7,
                                                      ),
                                                      PopupMenuButton(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
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
                                                              height: h / 25,
                                                              value: 'Chat',
                                                              child: const Row(
                                                                children: [
                                                                  Text("Chat"),
                                                                  Spacer(),
                                                                  Icon(
                                                                    Icons
                                                                        .chat_bubble_outline,
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
                                                              onTap: () async {
                                                                await favshop
                                                                    .Innt_favoriteshop(
                                                                        dataa[
                                                                            "shopId"]);
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
                                                                      size: h /
                                                                          27,
                                                                      color: Colors
                                                                          .black),
                                                                ],
                                                              ),
                                                            ),
                                                            const PopupMenuDivider(),
                                                            PopupMenuItem<
                                                                String>(
                                                              height: h / 25,
                                                              value: 'Report',
                                                              child: const Row(
                                                                children: [
                                                                  Text(
                                                                      "Report"),
                                                                  Spacer(),
                                                                  Icon(
                                                                    Icons
                                                                        .report_problem_outlined,
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
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : search.text.isEmpty
                                    ? FutureBuilder(
                                        future: favshop.Innt_favoriteshoplist(),
                                        builder: (context, snapshot) {
                                          return snapshot.connectionState ==
                                                  ConnectionState.waiting
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                  color: logocolo,
                                                ))
                                              : Obx(() =>
                                                  favshop.Favshoplist.isEmpty
                                                      ? const Text("No shops")
                                                      : Obx(() =>
                                                          favshop.changeviews
                                                                      .value ==
                                                                  0
                                                              ? ListView
                                                                  .builder(
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  itemCount: favshop
                                                                              .Favshoplist
                                                                          .elementAt(
                                                                              0)["data"]!
                                                                      .length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    var dataa = favshop.Favshoplist.elementAt(0)[
                                                                            "data"]!
                                                                        .elementAt(
                                                                            index);
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(
                                                                            SellerDetails(
                                                                          sourceName:
                                                                              "0",
                                                                          shopid:
                                                                              dataa["shopId"],
                                                                          shopanme:
                                                                              dataa["shop_name"],
                                                                        ));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4),
                                                                        margin: const EdgeInsets
                                                                            .all(
                                                                            4),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.circular(5),
                                                                            boxShadow: [
                                                                              BoxShadow(color: Colors.grey.shade300, blurRadius: 3)
                                                                            ]),
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Stack(
                                                                              children: [
                                                                                ClipRRect(
                                                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                    child: dataa["frontImage"] != null
                                                                                        ? Image.network("$image_url${dataa["frontImage"].toString()}", fit: BoxFit.fill, height: h / 5, width: w / 2.5)
                                                                                        : SizedBox(
                                                                                            height: h / 5,
                                                                                            width: w / 2.5,
                                                                                            child: const Text("No image"),
                                                                                          )),
                                                                                Positioned(
                                                                                    right: 3,
                                                                                    top: 5,
                                                                                    child: Icon(
                                                                                      Icons.star,
                                                                                      color: Colors.yellow,
                                                                                    ))
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              width: w / 90,
                                                                            ),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: w / 2.2,
                                                                                  child: Text(
                                                                                    "${dataa["shop_name"].toString()} ",
                                                                                    style: TextStyle(
                                                                                        //letterSpacing: 1.5,
                                                                                        //color: Colors.white,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        color: darkomdee.darkomde == true ? Colors.white : Colors.black,
                                                                                        fontFamily: "Amazon_med",
                                                                                        fontSize: 18),
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: h / 100,
                                                                                ),
                                                                                Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Icon(
                                                                                      CupertinoIcons.location_solid,
                                                                                      size: 15,
                                                                                      color: Colors.grey.shade500,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: w / 2.3,
                                                                                      child: Text(
                                                                                        " ${dataa["shop_address"].toString()}",
                                                                                        style: TextStyle(
                                                                                            //letterSpacing: 1.5,
                                                                                            //color: Colors.white,
                                                                                            color: darkomdee.darkomde == true ? Colors.white : Colors.grey.shade700,
                                                                                            fontFamily: "Amazon_med",
                                                                                            fontSize: 14),
                                                                                        maxLines: 1,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: h / 100,
                                                                                ),
                                                                                Text("${dataa["distances"].toString()} km",
                                                                                    style: TextStyle(
                                                                                        //letterSpacing: 1.5,
                                                                                        //color: Colors.white,
                                                                                        fontWeight: FontWeight.w300,
                                                                                        color: darkomdee.darkomde == true ? Colors.white : Colors.black,
                                                                                        fontFamily: "Amazon_med",
                                                                                        fontSize: 14)),
                                                                                SizedBox(
                                                                                  height: h / 100,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    // SizedBox(width: w/20,),
                                                                                    RatingBar.builder(
                                                                                      itemSize: 18,
                                                                                      initialRating: double.parse(dataa["average_ratings"].toString() ?? "0.0"),
                                                                                      minRating: 0,
                                                                                      direction: Axis.horizontal,
                                                                                      allowHalfRating: true,
                                                                                      unratedColor: Colors.grey,
                                                                                      itemCount: 5,
                                                                                      ignoreGestures: true,
                                                                                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                                                      itemBuilder: (context, _) => Icon(
                                                                                        Icons.star_rate,
                                                                                        color: Colors.yellow.shade800,
                                                                                      ),
                                                                                      onRatingUpdate: (double value) {},
                                                                                    ),
                                                                                    Text("(${dataa["raters"] ?? "0.0"})",
                                                                                        style: TextStyle(
                                                                                            //letterSpacing: 1.5,
                                                                                            //color: Colors.white,
                                                                                            fontWeight: FontWeight.w300,
                                                                                            color: Colors.blue.shade800,
                                                                                            fontFamily: "Amazon_med",
                                                                                            fontSize: 16)),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Text("${dataa["sales"]} sales", style: A_style_mid_black),
                                                                                    SizedBox(
                                                                                      width: w / 4.7,
                                                                                    ),
                                                                                    PopupMenuButton(
                                                                                      padding: const EdgeInsets.all(0),
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
                                                                                                  Icons.chat_bubble_outline,
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
                                                                                            onTap: () async {
                                                                                              await favshop.Innt_favoriteshop(dataa["shopId"]);
                                                                                            },
                                                                                            height: h / 25,
                                                                                            value: 'Add to favorites',
                                                                                            child: Row(
                                                                                              children: [
                                                                                                const Text("Add to favorites"),
                                                                                                const Spacer(),
                                                                                                Icon(Icons.star_border, size: h / 27, color: Colors.black),
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
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              : GridView
                                                                  .builder(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4),
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  physics:
                                                                      const ScrollPhysics(),
                                                                  // padding: EdgeInsets.all(4),
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
                                                                  itemCount: favshop
                                                                              .Favshoplist
                                                                          .elementAt(
                                                                              0)["data"]!
                                                                      .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    var dataa = favshop.Favshoplist.elementAt(0)[
                                                                            "data"]!
                                                                        .elementAt(
                                                                            index);
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(
                                                                            const SellerDetails(
                                                                          sourceName:
                                                                              "0",
                                                                        ));
                                                                      },
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), boxShadow: [
                                                                              BoxShadow(color: Colors.grey.shade300, blurRadius: 3)
                                                                            ]),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(4.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                    child: Image.network(
                                                                                      "$image_url${dataa["frontImage"].toString()}",
                                                                                      fit: BoxFit.fill,
                                                                                      height: h / 5.7,
                                                                                      width: w / 2,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: w / 2.5,
                                                                                    child: Text(
                                                                                      "${dataa["shop_name"]}",
                                                                                      style: Big_A_style_medium,
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: h / 100,
                                                                                  ),
                                                                                  Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Icon(
                                                                                        CupertinoIcons.location_solid,
                                                                                        size: 15,
                                                                                        color: Colors.grey.shade500,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: w / 2.5,
                                                                                        child: Text(
                                                                                          " ${dataa["shop_address"]}",
                                                                                          style: A_style_mid,
                                                                                          maxLines: 1,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: h / 100,
                                                                                  ),
                                                                                  Text("${dataa["distances"]}", style: A_style_mid_black),
                                                                                  SizedBox(
                                                                                    height: h / 100,
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      // SizedBox(width: w/20,),
                                                                                      RatingBar.builder(
                                                                                        itemSize: 18,
                                                                                        initialRating: double.parse(dataa["average_ratings"].toString()),
                                                                                        minRating: 0,
                                                                                        direction: Axis.horizontal,
                                                                                        allowHalfRating: true,
                                                                                        itemCount: 5,
                                                                                        ignoreGestures: true,
                                                                                        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                                                        itemBuilder: (context, _) => Icon(
                                                                                          Icons.star_rate,
                                                                                          color: Colors.yellow.shade800,
                                                                                        ),
                                                                                        onRatingUpdate: (double value) {},
                                                                                      ),
                                                                                      Text("(${dataa["raters"]})",
                                                                                          style: TextStyle(
                                                                                              //letterSpacing: 1.5,
                                                                                              //color: Colors.white,
                                                                                              fontWeight: FontWeight.w300,
                                                                                              color: Colors.blue.shade800,
                                                                                              fontFamily: "Amazon_med",
                                                                                              fontSize: 16)),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text("${dataa["sales"]} sales", style: A_style_mid_black),
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
                                                                                                    Icons.chat_bubble_outline,
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
                                                                                                  Icon(Icons.star_border, size: h / 27, color: Colors.black),
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
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Positioned(
                                                                              right: 3,
                                                                              height: 13,
                                                                              child: Icon(
                                                                                Icons.star,
                                                                                color: Colors.yellow,
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                )));
                                        },
                                      )
                                    : const SizedBox()
                        // }
                        ))
          ],
        ),
      ),
    );
  }
}
