import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:inntuser/Controller/button.dart';
import 'package:inntuser/screen/innt_out/productreport.dart';
import 'package:inntuser/screen/innt_out/shopreportinntout.dart';

import '../../Api/Addcart.dart';
import '../../Api/innoutaddcart.dart';
import '../../Api/inntoutproductlist.dart';
import '../../Api/wishlist.dart';
import '../../Controller/dotscontroller.dart';
import '../../Controller/text2.dart';
import '../../ulits/constant.dart';
import '../Users/chatting.dart';
import 'dashboardinntout.dart';

class InntoutProduct_deatils extends StatefulWidget {
  final subsubcateid;
  final shopid;

  const InntoutProduct_deatils({super.key, this.subsubcateid, this.shopid});

  @override
  State<InntoutProduct_deatils> createState() => _InntoutProduct_deatilsState();
}

class _InntoutProduct_deatilsState extends State<InntoutProduct_deatils> {
  String selectedItem = 'Delete item';

  final proddea = Get.put(InntOutproductlist());
  final wishl = Get.put(wishlist_api());
  final Addcartinntout_api = Get.put(Addcart());
  final Addcartinntout1_api = Get.put(Inntoutaddcard());

  @override
  void dispose() {
    // TODO: implement dispose
    Addcartinntout1_api.selectedarr.clear();

    super.dispose();
  }

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
            child: const Icon(Icons.arrow_back_ios)),
        backgroundColor: secondryColor,
        centerTitle: true,
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder(
              future:
                  proddea.inntOutprodeat(widget.subsubcateid, widget.shopid),
              builder: (context, snapshot) {
                // Addcartinntout1_api.selectedarr.clear();
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(color: secondryColor),
                      )
                    : snapshot.hasError
                        ? Center(
                            child: Text("No data ${snapshot.error}"),
                          )
                        : proddea.inntOutproddeta.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Stack(
                                      children: [
                                        Obx(() => CarouselSlider.builder(
                                              itemCount: proddea.inntOutproddeta
                                                  .elementAt(0)["data"][0]
                                                      ["images"]
                                                  .length,
                                              itemBuilder:
                                                  (context, index, realIndex) =>
                                                      Center(
                                                child: ClipRRect(
                                                    child: Image.network(
                                                  "$image_url${proddea.inntOutproddeta.elementAt(0)["data"][0]["images"].elementAt(index).toString()}",
                                                  height: h / 1,
                                                  fit: BoxFit.fill,
                                                  // filterQuality: FilterQuality.low,
                                                )),
                                              ),
                                              options: CarouselOptions(
                                                onPageChanged: (index, reason) {
                                                  proddea
                                                      .changeindicator(index);
                                                  // setState(() {
                                                  //   currentindex = index;
                                                  // });
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
                                            left: w / 2.5,
                                            child: CustomIndicator(
                                              currentIndex:
                                                  proddea.currentindex.value,
                                              itemCount: proddea.inntOutproddeta
                                                  .elementAt(0)["data"][0]
                                                      ["images"]
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
                                              proddea.inntOutproddeta
                                                  .elementAt(0)["data"][0]
                                                      ["product_name"]
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Amazon_med",
                                              ),
                                            ),
                                            SizedBox(height: h / 100),
                                            AnimatedReadMoreText(
                                              proddea.inntOutproddeta
                                                  .elementAt(0)["data"][0]
                                                      ["description"]
                                                  .toString(),
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
                                                color: secondryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            /*  Text(
                                  "${proddea.inntOutproddeta.elementAt(0).data!.elementAt(0).description!.toString()}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      fontFamily: "Ember_Light")),*/
                                            SizedBox(height: h / 100),
                                            Row(
                                              children: [
                                                Text(
                                                    "${proddea.inntOutproddeta.elementAt(0)["data"][0]["sale_price"] ?? 0}  CFA",
                                                    style: A_style_text_head2),
                                                Text(
                                                  "${proddea.inntOutproddeta.elementAt(0)["data"][0]["mrp_price"] ?? 0} CFA",
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
                                                Text(
                                                  " (- ${proddea.inntOutproddeta.elementAt(0)["data"][0]["discount"] ?? 0}   ${proddea.inntOutproddeta.elementAt(0)["data"][0]["discountType"].toString() == "Percent off" ? "%" : "CFA"})",
                                                  style: TextStyle(
                                                    color: Colors
                                                        .redAccent.shade700,
                                                    fontSize: 20,
                                                    fontFamily: "Amazon_Medium",
                                                  ),
                                                ),
                                                const Spacer(),
                                                PopupMenuButton(
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
                                                        onTap: () {
                                                          Get.to(UserChat(
                                                            status: 1,
                                                            shopname: proddea
                                                                    .inntOutproddeta
                                                                    .elementAt(
                                                                        0)["data"]
                                                                [
                                                                0]["shop_name"],
                                                            venderid: proddea
                                                                    .inntOutproddeta
                                                                    .elementAt(
                                                                        0)["data"]
                                                                [0]["venderId"],
                                                            venderimage: proddea
                                                                    .inntOutproddeta
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
                                                          Get.to(
                                                              Reportinntout());
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
                                                      proddea.inntOutproddeta
                                                          .elementAt(0)["data"]
                                                              [0]["rating"]
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
                                                    "(${proddea.inntOutproddeta.elementAt(0)["data"][0]["total_rating"]}+)",
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
                                                        "${proddea.inntOutproddeta.elementAt(0)["data"][0]["delivery__time"]!}",
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
                                                    const Text("Fees : ",
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
                                                        "${proddea.inntOutproddeta.elementAt(0)["data"][0]["delivery_fee"]!} CFA",
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
                                      ],
                                    ),
                                    SizedBox(
                                      height: h / 100,
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
                                            Wrap(
                                              runSpacing: 10,
                                              children: [
                                                GridView.builder(
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (proddea.inntOutproddeta
                                                        .elementAt(0)["data"][0]
                                                            ["attributes"]!
                                                        .isEmpty) {
                                                      return const SizedBox();
                                                    } else {
                                                      return Row(
                                                        children: [
                                                          Text(
                                                              "${proddea.inntOutproddeta.elementAt(0)["data"][0]["attributes"][index]["attribute_name"]} : "),
                                                          Container(
                                                            height: h / 20,
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 4),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 1)),
                                                            child: drooop(
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
                                                      .inntOutproddeta
                                                      .elementAt(0)["data"][0]
                                                          ["attributes"]
                                                      .length,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                5) /
                                                            (MediaQuery.of(
                                                                        context)
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
                                          ],
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
                                                "note : ${proddea.inntOutproddeta.elementAt(0)["data"][0]["note"].toString()} \n"
                                                "weight : ${proddea.inntOutproddeta.elementAt(0)["data"][0]["product_weight"].toString()} \n"
                                                //
                                                ,
                                                maxLines: 3,
                                                // Set a custom text for the expand button. Defaults to Read more
                                                readMoreText: 'Read more +',
                                                // Set a custom text for the collapse button. Defaults to Read less
                                                readLessText: 'Read less -',
                                                // Set a custom text style for the main block of text
                                                textStyle: A_style_mid,
                                                // Set a custom text style for the expand/collapse button
                                                buttonTextStyle:
                                                    const TextStyle(
                                                  fontSize: 14,
                                                  color: secondryColor,
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
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 22,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      "$image_url${proddea.inntOutproddeta.elementAt(0)["data"][0]["shop_logo"]}",
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
                                                      Text(
                                                          "${proddea.inntOutproddeta.elementAt(0)["data"][0]["shop_name"].toString()} ",
                                                          style:
                                                              A_style_medium),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            color: Colors
                                                                .grey.shade400,
                                                          ),
                                                          SizedBox(
                                                            width: w / 2,
                                                            child: Text(
                                                              "${proddea.inntOutproddeta.elementAt(0)["data"][0]["shop_address"].toString()} ${proddea.inntOutproddeta.elementAt(0)["data"][0]["shop_city"].toString()} ",
                                                              style:
                                                                  A_style_mid,
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
                                                  const Spacer(),
                                                  PopupMenuButton(
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
                                                          onTap: () {
                                                            Get.to(
                                                                shopReportinntout());
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
                                                                  .inntOutproddeta
                                                                  .elementAt(0)[
                                                                      "data"][0]
                                                                      [
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
                                                                  .inntOutproddeta
                                                                  .elementAt(0)[
                                                                      "data"][0]
                                                                      [
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
                                                                  .inntOutproddeta
                                                                  .elementAt(0)[
                                                                      "data"][0]
                                                                      [
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
                                                                  .inntOutproddeta
                                                                  .elementAt(0)[
                                                                      "data"][0]
                                                                      [
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
                                                                  .inntOutproddeta
                                                                  .elementAt(0)[
                                                                      "data"][0]
                                                                      [
                                                                      "page__views"]
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
                                              Text("Reviews",
                                                  style: A_style_text_head2),
                                              SizedBox(
                                                height: h / 70,
                                              ),
                                              proddea.inntOutproddeta
                                                      .elementAt(0)["data"]
                                                      .elementAt(
                                                          0)["reviewsList"]!
                                                      .isNotEmpty
                                                  ? ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: proddea
                                                          .inntOutproddeta
                                                          .elementAt(0)["data"]
                                                          .elementAt(
                                                              0)["reviewsList"]!
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return proddea
                                                                .inntOutproddeta
                                                                .elementAt(
                                                                    0)["data"]
                                                                .elementAt(0)[
                                                                    "reviewsList"]!
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
                                                                            "$image_url${proddea.inntOutproddeta.elementAt(0)["data"].elementAt(0)["reviewsList"]!.elementAt(index)["user_image"].toString()}",
                                                                      ),
                                                                      SizedBox(
                                                                        width: w /
                                                                            90,
                                                                      ),
                                                                      Text(
                                                                        " ${proddea.inntOutproddeta.elementAt(0)["data"].elementAt(0)["reviewsList"]!.elementAt(index)["user_namef"].toString()}  ${proddea.inntOutproddeta.elementAt(0)["data"].elementAt(0)["reviewsList"]!.elementAt(index)["user_namel"].toString()}",
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
                                                                        .inntOutproddeta
                                                                        .elementAt(0)[
                                                                            "data"]
                                                                        .elementAt(0)[
                                                                            "reviewsList"]!
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
                                                                              text: " ${proddea.inntOutproddeta.elementAt(0)["data"].elementAt(0)["reviewsList"]!.elementAt(index)["comment"].toString()}",
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
                                              proddea.inntOutproddeta
                                                      .elementAt(0)["data"]
                                                      .elementAt(
                                                          0)["reviewsList"]!
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
                                              proddea.inntOutproddeta
                                                      .elementAt(0)["data"]
                                                      .elementAt(
                                                          0)["moreproducts"]!
                                                      .isNotEmpty
                                                  ? GridView.builder(
                                                      itemBuilder:
                                                          (context, indexx) {
                                                        return proddea
                                                                .inntOutproddeta
                                                                .elementAt(
                                                                    0)["data"]
                                                                .elementAt(0)[
                                                                    "moreproducts"]!
                                                                .isNotEmpty
                                                            ? GestureDetector(
                                                                onTap: () {},
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
                                                                    "$image_url${proddea.inntOutproddeta.elementAt(0)["data"].elementAt(0)["moreproducts"]!.elementAt(indexx)["image"].toString()}",
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
                                                          .inntOutproddeta
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
                            : const SizedBox();
              })),
      bottomNavigationBar: Obx(() => proddea.inntOutproddeta.isEmpty
          ? const SizedBox()
          : proddea.inntOutproddeta
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
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(400, 50),
                            backgroundColor: secondryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () async {
                          setState(() {
                            selectedindex = 1;
                          });
                          Get.offAll(const DashboardInntOut());
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
                        style: buttonPrimary1,
                        onPressed: () async {
                          await Addcartinntout1_api.Inntout_addcard(
                              proddea.inntOutproddeta
                                  .elementAt(0)["data"][0]["productId"]
                                  .toString(),
                              proddea.inntOutproddeta
                                  .elementAt(0)["data"][0]["productSize"]
                                  .toString());
                          //  await Addcartinntout_api.Addcartinntout(proddea.inntOutproddeta.elementAt(0)["data"][0]["productId"].toString());
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
                )),
    );
  }
}

class drooop extends StatefulWidget {
  final index;
  const drooop({super.key, this.index});

  @override
  State<drooop> createState() => _drooopState();
}

class _drooopState extends State<drooop> {
  final proddea = Get.put(InntOutproductlist());
  final wishl = Get.put(wishlist_api());
  final Addcart_api = Get.put(Addcart());
  final Addcartinntout1_api = Get.put(Inntoutaddcard());
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    print("sdfopsjgjvo ${Addcartinntout1_api.selectedarr.toString()}");
    return SizedBox(
      width: w / 4,
      child: DropdownButton(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(
            "Select ${proddea.inntOutproddeta.elementAt(0)["data"][0]["attributes"][widget.index]["attribute_name"]}"),
        value: Addcartinntout1_api.selectedarr[widget.index]["value"],
        items: (proddea.inntOutproddeta[0]["data"][0]["attributes"]
                [widget.index]["attribute_values"] as List<dynamic>)
            .map<DropdownMenuItem<String>>((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item, style: const TextStyle(fontSize: 10)),
          );
        }).toList(),
        onChanged: (newValue) {
          Addcartinntout1_api.selectedarr[widget.index]["value"] =
              newValue.toString();
          setState(() {});

          print("ggdsd ${Addcartinntout1_api.selectedarr}");

          // gggg = newValue!;
        },
      ),
    );
  }
}
