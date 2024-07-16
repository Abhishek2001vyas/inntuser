import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/productdeatils.dart';
import 'package:inntuser/screen/Users/sellers/sellercontroller.dart';
import 'package:inntuser/screen/Users/subcatebycat.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api/Homepageproductlist.dart';
import '../../Controller/text2.dart';
import '../../after/viewall/filter.dart';
import '../../language_constant.dart';
import '../../main.dart';
import '../../ulits/constant.dart';
import 'home.dart';

class ViewAll extends StatefulWidget {
  final textapp;
  final unkey;

  const ViewAll({super.key, this.textapp, this.unkey});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  final changeviews = Get.put(Seller());
  final homeapi = Get.put(Homepage_api());

  @override
  void dispose() {
    // TODO: implement dispose
    lll();
    homeapi.homepageprofilter.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String selectedItem = 'Move to bag';
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text("${widget.textapp}"),
        centerTitle: true,
        actions: [
          widget.unkey == 10
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    Get.to(() => Filter(
                          status: widget.unkey,
                          higher: widget.unkey == 1
                              ? homeapi
                                  .productWithHighestSalePrice1["sale_price"]
                              : widget.unkey == 2
                                  ? homeapi.productWithHighestSalePrice2[
                                      "sale_price"]
                                  : widget.unkey == 6
                                      ? homeapi.productWithHighestSalePrice3[
                                          "sale_price"]
                                      : null,
                          lower: widget.unkey == 1
                              ? homeapi
                                  .productWithLowestSalePrice1["sale_price"]
                              : widget.unkey == 2
                                  ? homeapi
                                      .productWithLowestSalePrice2["sale_price"]
                                  : widget.unkey == 6
                                      ? homeapi.productWithLowestSalePrice3[
                                          "sale_price"]
                                      : null,
                        ));
                    //  _showScannerOptions(context);
                  },
                ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => changeviews.changeview.value == 0
                  ? Column(
                      children: [
                        SizedBox(height: h / 80),
                        widget.unkey == 1 &&
                                    homeapi.homepageprofilter[0]["result"]
                                            .toString() ==
                                        "true".toString() ||
                                widget.unkey == 2 &&
                                    homeapi.homepageprofilter[0]["result"]
                                            .toString() ==
                                        "true".toString() ||
                                widget.unkey == 6 &&
                                    homeapi.homepageprofilter[0]["result"]
                                            .toString() ==
                                        "true".toString()
                            ? GridView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                // padding: EdgeInsets.all(4),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 1,
                                  childAspectRatio:
                                      (MediaQuery.of(context).size.width / 1) /
                                          (MediaQuery.of(context).size.height /
                                              1.8),
                                ),
                                itemCount: homeapi.homepageprofilter
                                    .elementAt(0)["data"]!
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  print("uudjghuvdfuigh3333");
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(Product_deatils(
                                          sourceName: "0",
                                          subsubcateid: homeapi
                                              .homepageprofilter
                                              .elementAt(0)["data"]!
                                              .elementAt(index)["productId"],
                                          shopid: homeapi.homepageprofilter
                                              .elementAt(0)["data"]
                                              .elementAt(index)["venderId"],
                                        ));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(4),
                                        width: w * 2 / 6,
                                        height: h / 1,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  blurRadius: 1)
                                            ]),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                SizedBox(
                                                  height: h / 5.5,
                                                  width: w / 1,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topRight: Radius
                                                                  .circular(8),
                                                              topLeft: Radius
                                                                  .circular(8)),
                                                      child: Image.network(
                                                          "$image_url${homeapi.homepageprofilter.elementAt(0)["data"]!.elementAt(index)["image1"]}",
                                                          fit: BoxFit
                                                              .fitHeight)),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width: w / 2.5,
                                                    child: Text(
                                                      homeapi.homepageprofilter
                                                          .elementAt(0)["data"]!
                                                          .elementAt(index)[
                                                              "product_name"]
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            "Amazon_med",
                                                      ),
                                                    ),
                                                  ),

                                                  Text(
                                                    "\$${homeapi.homepageprofilter.elementAt(0)["data"]!.elementAt(index)["sale_price"]}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Emebr_light",
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   height: h / 100,
                                                  // ),
                                                  // Container(
                                                  //   width: w / 1,
                                                  //   child: const Text(
                                                  //       overflow: TextOverflow.ellipsis,
                                                  //       maxLines: 1,
                                                  //       "jjkksdklfklds,nkgfmnsdklngvghgfhfghdfasgdcvgbnashgcfdvjhsadjcvdshcvbhdsjchsddjklfjdskljfvlkdsklsdnklbv",
                                                  //       style: TextStyle(
                                                  //           color: Colors.black,
                                                  //           fontWeight: FontWeight.w400,
                                                  //           fontSize: 13,
                                                  //           fontFamily: "Ember_Light")),
                                                  // ),

                                                  // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  //   children: [
                                                  //     Text("\$ 20",style: TextStyle(fontSize: 14,fontFamily: "Amazon_bold"),),
                                                  //     Material(borderRadius: BorderRadius.circular(15),elevation: 1,
                                                  //       child: Container(decoration: BoxDecoration(color: logocolo,borderRadius: BorderRadius.circular(15)),
                                                  //         height: h/28,width: w/6,
                                                  //         child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                  //         children: [
                                                  //           Icon(Icons.shopping_bag,color: Colors.white,size: 15,),
                                                  //           Text(" Add",style: TextStyle(fontSize: 13,fontFamily: "Amazon_bold",color: Colors.white),)
                                                  //         ]),
                                                  //       ),
                                                  //     )
                                                  //   ],
                                                  // )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : widget.unkey == 1 &&
                                        homeapi.homepageprofilter[0]["result"]
                                                .toString() ==
                                            "false".toString() ||
                                    widget.unkey == 2 &&
                                        homeapi.homepageprofilter[0]["result"]
                                                .toString() ==
                                            "false".toString() ||
                                    widget.unkey == 6 &&
                                        homeapi.homepageprofilter[0]["result"]
                                                .toString() ==
                                            "false".toString()
                                ? const Center(child: Text("No products"))
                                : widget.unkey == 1
                                    ? GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        // padding: EdgeInsets.all(4),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 1,
                                          mainAxisSpacing: 1,
                                          childAspectRatio:
                                              (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1) /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      1.8),
                                        ),
                                        itemCount: homeapi
                                            .dayOftheDeals_ProductList
                                            .elementAt(0)
                                            .data!
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          print("uudjghuvdfuigh");
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(Product_deatils(
                                                  sourceName: "0",
                                                  subsubcateid: homeapi
                                                      .dayOftheDeals_ProductList
                                                      .elementAt(0)
                                                      .data!
                                                      .elementAt(index)
                                                      .productId,
                                                  shopid: homeapi.newarrivallist
                                                      .elementAt(0)
                                                      .data!
                                                      .elementAt(index)
                                                      .venderId,
                                                ));
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.all(4),
                                                width: w * 2 / 6,
                                                height: h / 1,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors
                                                              .grey.shade300,
                                                          blurRadius: 1)
                                                    ]),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        SizedBox(
                                                          height: h / 5.5,
                                                          width: w / 1,
                                                          child: ClipRRect(
                                                              borderRadius: const BorderRadius
                                                                  .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8)),
                                                              child: Image.network(
                                                                  "$image_url${homeapi.dayOftheDeals_ProductList.elementAt(0).data!.elementAt(index).image1}",
                                                                  fit: BoxFit
                                                                      .fitHeight)),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          SizedBox(
                                                            width: w / 2.5,
                                                            child: Text(
                                                              homeapi
                                                                  .dayOftheDeals_ProductList
                                                                  .elementAt(0)
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .productName
                                                                  .toString(),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    "Amazon_med",
                                                              ),
                                                            ),
                                                          ),

                                                          Text(
                                                            "\$${homeapi.dayOftheDeals_ProductList.elementAt(0).data!.elementAt(index).salePrice}",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Emebr_light",
                                                            ),
                                                          ),
                                                          // SizedBox(
                                                          //   height: h / 100,
                                                          // ),
                                                          // Container(
                                                          //   width: w / 1,
                                                          //   child: const Text(
                                                          //       overflow: TextOverflow.ellipsis,
                                                          //       maxLines: 1,
                                                          //       "jjkksdklfklds,nkgfmnsdklngvghgfhfghdfasgdcvgbnashgcfdvjhsadjcvdshcvbhdsjchsddjklfjdskljfvlkdsklsdnklbv",
                                                          //       style: TextStyle(
                                                          //           color: Colors.black,
                                                          //           fontWeight: FontWeight.w400,
                                                          //           fontSize: 13,
                                                          //           fontFamily: "Ember_Light")),
                                                          // ),

                                                          // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          //   children: [
                                                          //     Text("\$ 20",style: TextStyle(fontSize: 14,fontFamily: "Amazon_bold"),),
                                                          //     Material(borderRadius: BorderRadius.circular(15),elevation: 1,
                                                          //       child: Container(decoration: BoxDecoration(color: logocolo,borderRadius: BorderRadius.circular(15)),
                                                          //         height: h/28,width: w/6,
                                                          //         child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                          //         children: [
                                                          //           Icon(Icons.shopping_bag,color: Colors.white,size: 15,),
                                                          //           Text(" Add",style: TextStyle(fontSize: 13,fontFamily: "Amazon_bold",color: Colors.white),)
                                                          //         ]),
                                                          //       ),
                                                          //     )
                                                          //   ],
                                                          // )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : widget.unkey == 2
                                        ? GridView.builder(
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            // padding: EdgeInsets.all(4),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 1,
                                              mainAxisSpacing: 1,
                                              childAspectRatio:
                                                  (MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          1) /
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          1.8),
                                            ),
                                            itemCount: homeapi.newarrivallist
                                                .elementAt(0)
                                                .data!
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              print("uudjghuvdfuigh");
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.to(Product_deatils(
                                                      sourceName: "0",
                                                      subsubcateid: homeapi
                                                          .newarrivallist
                                                          .elementAt(0)
                                                          .data!
                                                          .elementAt(index)
                                                          .productId,
                                                      shopid: homeapi
                                                          .newarrivallist
                                                          .elementAt(0)
                                                          .data!
                                                          .elementAt(index)
                                                          .venderId,
                                                    ));
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(4),
                                                    width: w * 2 / 6,
                                                    height: h / 1,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.grey
                                                                  .shade300,
                                                              blurRadius: 1)
                                                        ]),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            SizedBox(
                                                              height: h / 5.5,
                                                              width: w / 1,
                                                              child: ClipRRect(
                                                                  borderRadius: const BorderRadius
                                                                      .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              8),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              8)),
                                                                  child: Image.network(
                                                                      "$image_url${homeapi.newarrivallist.elementAt(0).data!.elementAt(index).image1}",
                                                                      fit: BoxFit
                                                                          .fitHeight)),
                                                            ),
                                                            /*   Positioned(
                                                      child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(
                              CupertinoIcons.heart,
                              color: Colors.black,
                              size: 18,
                            ),
                                                      )
                                                    ],
                                                  ))*/
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              SizedBox(
                                                                width: w / 2.5,
                                                                child: Text(
                                                                  homeapi
                                                                      .newarrivallist
                                                                      .elementAt(
                                                                          0)
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .productName
                                                                      .toString(),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        "Amazon_med",
                                                                  ),
                                                                ),
                                                              ),

                                                              Text(
                                                                "\$${homeapi.newarrivallist.elementAt(0).data!.elementAt(index).salePrice}",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      "Emebr_light",
                                                                ),
                                                              ),
                                                              // SizedBox(
                                                              //   height: h / 100,
                                                              // ),
                                                              // Container(
                                                              //   width: w / 1,
                                                              //   child: const Text(
                                                              //       overflow: TextOverflow.ellipsis,
                                                              //       maxLines: 1,
                                                              //       "jjkksdklfklds,nkgfmnsdklngvghgfhfghdfasgdcvgbnashgcfdvjhsadjcvdshcvbhdsjchsddjklfjdskljfvlkdsklsdnklbv",
                                                              //       style: TextStyle(
                                                              //           color: Colors.black,
                                                              //           fontWeight: FontWeight.w400,
                                                              //           fontSize: 13,
                                                              //           fontFamily: "Ember_Light")),
                                                              // ),

                                                              // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              //   children: [
                                                              //     Text("\$ 20",style: TextStyle(fontSize: 14,fontFamily: "Amazon_bold"),),
                                                              //     Material(borderRadius: BorderRadius.circular(15),elevation: 1,
                                                              //       child: Container(decoration: BoxDecoration(color: logocolo,borderRadius: BorderRadius.circular(15)),
                                                              //         height: h/28,width: w/6,
                                                              //         child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                              //         children: [
                                                              //           Icon(Icons.shopping_bag,color: Colors.white,size: 15,),
                                                              //           Text(" Add",style: TextStyle(fontSize: 13,fontFamily: "Amazon_bold",color: Colors.white),)
                                                              //         ]),
                                                              //       ),
                                                              //     )
                                                              //   ],
                                                              // )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : widget.unkey == 5
                                            ? GridView.builder(
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                // padding: EdgeInsets.all(4),
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 1,
                                                  mainAxisSpacing: 1,
                                                  childAspectRatio:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1) /
                                                          (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              1.8),
                                                ),
                                                itemCount: homeapi
                                                    .suggested_ProductListList
                                                    .elementAt(0)
                                                    .data!
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.to(Product_deatils(
                                                          sourceName: "0",
                                                          subsubcateid: homeapi
                                                              .suggested_ProductListList
                                                              .elementAt(0)
                                                              .data!
                                                              .elementAt(index)
                                                              .productId!
                                                              .id,
                                                          shopid: homeapi
                                                              .suggested_ProductListList
                                                              .elementAt(0)
                                                              .data!
                                                              .elementAt(index)
                                                              .productId!
                                                              .venderId,
                                                        ));
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .all(4),
                                                        width: w * 2 / 6,
                                                        height: h / 1,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  blurRadius: 1)
                                                            ]),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      h / 5.5,
                                                                  width: w / 1,
                                                                  child: ClipRRect(
                                                                      borderRadius: const BorderRadius
                                                                          .only(
                                                                          topRight: Radius.circular(
                                                                              8),
                                                                          topLeft: Radius.circular(
                                                                              8)),
                                                                      child: Image.network(
                                                                          "$image_url${homeapi.suggested_ProductListList.elementAt(0).data!.elementAt(index).productId!.image1}",
                                                                          fit: BoxFit
                                                                              .fitHeight)),
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        w / 2.5,
                                                                    child: Text(
                                                                      homeapi
                                                                          .suggested_ProductListList
                                                                          .elementAt(
                                                                              0)
                                                                          .data!
                                                                          .elementAt(
                                                                              index)
                                                                          .productId!
                                                                          .productName
                                                                          .toString(),
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            "Amazon_med",
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  Text(
                                                                    "\$${homeapi.suggested_ProductListList.elementAt(0).data!.elementAt(index).productId!.salePrice}",
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          "Emebr_light",
                                                                    ),
                                                                  ),
                                                                  // SizedBox(
                                                                  //   height: h / 100,
                                                                  // ),
                                                                  // Container(
                                                                  //   width: w / 1,
                                                                  //   child: const Text(
                                                                  //       overflow: TextOverflow.ellipsis,
                                                                  //       maxLines: 1,
                                                                  //       "jjkksdklfklds,nkgfmnsdklngvghgfhfghdfasgdcvgbnashgcfdvjhsadjcvdshcvbhdsjchsddjklfjdskljfvlkdsklsdnklbv",
                                                                  //       style: TextStyle(
                                                                  //           color: Colors.black,
                                                                  //           fontWeight: FontWeight.w400,
                                                                  //           fontSize: 13,
                                                                  //           fontFamily: "Ember_Light")),
                                                                  // ),

                                                                  // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  //   children: [
                                                                  //     Text("\$ 20",style: TextStyle(fontSize: 14,fontFamily: "Amazon_bold"),),
                                                                  //     Material(borderRadius: BorderRadius.circular(15),elevation: 1,
                                                                  //       child: Container(decoration: BoxDecoration(color: logocolo,borderRadius: BorderRadius.circular(15)),
                                                                  //         height: h/28,width: w/6,
                                                                  //         child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                                  //         children: [
                                                                  //           Icon(Icons.shopping_bag,color: Colors.white,size: 15,),
                                                                  //           Text(" Add",style: TextStyle(fontSize: 13,fontFamily: "Amazon_bold",color: Colors.white),)
                                                                  //         ]),
                                                                  //       ),
                                                                  //     )
                                                                  //   ],
                                                                  // )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            : widget.unkey == 6
                                                ? GridView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    // padding: EdgeInsets.all(4),
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 1,
                                                      mainAxisSpacing: 1,
                                                      childAspectRatio:
                                                          (MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  1) /
                                                              (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  1.8),
                                                    ),
                                                    itemCount: homeapi
                                                        .trendingNowList
                                                        .elementAt(0)["data"]!
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Get.to(
                                                                Product_deatils(
                                                              sourceName: "0",
                                                              conn: "0.0",
                                                              subsubcateid: homeapi
                                                                  .trendingNowList
                                                                  .elementAt(0)[
                                                                      "data"]!
                                                                  .elementAt(
                                                                      index)["productId"],
                                                              shopid: homeapi
                                                                  .trendingNowList
                                                                  .elementAt(0)[
                                                                      "data"]!
                                                                  .elementAt(
                                                                      index)["venderId"],
                                                            ));
                                                          },
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(4),
                                                            width: w * 2 / 6,
                                                            height: h / 1,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      blurRadius:
                                                                          1)
                                                                ]),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    SizedBox(
                                                                      height: h /
                                                                          5.5,
                                                                      width:
                                                                          w / 1,
                                                                      child: ClipRRect(
                                                                          borderRadius: const BorderRadius
                                                                              .only(
                                                                              topRight: Radius.circular(
                                                                                  8),
                                                                              topLeft: Radius.circular(
                                                                                  8)),
                                                                          child: Image.network(
                                                                              "$image_url${homeapi.trendingNowList.elementAt(0)["data"]!.elementAt(index)["image1"].toString()}",
                                                                              fit: BoxFit.fitHeight)),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      SizedBox(
                                                                        width: w /
                                                                            2.5,
                                                                        child:
                                                                            Text(
                                                                          homeapi
                                                                              .trendingNowList
                                                                              .elementAt(0)["data"]!
                                                                              .elementAt(index)["product_name"]
                                                                              .toString(),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily:
                                                                                "Amazon_med",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "\$${homeapi.trendingNowList.elementAt(0)["data"]!.elementAt(index)["sale_price"]}",
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontFamily:
                                                                              "Emebr_light",
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : widget.unkey == 10
                                                    ? GridView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            getInntCategory_api
                                                                .inntCategory
                                                                .length,
                                                        // homeapi.newarrivallist.elementAt(0).data!.length >=4 ? 4: homeapi.newarrivallist.elementAt(0).data!.length,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          crossAxisSpacing: 5,
                                                          mainAxisSpacing: 5,
                                                          childAspectRatio: MediaQuery
                                                                      .of(
                                                                          context)
                                                                  .size
                                                                  .width /
                                                              (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  1.5),
                                                        ),
                                                        itemBuilder:
                                                            (context, index) {
                                                          lll();
                                                          //  final inntCategoryList = snapshot.data![index] ?? 0;
                                                          return GestureDetector(
                                                            onTap: () {
                                                              // Navigate to the category screen when tapped
                                                              Get.to(Subcatby(
                                                                categoryId: getInntCategory_api
                                                                    .inntCategory[
                                                                        index]
                                                                    .sId
                                                                    .toString(),
                                                                subcate: getInntCategory_api
                                                                    .inntCategory[
                                                                        index]
                                                                    .categoryEnglishName
                                                                    .toString(),
                                                              ));
                                                            },
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(4),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      blurRadius:
                                                                          5)
                                                                ],
                                                                image:
                                                                    const DecorationImage(
                                                                  image: AssetImage(
                                                                      "assets/images/catbackground.png"),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                      child:
                                                                          Text(
                                                                        languagee ==
                                                                                "en"
                                                                            ? getInntCategory_api.inntCategory[index].categoryEnglishName.toString()
                                                                            : getInntCategory_api.inntCategory[index].categoryFrenchName.toString(),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            A_style_mid_black,
                                                                        maxLines:
                                                                            3,
                                                                        textAlign:
                                                                            TextAlign.justify,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            20.0),
                                                                    child: Image
                                                                        .network(
                                                                      "$image_url${getInntCategory_api.inntCategory[index].categoryImage.toString()}",
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          7,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height /
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    : Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  blurRadius: 3)
                                                            ]),
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/camera.png",
                                                                height: h / 5,
                                                                width: w / 3,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: w / 70,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      w / 1.8,
                                                                  child: Text(
                                                                    "A product description is the marketing copy on each product page that explains what a product is and why a shopper should buy it. The purpose of a product description is to give your customers any important information about a product that they are interested in buying, along with any other reasons they should purchase the product.",
                                                                    maxLines: 7,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          "Amazon_med",
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Text(
                                                                  "\$33",
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        "Emebr_light",
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: h / 80),
                        widget.unkey == 2
                            ? GridView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const ScrollPhysics(),
                                // padding: EdgeInsets.all(4),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio:
                                      (MediaQuery.of(context).size.width / 1) /
                                          (MediaQuery.of(context).size.height /
                                              1.2),
                                ),
                                itemCount: homeapi.newarrivallist
                                    .elementAt(0)
                                    .data!
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(Product_deatils(
                                        sourceName: "0",
                                        subsubcateid: homeapi.newarrivallist
                                            .elementAt(0)
                                            .data!
                                            .elementAt(index)
                                            .productId,
                                        shopid: homeapi.newarrivallist
                                            .elementAt(0)
                                            .data!
                                            .elementAt(index)
                                            .venderId,
                                      ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade300,
                                                blurRadius: 3)
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                "$image_url${homeapi.newarrivallist.elementAt(0).data!.elementAt(index).image1}",
                                                fit: BoxFit.fitHeight,
                                                height: h / 5.7,
                                                width: w / 2,
                                              ),
                                            ),
                                            SizedBox(
                                              width: w,
                                              child: const Text(
                                                "Gopal fashion shop Gopal fashion shop",
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
                                                Text(
                                                  " Indore MadhyaPradesh",
                                                  style: A_style_mid,
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: h / 100,
                                            ),
                                            Text("11.4 km",
                                                style: A_style_mid_black),
                                            SizedBox(
                                              height: h / 100,
                                            ),
                                            Row(
                                              children: [
                                                // SizedBox(width: w/20,),
                                                Icon(Icons.star,
                                                    size: 18,
                                                    color:
                                                        Colors.yellow.shade800),
                                                Icon(Icons.star,
                                                    size: 18,
                                                    color:
                                                        Colors.yellow.shade800),
                                                Icon(Icons.star,
                                                    size: 18,
                                                    color:
                                                        Colors.yellow.shade800),
                                                Icon(Icons.star,
                                                    size: 18,
                                                    color:
                                                        Colors.yellow.shade800),
                                                Icon(Icons.star,
                                                    size: 18,
                                                    color:
                                                        Colors.yellow.shade800),
                                                SizedBox(
                                                  width: w / 50,
                                                ),
                                                Text("(356)",
                                                    style: TextStyle(
                                                        //letterSpacing: 1.5,
                                                        //color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors
                                                            .blue.shade800,
                                                        fontFamily:
                                                            "Amazon_med",
                                                        fontSize: 16)),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("10.5k sales",
                                                    style: A_style_mid_black),
                                                PopupMenuButton(
                                                  padding:
                                                      const EdgeInsets.all(0),
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
                                                                size: h / 27,
                                                                color: Colors
                                                                    .black),
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
                                                              Icons
                                                                  .report_problem_outlined,
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
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : widget.unkey == 7
                                ? GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics: const ScrollPhysics(),
                                    // padding: EdgeInsets.all(4),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: (MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1) /
                                          (MediaQuery.of(context).size.height /
                                              1.2),
                                    ),
                                    itemCount: homeapi.trendingNowList
                                        .elementAt(0)["data"]!
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(Product_deatils(
                                            sourceName: "0",
                                            conn: "0.0",
                                            subsubcateid: homeapi
                                                .trendingNowList
                                                .elementAt(0)["data"]!
                                                .elementAt(index)["productId"],
                                            shopid: homeapi.trendingNowList
                                                .elementAt(0)["data"]!
                                                .elementAt(index)["venderId"],
                                          ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    blurRadius: 3)
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    "$image_url${homeapi.trendingNowList.elementAt(0)["data"]!.elementAt(index)["image1"].toString()}",
                                                    fit: BoxFit.fitHeight,
                                                    height: h / 5.7,
                                                    width: w / 2,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w,
                                                  child: const Text(
                                                    "Gopal fashion shop Gopal fashion shop",
                                                    style: Big_A_style_medium,
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .location_solid,
                                                      size: 15,
                                                      color:
                                                          Colors.grey.shade500,
                                                    ),
                                                    Text(
                                                      " Indore MadhyaPradesh",
                                                      style: A_style_mid,
                                                      maxLines: 1,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h / 100,
                                                ),
                                                Text("11.4 km",
                                                    style: A_style_mid_black),
                                                SizedBox(
                                                  height: h / 100,
                                                ),
                                                Row(
                                                  children: [
                                                    // SizedBox(width: w/20,),
                                                    Icon(Icons.star,
                                                        size: 18,
                                                        color: Colors
                                                            .yellow.shade800),
                                                    Icon(Icons.star,
                                                        size: 18,
                                                        color: Colors
                                                            .yellow.shade800),
                                                    Icon(Icons.star,
                                                        size: 18,
                                                        color: Colors
                                                            .yellow.shade800),
                                                    Icon(Icons.star,
                                                        size: 18,
                                                        color: Colors
                                                            .yellow.shade800),
                                                    Icon(Icons.star,
                                                        size: 18,
                                                        color: Colors
                                                            .yellow.shade800),
                                                    SizedBox(
                                                      width: w / 50,
                                                    ),
                                                    Text("(356)",
                                                        style: TextStyle(
                                                            //letterSpacing: 1.5,
                                                            //color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors
                                                                .blue.shade800,
                                                            fontFamily:
                                                                "Amazon_med",
                                                            fontSize: 16)),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("10.5k sales",
                                                        style:
                                                            A_style_mid_black),
                                                    PopupMenuButton(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      color: Colors.white,
                                                      surfaceTintColor:
                                                          Colors.white,
                                                      initialValue:
                                                          selectedItem,
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
                                                                  height:
                                                                      h / 27,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const PopupMenuDivider(),
                                                          PopupMenuItem<String>(
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
                                                                    size:
                                                                        h / 27,
                                                                    color: Colors
                                                                        .black),
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
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 3)
                                        ]),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            "assets/images/camera.png",
                                            height: h / 5,
                                            width: w / 3,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          width: w / 70,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: w / 1.8,
                                              child: Text(
                                                "A product description is the marketing copy on each product page that explains what a product is and why a shopper should buy it. The purpose of a product description is to give your customers any important information about a product that they are interested in buying, along with any other reasons they should purchase the product.",
                                                maxLines: 7,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey.shade500,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Amazon_med",
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              "\$33",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Emebr_light",
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  var languagee;
  lll() async {
    print("hkhfhfff");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    languagee = prefs.get(LAGUAGE_CODE).toString();
    print("jklkljgljbgj $languagee");
    setState(() {});
  }
}
