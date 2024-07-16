import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:inntuser/Api/Homepageproductlist.dart';
import 'package:inntuser/screen/Users/sellers/sellercontroller.dart';
import 'package:inntuser/screen/Users/sellers/sellerdeatils.dart';

import '../../../Api/favoriteshop_api.dart';
import '../../../Controller/text2.dart';
import '../../../firebase/deeplinking.dart';
import '../../../main.dart';
import '../../../ulits/constant.dart';
import '../chatting.dart';
import '../home.dart';
import '../home_search.dart';
import '../shopreport.dart';
import 'filter.dart';

late Future getsellercate;

class Sellerall extends StatefulWidget {
  const Sellerall({super.key});

  @override
  State<Sellerall> createState() => _SellerallState();
}

class _SellerallState extends State<Sellerall> {
  String selectedItem = 'Share';
  String selectedSellerItem = 'Share';

  String dropdownvalue = "All Shops";

  final changeviews = Get.put(Seller());
  final shoplist = Get.put(Homepage_api());
  final favshop = Get.put(Inntfavoriteshop());

  @override
  void initState() {
    // TODO: implement initState

    cateshop();

    super.initState();
  }

  Future cateshop() async {
    print("hhhhhd0");
    // Clear the existing categories

    shoplist.categoriee.clear();
    // Add the initial category
    shoplist.categoriee
        .add({"cate_name": "All Shops", "cate_value": "All Shops"});
    print("ddrrr");
    // Fetch and add categories from the API
    for (var element in getInntCategory_api.inntCategory) {
      shoplist.categoriee.add({
        "cate_name": element.categoryEnglishName.toString(),
        "cate_value": element.sId.toString(),
      });
    }
    print("dddd");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    homeapi.allsellerfilterlist.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        titleSpacing: 4,
        toolbarHeight: h / 7.5,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h / 90,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                SizedBox(
                  height: h / 20,
                  width: w / 1.2,
                  child: TextFormField(
                    onTap: () {
                      Get.to(const HomeSearch());
                    },
                    readOnly: true,
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
              ],
            ),
            Row(
              children: [
                const Spacer(),
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Sellerfilter(
                                  lower: homeapi.shopdistancemin["distances"],
                                  higher: homeapi.shopdistancemax["distances"],
                                ),
                              ));
                        },
                        child: const Icon(
                          Icons.filter_list,
                          color: white,
                        ),
                      ),
                      Obx(
                        () => changeviews.changeview.value == 0
                            ? IconButton(
                                onPressed: () {
                                  changeviews.change(1);
                                },
                                icon: const Icon(
                                  Icons.grid_view_rounded,
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() =>
            homeapi.allsellerfilterlist.isNotEmpty &&
                    homeapi.allsellerfilterlist[0]["result"].toString() ==
                        "true".toString()
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: shoplist.allsellerfilterlist
                        .elementAt(0)["data"]!
                        .length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var dataa = shoplist.allsellerfilterlist
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
                : homeapi.allsellerfilterlist.isNotEmpty &&
                        homeapi.allsellerfilterlist[0]["result"].toString() !=
                            "true".toString()
                    ? const Text("All seller")
                    : FutureBuilder(
                        future: shoplist.inntShop_list_List(),
                        builder: (context, snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: logocolo,
                                ))
                              : Obx(() => shoplist.inntShop_listList.isEmpty
                                  ? const Text("No shops")
                                  : Obx(() => changeviews.changeview.value == 0
                                      ? ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: shoplist.inntShop_listList
                                              .elementAt(0)
                                              .data!
                                              .length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            var dataa = shoplist
                                                .inntShop_listList
                                                .elementAt(0)
                                                .data!
                                                .elementAt(index);
                                            return GestureDetector(
                                              onTap: () {
                                                print(
                                                    " ${dataa.shopId.toString()}");
                                                Get.to(SellerDetails(
                                                  sourceName: "0",
                                                  shopid:
                                                      dataa.shopId.toString(),
                                                  shopanme: dataa.shopName,
                                                ));
                                              },
                                              child: Container(
                                                width: w,
                                                // padding:
                                                //     const EdgeInsets.all(4),
                                                margin: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: darkomdee.darkomde ==
                                                            true
                                                        ? Colors.black
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors
                                                              .grey.shade300,
                                                          blurRadius: 3)
                                                    ]),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: h / 4.5,
                                                      width: w / 2.5,
                                                      child: ClipRRect(
                                                          borderRadius: const BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                      10)),
                                                          child: dataa.frontImage !=
                                                                  null
                                                              ? Image.network(
                                                                  "$image_url${dataa.frontImage.toString()}",
                                                                  fit: BoxFit.fill,
                                                                  errorBuilder:
                                                                      (context,
                                                                          error,
                                                                          stackTrace) {
                                                                  return Text(
                                                                      "Loading ....");
                                                                },
                                                                  height: h / 5,
                                                                  width:
                                                                      w / 2.5)
                                                              : SizedBox(
                                                                  height: h / 5,
                                                                  width:
                                                                      w / 2.5,
                                                                  child: const Text(
                                                                      "No image"),
                                                                )),
                                                    ),
                                                    SizedBox(
                                                      width: w / 90,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: w / 2.2,
                                                            child: Text(
                                                              "${dataa.shopName.toString()} ",
                                                              style: TextStyle(
                                                                  //letterSpacing: 1.5,
                                                                  //color: Colors.white,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: darkomdee
                                                                              .darkomde ==
                                                                          true
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontFamily:
                                                                      "Amazon_med",
                                                                  fontSize: 18),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                                                    .grey
                                                                    .shade500,
                                                              ),
                                                              SizedBox(
                                                                width: w / 2.3,
                                                                child: Text(
                                                                  " ${dataa.shopAddress.toString()}",
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
                                                          Text(
                                                              "${dataa.distances} km",
                                                              style: TextStyle(
                                                                  //letterSpacing: 1.5,
                                                                  //color: Colors.white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: darkomdee
                                                                              .darkomde ==
                                                                          true
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontFamily:
                                                                      "Amazon_med",
                                                                  fontSize:
                                                                      14)),
                                                          SizedBox(
                                                            height: h / 100,
                                                          ),
                                                          Row(
                                                            children: [
                                                              // SizedBox(width: w/20,),
                                                              RatingBar.builder(
                                                                itemSize: 18,
                                                                initialRating: double
                                                                    .parse(dataa
                                                                        .averageRatings
                                                                        .toString()),
                                                                minRating: 0,
                                                                unratedColor:
                                                                    Colors.grey,
                                                                direction: Axis
                                                                    .horizontal,
                                                                allowHalfRating:
                                                                    true,
                                                                itemCount: 5,
                                                                ignoreGestures:
                                                                    true,
                                                                itemPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            2.0),
                                                                itemBuilder:
                                                                    (context,
                                                                            _) =>
                                                                        Icon(
                                                                  Icons
                                                                      .star_rate,
                                                                  color: Colors
                                                                      .yellow
                                                                      .shade800,
                                                                ),
                                                                onRatingUpdate:
                                                                    (double
                                                                        value) {},
                                                              ),
                                                              Text(
                                                                  "(${dataa.raters})",
                                                                  style: TextStyle(
                                                                      //letterSpacing: 1.5,
                                                                      //color: Colors.white,
                                                                      fontWeight: FontWeight.w300,
                                                                      color: darkomdee.darkomde == true ? Colors.white : Colors.blue.shade800,
                                                                      fontFamily: "Amazon_med",
                                                                      fontSize: 16)),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "${dataa.sales} sales",
                                                                  style: TextStyle(
                                                                      //letterSpacing: 1.5,
                                                                      //color: Colors.white,
                                                                      fontWeight: FontWeight.w300,
                                                                      color: darkomdee.darkomde == true ? Colors.white : Colors.black,
                                                                      fontFamily: "Amazon_med",
                                                                      fontSize: 14)),
                                                              SizedBox(
                                                                width: w / 4.7,
                                                              ),
                                                              PopupMenuButton(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(0),
                                                                color: Colors
                                                                    .white,
                                                                surfaceTintColor:
                                                                    Colors
                                                                        .white,
                                                                icon: Icon(
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
                                                                        Get.to(UserChat(
                                                                            status:
                                                                                1,
                                                                            shopname:
                                                                                dataa.shopName,
                                                                            venderid: dataa.shopId,
                                                                            venderimage: dataa.frontImage));
                                                                        //chat_api.chatsendlist();
                                                                      },
                                                                      height:
                                                                          h / 25,
                                                                      value:
                                                                          'Chat',
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                              "Chat"),
                                                                          Spacer(),
                                                                          Icon(
                                                                            Icons.message_outlined,
                                                                            weight:
                                                                                w / 27,
                                                                            color:
                                                                                Colors.black,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const PopupMenuDivider(),
                                                                    PopupMenuItem<
                                                                        String>(
                                                                      onTap:
                                                                          () {
                                                                        deepp().generateLink(
                                                                            "https://inntuser.page.link/SellerDetails?shopId=${dataa.shopId}&shopanme=${dataa.shopName}");
                                                                      },
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
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 8.0),
                                                                            child:
                                                                                Image.asset(
                                                                              "assets/images/share.png",
                                                                              width: w / 26,
                                                                              height: h / 26,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const PopupMenuDivider(),
                                                                    PopupMenuItem<
                                                                        String>(
                                                                      onTap:
                                                                          () async {
                                                                        await favshop.Innt_favoriteshop(
                                                                            dataa.shopId);
                                                                      },
                                                                      height:
                                                                          h / 25,
                                                                      value:
                                                                          'Add to favorites',
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Text(
                                                                              "Add to favorites"),
                                                                          const Spacer(),
                                                                          Icon(
                                                                              Icons.star_border,
                                                                              weight: w / 27,
                                                                              color: Colors.black),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const PopupMenuDivider(),
                                                                    PopupMenuItem<
                                                                        String>(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(
                                                                            shopReport(
                                                                          shopid:
                                                                              dataa.shopId,
                                                                          status:
                                                                              0,
                                                                        ));
                                                                      },
                                                                      height:
                                                                          h / 25,
                                                                      value:
                                                                          'Report',
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                              "Report"),
                                                                          Spacer(),
                                                                          Icon(
                                                                            Icons.report_problem_outlined,
                                                                            weight:
                                                                                w / 27,
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
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : GridView.builder(
                                          padding: const EdgeInsets.all(4),
                                          scrollDirection: Axis.vertical,
                                          physics: const ScrollPhysics(),
                                          // padding: EdgeInsets.all(4),
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
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        1.2),
                                          ),
                                          itemCount: shoplist.inntShop_listList
                                              .elementAt(0)
                                              .data!
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var dataa = shoplist
                                                .inntShop_listList
                                                .elementAt(0)
                                                .data!
                                                .elementAt(index);
                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(const SellerDetails(
                                                  sourceName: "0",
                                                ));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors
                                                              .grey.shade300,
                                                          blurRadius: 3)
                                                    ]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child: Image.network(
                                                          "$image_url${dataa.frontImage.toString()}",
                                                          fit: BoxFit.fill,
                                                          height: h / 5.7,
                                                          width: w / 2,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: w / 2.5,
                                                        child: Text(
                                                          "${dataa.shopName}",
                                                          style:
                                                              Big_A_style_medium,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                            width: w / 2.5,
                                                            child: Text(
                                                              " ${dataa.shopAddress}",
                                                              style:
                                                                  A_style_mid,
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: h / 100,
                                                      ),
                                                      Text("${dataa.distances}",
                                                          style:
                                                              A_style_mid_black),
                                                      SizedBox(
                                                        height: h / 100,
                                                      ),
                                                      Row(
                                                        children: [
                                                          // SizedBox(width: w/20,),
                                                          RatingBar.builder(
                                                            itemSize: 18,
                                                            initialRating: double
                                                                .parse(dataa
                                                                    .averageRatings
                                                                    .toString()),
                                                            minRating: 0,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                true,
                                                            itemCount: 5,
                                                            ignoreGestures:
                                                                true,
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
                                                                  .yellow
                                                                  .shade800,
                                                            ),
                                                            onRatingUpdate:
                                                                (double
                                                                    value) {},
                                                          ),
                                                          Text(
                                                              "(${dataa.raters})",
                                                              style: TextStyle(
                                                                  //letterSpacing: 1.5,
                                                                  //color: Colors.white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Colors
                                                                      .blue
                                                                      .shade800,
                                                                  fontFamily:
                                                                      "Amazon_med",
                                                                  fontSize:
                                                                      16)),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "${dataa.sales} sales",
                                                              style:
                                                                  A_style_mid_black),
                                                          PopupMenuButton(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            color: Colors.white,
                                                            surfaceTintColor:
                                                                Colors.white,
                                                            initialValue:
                                                                selectedItem,
                                                            icon: const Icon(
                                                              Icons.more_horiz,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            itemBuilder: (_) {
                                                              return <PopupMenuEntry<
                                                                  String>>[
                                                                PopupMenuItem<
                                                                    String>(
                                                                  onTap: () {
                                                                    Get.to(UserChat(
                                                                        status:
                                                                            1,
                                                                        shopname:
                                                                            dataa
                                                                                .shopName,
                                                                        venderid:
                                                                            dataa
                                                                                .shopId,
                                                                        venderimage:
                                                                            dataa.frontImage));
                                                                    //chat_api.chatsendlist();
                                                                  },
                                                                  height:
                                                                      h / 25,
                                                                  value: 'Chat',
                                                                  child:
                                                                      const Row(
                                                                    children: [
                                                                      Text(
                                                                          "Chat"),
                                                                      Spacer(),
                                                                      Icon(
                                                                        Icons
                                                                            .message_outlined,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .black,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                const PopupMenuDivider(),
                                                                PopupMenuItem<
                                                                    String>(
                                                                  onTap: () {
                                                                    deepp().generateLink(
                                                                        "https://inntuser.page.link/SellerDetails?shopId=${dataa.shopId}&shopanme=${dataa.shopName}");
                                                                  },
                                                                  height:
                                                                      h / 25,
                                                                  value:
                                                                      'Share',
                                                                  child: Row(
                                                                    children: [
                                                                      const Text(
                                                                          "Share"),
                                                                      const Spacer(),
                                                                      Image
                                                                          .asset(
                                                                        "assets/images/share.png",
                                                                        width: w /
                                                                            27,
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
                                                                  onTap:
                                                                      () async {
                                                                    await favshop
                                                                        .Innt_favoriteshop(
                                                                            dataa.shopId);
                                                                  },
                                                                  height:
                                                                      h / 25,
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
                                                                          color:
                                                                              Colors.black),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const PopupMenuDivider(),
                                                                PopupMenuItem<
                                                                    String>(
                                                                  onTap: () {
                                                                    Get.to(
                                                                        shopReport(
                                                                      shopid: dataa
                                                                          .shopId,
                                                                      status: 0,
                                                                    ));
                                                                  },
                                                                  height:
                                                                      h / 25,
                                                                  value:
                                                                      'Report',
                                                                  child:
                                                                      const Row(
                                                                    children: [
                                                                      Text(
                                                                          "Report"),
                                                                      Spacer(),
                                                                      Icon(
                                                                        Icons
                                                                            .report_problem_outlined,
                                                                        size:
                                                                            20,
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
                                                ),
                                              ),
                                            );
                                          },
                                        )));
                        },
                      )
            )],
        ),
      ),
    );
  }
}
