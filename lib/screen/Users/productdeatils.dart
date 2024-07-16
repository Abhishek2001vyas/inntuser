import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:inntuser/Controller/button.dart';
import 'package:inntuser/firebase/deeplinking.dart';
import 'package:inntuser/screen/Users/Navgationbar.dart';
import 'package:inntuser/screen/Users/productreport.dart';
import 'package:inntuser/screen/Users/sellers/sellerdeatils.dart';
import 'package:inntuser/screen/Users/shopreport.dart';
import 'package:video_player/video_player.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../../Api/Addcart.dart';
import '../../Api/productlistbysubsubcat.dart';
import '../../Api/wishlist.dart';
import '../../Controller/dotscontroller.dart';
import '../../Controller/text2.dart';
import '../../ulits/constant.dart';
import 'cart_screen.dart';
import 'chatting.dart';

class Product_deatils extends StatefulWidget {
  final subsubcateid;
  final shopid;
  final conn;
  final sourceName;

  const Product_deatils(
      {super.key,
      this.subsubcateid,
      this.shopid,
      this.conn,
      required this.sourceName});

  @override
  State<Product_deatils> createState() => _Product_deatilsState();
}

class _Product_deatilsState extends State<Product_deatils> {
  late final _controller = ScrollController(initialScrollOffset: 0.0);
  final proddea = Get.put(fetchInntsubsubCategoryproductList());
  final wishl = Get.put(wishlist_api());
  final Addcart_api = Get.put(Addcart());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Addcart_api.selectedarr.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Product Details"),
          actions: [
            Obx(() => IconButton(
                  onPressed: () async {
                    await wishl.wishlike(
                      proddea.inntsubsubCateproddeta
                          .elementAt(0)["data"]
                          .elementAt(0)["productId"],
                      widget.shopid,
                    );
                    setState(() {});
                  },
                  icon: proddea.inntsubsubCateproddeta.isEmpty
                      ? const Icon(
                          CupertinoIcons.heart,
                        )
                      : proddea.inntsubsubCateproddeta
                                  .elementAt(0)["data"]!
                                  .elementAt(0)["like_status"] ==
                              1
                          ? const Icon(
                              CupertinoIcons.heart_solid,
                              color: Colors.pink,
                            )
                          : const Icon(
                              CupertinoIcons.heart,
                            ),
                ))
          ],
        ),
        body: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                FutureBuilder(
                    future: proddea.subsubcatprodeat(
                        widget.subsubcateid, widget.shopid),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (widget.conn != null) {
                        _controller.animateTo(
                          double.parse(widget.conn.toString()),
                          // Replace with your desired position
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.linear,
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(color: logocolo),
                        );
                      } else if (snapshot.hasError) {
                        return Text("No error  ${snapshot.error}");
                      } else {
                        return Obx(() => proddea
                                .inntsubsubCateproddeta.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Stack(
                                      children: [
                                        Obx(() => CarouselSlider.builder(
                                              itemCount: proddea
                                                  .inntsubsubCateproddeta
                                                  .elementAt(0)["data"]
                                                  .elementAt(0)["images"]!
                                                  .length,
                                              itemBuilder:
                                                  (context, index, realIndex) {
                                                var findvideo1 = proddea
                                                    .inntsubsubCateproddeta
                                                    .elementAt(0)["data"]
                                                    .elementAt(0)["images"]!
                                                    .elementAt(index)
                                                    .split('.')
                                                    .last
                                                    .toLowerCase();
                                                print("$findvideo1");

                                                return Center(
                                                  child: ClipRRect(
                                                      child: WidgetZoom(
                                                    heroAnimationTag: 'tag',
                                                    zoomWidget: findvideo1 ==
                                                                "mp4" ||
                                                            findvideo1 ==
                                                                "mov" ||
                                                            findvideo1 ==
                                                                "avi" ||
                                                            findvideo1 == "mkv"
                                                        ? Videospalyerinmessage(
                                                            videoslink:
                                                                "$image_url${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["images"]!.elementAt(index).toString()}")
                                                        : Image.network(
                                                            "$image_url${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["images"]!.elementAt(index).toString()}",
                                                            height: h / 1,
                                                            fit: BoxFit.fill,
                                                            // filterQuality: FilterQuality.low,
                                                          ),
                                                  )),
                                                );
                                              },
                                              options: CarouselOptions(
                                                onPageChanged: (index, reason) {
                                                  proddea
                                                      .changeindicator(index);
                                                },
                                                height: h / 2.2,
                                                enlargeCenterPage: true,
                                                autoPlay: true,
                                                aspectRatio: 15 / 20,
                                                autoPlayCurve:
                                                    Curves.fastOutSlowIn,
                                                autoPlayAnimationDuration:
                                                    const Duration(
                                                        milliseconds: 800),
                                                viewportFraction: 1,
                                              ),
                                            )),
                                        Obx(() => Positioned(
                                            bottom: 1,
                                            left: w / 5,
                                            right: w / 5,
                                            child: CustomIndicator(
                                              currentIndex:
                                                  proddea.currentindex.value,
                                              itemCount: proddea
                                                  .inntsubsubCateproddeta
                                                  .elementAt(0)["data"]
                                                  .elementAt(0)["images"]!
                                                  .length,
                                            )))
                                      ],
                                    ),
                                    Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              proddea.inntsubsubCateproddeta
                                                      .elementAt(0)["data"]
                                                      .elementAt(
                                                          0)["product_name"] ??
                                                  "NA",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Amazon_med",
                                              ),
                                            ),
                                            SizedBox(height: h / 100),
                                            AnimatedReadMoreText(
                                              "${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["description"] ?? "NA"}",
                                              maxLines: 4,
                                              // Set a custom text for the expand button. Defaults to Read more
                                              readMoreText: 'Read more +',
                                              // Set a custom text for the collapse button. Defaults to Read less
                                              readLessText: 'Read less -',
                                              // Set a custom text style for the main block of text
                                              textStyle: A_style_mid,
                                              // Set a custom text style for the expand/collapse button
                                              buttonTextStyle: const TextStyle(
                                                fontSize: 14,
                                                color: logocolo,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: h / 100),
                                            Row(
                                              children: [
                                                Text(
                                                    "${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["sale_price"] ?? 0}  CFA",
                                                    style: A_style_text_head2),
                                                Text(
                                                  "${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["mrp_price"] ?? 0} CFA",
                                                  style: const TextStyle(
                                                      //letterSpacing: 2.5,
                                                      //color: Colors.white,
                                                      color: Colors.grey,
                                                      fontFamily: "Amazon_bold",
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          Colors.grey,
                                                      fontSize: 20),
                                                ),
                                                proddea.inntsubsubCateproddeta
                                                            .elementAt(
                                                                0)["data"]
                                                            .elementAt(
                                                                0)["discount"]
                                                            .toString() ==
                                                        "0"
                                                    ? SizedBox()
                                                    : Text(
                                                        " (- ${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["discount"] ?? 0}  ${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["discountType"].toString() == "Percent off" ? "%" : "CFA"})",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .redAccent
                                                              .shade700,
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "Amazon_Medium",
                                                        ),
                                                      ),
                                                const Spacer(),
                                                PopupMenuButton(
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
                                                      PopupMenuItem<String>(
                                                        onTap: () {
                                                          Get.to(UserChat(
                                                            status: 1,
                                                            shopname: proddea
                                                                    .inntsubsubCateproddeta
                                                                    .elementAt(
                                                                        0)["data"]
                                                                [
                                                                0]["shop_name"],
                                                            venderid: proddea
                                                                    .inntsubsubCateproddeta
                                                                    .elementAt(
                                                                        0)["data"]
                                                                [0]["venderId"],
                                                            venderimage: proddea
                                                                    .inntsubsubCateproddeta
                                                                    .elementAt(
                                                                        0)["data"]
                                                                [
                                                                0]["shop_logo"],
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
                                                              "https://inntuser.page.link/productdeatils?productId=${widget.subsubcateid}&shopId=${widget.shopid}");
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
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const PopupMenuDivider(),
                                                      PopupMenuItem<String>(
                                                        onTap: () {
                                                          Get.to(Report(
                                                            productid: widget
                                                                .subsubcateid,
                                                            shopid:
                                                                widget.shopid,
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
                                            SizedBox(height: h / 100),
                                            Container(
                                              width: w / 3.5,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Colors.yellow.shade700,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // SizedBox(width: w/20,),
                                                  const Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color: white,
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      // int base = (raters ~/ 100) * 100; // Integer division to get the base value (e.g., 200 for 250)
                                                      // return "$base+";

                                                      proddea
                                                          .inntsubsubCateproddeta
                                                          .elementAt(0)["data"]
                                                          .elementAt(
                                                              0)["rating"]
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(width: w / 100),
                                                  Text(
                                                    double.parse(proddea
                                                                .inntsubsubCateproddeta
                                                                .elementAt(
                                                                    0)["data"]
                                                                .elementAt(0)[
                                                                    'total_rating']
                                                                .toString()) <
                                                            100
                                                        ? "(${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)['total_rating'].toString()})"
                                                        : " (${(double.parse(proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)['total_rating'].toString()) ~/ 100) * 100} +)",
                                                    //  "(${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)['total_rating']}+)",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: w,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Select",
                                                style: A_style_text_head2),
                                            SizedBox(
                                              height: h / 100,
                                            ),
                                            GridView.builder(
                                              itemBuilder: (context, index) {
                                                if (proddea
                                                    .inntsubsubCateproddeta
                                                    .elementAt(0)["data"]
                                                    .elementAt(0)["attributes"]!
                                                    .isEmpty) {
                                                  return const SizedBox();
                                                } else {
                                                  return Row(
                                                    children: [
                                                      Text(
                                                          "${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["attributes"][index]["attribute_name"]} : "),
                                                      Container(
                                                        height: h / 20,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 4),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black12,
                                                                width: 1)),
                                                        child: droo(
                                                          index: index,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              },
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: proddea
                                                  .inntsubsubCateproddeta
                                                  .elementAt(0)["data"]
                                                  .elementAt(0)["attributes"]
                                                  .length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio:
                                                    (MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            5) /
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25),
                                              ),
                                            ),
                                            SizedBox(
                                              width: w / 40,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: h / 100),
                                    Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(width: w / 10),
                                            Image.asset(
                                                "assets/images/fast-delivery.png",
                                                scale: 13),
                                            SizedBox(width: w / 30),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Delivery",
                                                    maxLines: 3,
                                                    textAlign: TextAlign.center,
                                                    style: A_style_text_head21),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                        "Expected time : ",
                                                        maxLines: 3,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            //letterSpacing: 1.5,
                                                            //color: Colors.white,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "Amazon_med",
                                                            fontSize: 14)),
                                                    Text(
                                                        "${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["delivery__time"]!}",
                                                        style: const TextStyle(
                                                            //letterSpacing: 1.5,
                                                            //color: Colors.white,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.green,
                                                            fontFamily:
                                                                "Amazon_med",
                                                            fontSize: 14)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                        "Fees          : ",
                                                        maxLines: 3,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            //letterSpacing: 1.5,
                                                            //color: Colors.white,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "Amazon_med",
                                                            fontSize: 14)),
                                                    Text(
                                                        "${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["delivery_fee"]!} CFA",
                                                        style: const TextStyle(
                                                            //letterSpacing: 1.5,
                                                            //color: Colors.white,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.green,
                                                            fontFamily:
                                                                "Amazon_med",
                                                            fontSize: 14)),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: h / 30,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(width: w / 10),
                                            Image.asset(
                                                "assets/images/exchange.png",
                                                scale: 13),
                                            SizedBox(width: w / 30),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Return policy",
                                                    maxLines: 3,
                                                    textAlign: TextAlign.center,
                                                    style: A_style_text_head21),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Obx(() => proddea
                                                            .inntsubsubCateproddeta
                                                            .elementAt(
                                                                0)["data"]
                                                            .elementAt(0)[
                                                                "returnType"]!
                                                            .elementAt(
                                                                0)["type"]
                                                            .toString() !=
                                                        "false"
                                                    ? Row(
                                                        children: [
                                                          const Text("Within",
                                                              maxLines: 3,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  //letterSpacing: 1.5,
                                                                  //color: Colors.white,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "Amazon_med",
                                                                  fontSize:
                                                                      14)),
                                                          SizedBox(
                                                              width: w / 50),
                                                          Text(
                                                              "${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["returnType"]!.elementAt(0)["value"] ?? 0}",
                                                              style: TextStyle(
                                                                  //letterSpacing: 1.5,
                                                                  //color: Colors.white,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .red
                                                                      .shade700,
                                                                  fontFamily:
                                                                      "Amazon_med",
                                                                  fontSize:
                                                                      14)),
                                                          SizedBox(
                                                              width: w / 50),
                                                          const Text("days",
                                                              maxLines: 3,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  //letterSpacing: 1.5,
                                                                  //color: Colors.white,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "Amazon_med",
                                                                  fontSize:
                                                                      14)),
                                                        ],
                                                      )
                                                    : const Row(
                                                        children: [
                                                          Text(
                                                              "No return accepted",
                                                              maxLines: 3,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  //letterSpacing: 1.5,
                                                                  //color: Colors.white,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .red,
                                                                  fontFamily:
                                                                      "Amazon_med",
                                                                  fontSize:
                                                                      14)),
                                                        ],
                                                      )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h / 100,
                                    ),
                                    Material(
                                      color: Colors.white,
                                      elevation: 1,
                                      child: Container(
                                        width: w,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Product Details",
                                                      style:
                                                          A_style_text_head2),
                                                ],
                                              ),
                                              SizedBox(
                                                height: h / 100,
                                              ),
                                              AnimatedReadMoreText(
                                                "Brand                 : ${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["brand_name"].toString()} \n"
                                                "warranty            : ${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["warranty"] ?? "None"} \n"
                                                "note                    : ${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["note"] ?? "None"} \n"
                                                "product weight : ${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["product_weight"].toString()} \n",
                                                maxLines: 3,

                                                // Set a custom text for the expand button. Defaults to Read more
                                                readMoreText: 'Read more +',
                                                // Set a custom text for the collapse button. Defaults to Read less
                                                readLessText: 'Read less -',
                                                // Set a custom text style for the main block of text
                                                textStyle: TextStyle(

                                                    //letterSpacing: 1.5,
                                                    //color: Colors.white,
                                                    color: Colors.grey.shade500,
                                                    fontFamily: "Amazon_med",
                                                    fontSize: 14),
                                                // Set a custom text style for the expand/collapse button
                                                buttonTextStyle:
                                                    const TextStyle(
                                                  fontSize: 14,
                                                  color: logocolo,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h / 100,
                                    ),
                                    Material(
                                      color: Colors.white,
                                      elevation: 1,
                                      child: Container(
                                        width: w,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              bottom: 15,
                                              top: 4),
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Sold By",
                                                  style: A_style_text_head2),
                                              SizedBox(
                                                height: h / 100,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(SellerDetails(
                                                    sourceName: "0",
                                                    shopanme: proddea
                                                        .inntsubsubCateproddeta
                                                        .elementAt(0)["data"]
                                                        .elementAt(
                                                            0)["shop_name"]
                                                        .toString(),
                                                    shopid: proddea
                                                        .inntsubsubCateproddeta
                                                        .elementAt(0)["data"]
                                                        .elementAt(
                                                            0)["venderId"]
                                                        .toString(),
                                                  ));
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    proddea.inntsubsubCateproddeta
                                                                    .elementAt(
                                                                        0)["data"]
                                                                    .elementAt(
                                                                        0)[
                                                                "shop_logo"] !=
                                                            null
                                                        ? CircleAvatar(
                                                            radius: 22,
                                                            backgroundImage:
                                                                NetworkImage(
                                                              "$image_url${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["shop_logo"]}",
                                                            ))
                                                        : const Text(
                                                            "No image"),
                                                    SizedBox(
                                                      width: w / 70,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(SellerDetails(
                                                          sourceName: "0",
                                                          shopanme: proddea
                                                              .inntsubsubCateproddeta
                                                              .elementAt(
                                                                  0)["data"]
                                                              .elementAt(0)[
                                                                  "shop_name"]
                                                              .toString(),
                                                          shopid: proddea
                                                              .inntsubsubCateproddeta
                                                              .elementAt(
                                                                  0)["data"]
                                                              .elementAt(
                                                                  0)["venderId"]
                                                              .toString(),
                                                        ));
                                                      },
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["shop_name"].toString()} ",
                                                              style:
                                                                  A_style_medium),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on,
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                              ),
                                                              SizedBox(
                                                                width: w / 2,
                                                                child: Text(
                                                                  "${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["shop_address"].toString()} ${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["shop_city"].toString()} ",
                                                                  style: TextStyle(
                                                                      //letterSpacing: 1.5,
                                                                      //color: Colors.white,
                                                                      color: Colors.grey.shade500,
                                                                      fontFamily: "Amazon_med",
                                                                      fontSize: 14),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    PopupMenuButton(
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
                                                            onTap: () {
                                                              Get.to(shopReport(
                                                                  productid: widget
                                                                      .subsubcateid,
                                                                  shopid: widget
                                                                      .shopid,
                                                                  status: 0));
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
                                              ),
                                              SizedBox(
                                                height: h / 80,
                                              ),
                                              IntrinsicHeight(
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: w / 3.5,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Rating",
                                                              style:
                                                                  A_style_mid_black,
                                                            ),
                                                            SizedBox(
                                                              height: h / 100,
                                                            ),
                                                            RatingBar.builder(
                                                              itemSize: 16,
                                                              initialRating: double.parse(proddea
                                                                  .inntsubsubCateproddeta
                                                                  .elementAt(
                                                                      0)["data"]
                                                                  .elementAt(0)[
                                                                      "average_rating"]
                                                                  .toString()),
                                                              minRating: 0,
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
                                                                Icons.star_rate,
                                                                color: Colors
                                                                    .yellow
                                                                    .shade800,
                                                              ),
                                                              onRatingUpdate:
                                                                  (double
                                                                      value) {},
                                                            ),
                                                            SizedBox(
                                                              height: h / 100,
                                                            ),
                                                            Text(
                                                              proddea
                                                                  .inntsubsubCateproddeta
                                                                  .elementAt(
                                                                      0)["data"]
                                                                  .elementAt(0)[
                                                                      "total_rater"]
                                                                  .toString(),
                                                              style:
                                                                  A_style_mid_black,
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
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Products",
                                                              style:
                                                                  A_style_mid_black,
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
                                                              proddea
                                                                  .inntsubsubCateproddeta
                                                                  .elementAt(
                                                                      0)["data"]
                                                                  .elementAt(0)[
                                                                      "total_product"]
                                                                  .toString(),
                                                              style:
                                                                  A_style_mid_black,
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
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Sales",
                                                              style:
                                                                  A_style_mid_black,
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
                                                              proddea
                                                                  .inntsubsubCateproddeta
                                                                  .elementAt(
                                                                      0)["data"]
                                                                  .elementAt(0)[
                                                                      "total_sale"]
                                                                  .toString(),
                                                              style:
                                                                  A_style_mid_black,
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
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Page views",
                                                              style:
                                                                  A_style_mid_black,
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
                                                              proddea
                                                                  .inntsubsubCateproddeta
                                                                  .elementAt(
                                                                      0)["data"]
                                                                  .elementAt(0)[
                                                                      "page__views"]
                                                                  .toString(),
                                                              style:
                                                                  A_style_mid_black,
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
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Liked items",
                                                              style:
                                                                  A_style_mid_black,
                                                            ),
                                                            SizedBox(
                                                              height: h / 100,
                                                            ),
                                                            const Icon(
                                                              Icons.favorite,
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              height: h / 100,
                                                            ),
                                                            Text(
                                                              proddea
                                                                  .inntsubsubCateproddeta
                                                                  .elementAt(
                                                                      0)["data"]
                                                                  .elementAt(0)[
                                                                      "liked__time"]
                                                                  .toString(),
                                                              style:
                                                                  A_style_mid_black,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: h / 70,
                                              ),
                                              // proddea.inntsubsubCateproddeta
                                              //         .elementAt(0)["data"]
                                              //         .elementAt(
                                              //             0)["reviews_list"]!
                                              //         .isNotEmpty
                                              //     ? Text(
                                              //         "More products customer reviews",
                                              //         style: A_style_text_head2)
                                              //     :
                                              Text("Reviews",
                                                  style: A_style_text_head2),
                                              SizedBox(
                                                height: h / 90,
                                              ),
                                              proddea.inntsubsubCateproddeta
                                                      .elementAt(0)["data"]
                                                      .elementAt(
                                                          0)["reviews_list"]!
                                                      .isNotEmpty
                                                  ? ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: proddea
                                                          .inntsubsubCateproddeta
                                                          .elementAt(0)["data"]
                                                          .elementAt(0)[
                                                              "reviews_list"]!
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return proddea
                                                                .inntsubsubCateproddeta
                                                                .elementAt(
                                                                    0)["data"]
                                                                .elementAt(0)[
                                                                    "reviews_list"]!
                                                                .isNotEmpty
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        h / 90,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      ProfilePicture(
                                                                        name:
                                                                            '',
                                                                        radius:
                                                                            11,
                                                                        fontsize:
                                                                            1,
                                                                        img:
                                                                            "$image_url${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["reviews_list"]!.elementAt(index)["user_image"].toString()}",
                                                                      ),
                                                                      SizedBox(
                                                                        width: w /
                                                                            90,
                                                                      ),
                                                                      Text(
                                                                        " ${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["reviews_list"]!.elementAt(index)["user_namef"].toString()}  ${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["reviews_list"]!.elementAt(index)["user_namel"].toString()}",
                                                                        style:
                                                                            A_style_mid_black,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        h / 100,
                                                                  ),
                                                                  RatingBar
                                                                      .builder(
                                                                    itemSize:
                                                                        20,
                                                                    initialRating: double.parse(proddea
                                                                        .inntsubsubCateproddeta
                                                                        .elementAt(0)[
                                                                            "data"]
                                                                        .elementAt(0)[
                                                                            "reviews_list"]!
                                                                        .elementAt(
                                                                            index)["rating"]
                                                                        .toString()),
                                                                    minRating:
                                                                        0,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    allowHalfRating:
                                                                        true,
                                                                    itemCount:
                                                                        5,
                                                                    ignoreGestures:
                                                                        true,
                                                                    itemPadding: const EdgeInsets
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
                                                                  SizedBox(
                                                                    height:
                                                                        h / 90,
                                                                  ),
                                                                  RichText(
                                                                    text: TextSpan(
                                                                        text:
                                                                            "Comment : ",
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold),
                                                                        children: [
                                                                          TextSpan(
                                                                              text: " ${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["reviews_list"]!.elementAt(index)["comment"].toString()}",
                                                                              style: const TextStyle(color: Colors.grey))
                                                                        ]),
                                                                  )
                                                                ],
                                                              )
                                                            : const Center(
                                                                child: Text(
                                                                    "No Reviews"));
                                                      })
                                                  : const Text("No Reviews"),
                                              SizedBox(
                                                height: h / 90,
                                              ),
                                              proddea.inntsubsubCateproddeta
                                                      .elementAt(0)["data"]
                                                      .elementAt(
                                                          0)["reviews_list"]!
                                                      .isNotEmpty
                                                  ? const Center(
                                                      child: Text(
                                                        "See more reviews",
                                                        style: TextStyle(
                                                            //letterSpacing: 2,
                                                            //color: Colors.white,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 18),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              SizedBox(
                                                height: h / 90,
                                              ),
                                              Text("More products on the shop",
                                                  style: A_style_text_head2),
                                              SizedBox(
                                                height: h / 90,
                                              ),
                                              proddea.inntsubsubCateproddeta
                                                      .elementAt(0)["data"]
                                                      .elementAt(
                                                          0)["moreproducts"]!
                                                      .isNotEmpty
                                                  ? GridView.builder(
                                                      itemBuilder:
                                                          (context, indexx) {
                                                        return proddea
                                                                .inntsubsubCateproddeta
                                                                .elementAt(
                                                                    0)["data"]
                                                                .elementAt(0)[
                                                                    "moreproducts"]!
                                                                .isNotEmpty
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  print(
                                                                      "fgfgfffddfrfdhrhfd");
                                                                  // Get.to(() => Product_deatils(
                                                                  //   shopid:          proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["moreproducts"][indexx]["shopId"].toString() ,
                                                                  //   subsubcateid:   proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["moreproducts"][indexx]["shopId"]['productId'].toString(),));
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius: BorderRadius.circular(8),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color:
                                                                                Colors.grey.shade300,
                                                                            blurRadius: 5)
                                                                      ]),
                                                                  child: Center(
                                                                      child: Image
                                                                          .network(
                                                                    "$image_url${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["moreproducts"]!.elementAt(indexx)["image"].toString()}",
                                                                    width:
                                                                        w / 5,
                                                                    height:
                                                                        h / 9,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )),
                                                                ),
                                                              )
                                                            : const Text(
                                                                "No product");
                                                      },
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: proddea
                                                          .inntsubsubCateproddeta
                                                          .elementAt(0)["data"]
                                                          .elementAt(0)[
                                                              "moreproducts"]!
                                                          .length,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 8,
                                                        mainAxisSpacing: 8,
                                                        childAspectRatio: MediaQuery
                                                                    .of(context)
                                                                .size
                                                                .width /
                                                            (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                1.7),
                                                      ),
                                                    )
                                                  : const Text("No product"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])
                            : const SizedBox());
                      }
                    }),
              ],
            )),
        bottomNavigationBar: Obx(
          () => proddea.inntsubsubCateproddeta.isEmpty
              ? const SizedBox()
              : proddea.inntsubsubCateproddeta
                          .elementAt(0)["data"]
                          .elementAt(0)["cart_status"]
                          .toString() ==
                      "1"
                  ? Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      color: Colors.grey.shade100,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: buttonPrimary,
                            onPressed: () async {
                              setState(() {
                                currentTab = 3;
                              });
                              Get.offAll(const DashBoardScreen());
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_bag,
                                    color: Colors.white, size: 20),
                                Text(" Go To Bag",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "Amazon_bold")),
                              ],
                            )),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      color: Colors.grey.shade100,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: buttonPrimary,
                            onPressed: () async {
                              await Addcart_api.Addcartinnt(
                                  proddea.inntsubsubCateproddeta
                                      .elementAt(0)["data"]
                                      .elementAt(0)["productId"]
                                      .toString(),
                                  widget.sourceName.toString());
                              setState(() {});
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_bag,
                                    color: Colors.white, size: 20),
                                Text(" Add To Bag",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "Amazon_bold")),
                              ],
                            )),
                      ),
                    ),
        ));
  }

  void kik() {
    Addcart_api.selectedarr.clear();
  }
}

void fffg(int index) {
  final proddea1 = Get.put(fetchInntsubsubCategoryproductList());
  if (proddea1.inntsubsubCateproddeta
      .elementAt(0)["data"]
      .elementAt(0)["attributes"]!
      .isNotEmpty) {
    cartlist.selectedarr.add({
      "name": proddea1.inntsubsubCateproddeta
          .elementAt(0)["data"]
          .elementAt(0)["attributes"][index]["attribute_name"]
          .toString(),
      "value": proddea1.inntsubsubCateproddeta[0]["data"][0]["attributes"]
              [index]["attribute_values"][0]
          .toString(),
    });
  }
}

class droo extends StatefulWidget {
  final index;

  const droo({super.key, this.index});

  @override
  State<droo> createState() => _drooState();
}

class _drooState extends State<droo> {
  final proddea = Get.put(fetchInntsubsubCategoryproductList());
  final wishl = Get.put(wishlist_api());
  final Addcart_api = Get.put(Addcart());

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: const SizedBox(),
      hint: Text(
          "Select ${proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["attributes"][widget.index]["attribute_name"]}"),
      value: Addcart_api.selectedarr[widget.index]["value"].toString(),
      items: (proddea.inntsubsubCateproddeta[0]["data"][0]["attributes"]
              [widget.index]["attribute_values"] as List<dynamic>)
          .map<DropdownMenuItem<String>>((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item, style: const TextStyle(fontSize: 12)),
        );
      }).toList(),
      onChanged: (newValue) {
        Addcart_api.selectedarr[widget.index]["value"] = newValue.toString();
        setState(() {});

        /* var inn=Addcart_api.selectedarr .indexWhere((element) =>element["attribute_name"] ==
                                                    proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["attributes"][index] ["attribute_name"]);
                                                if (inn != -1 )
                                                {
                                                  Addcart_api.selectedarr[inn]["attribute_values"]=newValue;
                                                }
                                                else {
                                                  Addcart_api.selectedarr
                                                      .add({
                                                    "attribute_name":proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["attributes"][index] ["attribute_name"].toString(),
                                                    "attribute_values": newValue,
                                                  });
                                                }*/
        print("ggdsd ${Addcart_api.selectedarr}");

        // gggg = newValue!;
      },
    );
  }
}

class Videospalyerinmessage extends StatefulWidget {
  final videoslink;

  const Videospalyerinmessage({super.key, this.videoslink});

  @override
  State<Videospalyerinmessage> createState() => _VideospalyerinmessageState();
}

class _VideospalyerinmessageState extends State<Videospalyerinmessage> {
  late VideoPlayerController _controller1;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller1 = VideoPlayerController.network(widget.videoslink);
    _initializeVideoPlayerFuture = _controller1.initialize().then((value) {
      _controller1.play();

      setState(() {});
      _controller1.addListener(_videoListener);
    });
  }

  void _videoListener() {
    if (_controller1.value.isPlaying) {}
  }

  @override
  void dispose() {
    super.dispose();

    _controller1.pause();
    _controller1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                width: w,
                height: h,
                child: VideoPlayer(_controller1),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
