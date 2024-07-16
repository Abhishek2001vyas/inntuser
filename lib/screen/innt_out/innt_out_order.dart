import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/chatall.dart';
import 'package:inntuser/screen/innt_out/order_detailsinntout.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../Controller/text2.dart';
import '../Users/order_details.dart';


class InntOutMyOrder extends StatelessWidget {
  const InntOutMyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(automaticallyImplyLeading: false,
          backgroundColor: secondryColor,centerTitle: true,
          title: const Text(
            "My Order",
          ),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: FutureBuilder(
              future: orderlist.orderlistinnout_api(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(color: logocolo),
                      )
                    : Obx(() => orderlist.OrderListlisttinntout.isEmpty
                        ? const Center(child: Text("No order"))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orderlist.OrderListlisttinntout.elementAt(0)
                                ["data"]!
                                .length,
                            itemBuilder: (context, index) {
                              var dataa =
                                  orderlist.OrderListlisttinntout.elementAt(0) ["data"]!;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade400,
                                            blurRadius: 2),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color: const Color(0xD7E2F1FF),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              "Order Id: ${dataa!.elementAt(index)["orderId"]}",
                                              style: const TextStyle(
                                                  color: Color(0xff1455ac),
                                                  fontSize: 17,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              maxLines: 2,
                                            )),
                                        SizedBox(
                                          height: h / 150,
                                        ),
                                        Text(
                                            "Order date: ${dataa.elementAt(index)["createdAt"]!.substring(0, 10)}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: A_style_order),
                                        SizedBox(
                                          height: h / 150,
                                        ),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: dataa
                                              .elementAt(index)
                                              ["products"]!
                                              .length,
                                          itemBuilder: (context, indexx) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                    OrderDetailsinnoutPage(
                                                        productid: dataa
                                                            .elementAt(index)
                                                            ["products"]!
                                                            .elementAt(indexx)
                                                            ["productId"],
                                                        orderid: dataa
                                                            .elementAt(index)
                                                            ["_id"],
                                                        orderno: dataa
                                                            .elementAt(index)
                                                            ["orderId"]),
                                                  );
                                                },
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.network(
                                                        "$image_url${dataa.elementAt(index)["products"]!.elementAt(indexx)["image"]}",
                                                        fit: BoxFit.fill,
                                                        height: h / 10,
                                                        width: w / 6,
                                                      ),
                                                      SizedBox(
                                                        width: w / 50,
                                                      ),
                                                      SizedBox(
                                                        width: w / 1.8,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                dataa
                                                                    .elementAt(
                                                                        index)
                                                                    ["products"]!
                                                                    .elementAt(
                                                                        indexx)
                                                                    ["product_name"]
                                                                    .toString(),
                                                                style:
                                                                    A_style_medium,
                                                                maxLines: 2),
                                                            SizedBox(
                                                              height: h / 200,
                                                            ),
                                                            /*Row(
                                                              children: [
                                                                Text("Size : ",
                                                                    style: TextStyle(
                                                                        //letterSpacing: 1.5,
                                                                        //color: Colors.white,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.black,
                                                                        fontFamily: "Amazon_med",
                                                                        fontSize: 15)),
                                                                Text(
                                                                  dataa
                                                                      .elementAt(
                                                                          index)
                                                                      ["products"]!
                                                                      .elementAt(
                                                                          indexx)
                                                                      .size
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          15,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                  maxLines: 2,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: h / 200,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text("Color : ",
                                                                    style: TextStyle(
                                                                        //letterSpacing: 1.5,
                                                                        //color: Colors.white,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.black,
                                                                        fontFamily: "Amazon_med",
                                                                        fontSize: 15)),
                                                                Text(
                                                                  dataa
                                                                      .elementAt(
                                                                          index)
                                                                      .products!
                                                                      .elementAt(
                                                                          indexx)
                                                                      .color
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          15,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                  maxLines: 2,
                                                                ),
                                                              ],
                                                            ),*/
                                                            // Container(
                                                            //   padding:
                                                            //   const EdgeInsets.all(4),
                                                            //   decoration: BoxDecoration(
                                                            //     borderRadius:
                                                            //     BorderRadius.circular(4),
                                                            //     color:
                                                            //     const Color(0xff1455ac),
                                                            //   ),
                                                            //   child:  Text(
                                                            //     "\$ ${dataa.elementAt(index).products!.elementAt(indexx).total}",
                                                            //     style: const TextStyle(
                                                            //         color: Colors.white,
                                                            //         fontSize: 17),
                                                            //   ),
                                                            // ),
                                                            SizedBox(
                                                              height: h / 80,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Icon(Icons
                                                            .keyboard_arrow_right),
                                                      ),
                                                      SizedBox(
                                                        height: h / 100,
                                                      ),
                                                    ]),
                                              ),
                                            );
                                          },
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(OrderDetailsPage(
                                              orderid:
                                                  dataa.elementAt(index).id,
                                            ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 10,
                                            ),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(() => const Chatall());
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.all(4),
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: logocolo)),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Icon(
                                                          Icons.chat,
                                                          color: logocolo,
                                                          size: 15,
                                                        ),
                                                        Text(
                                                          "Chat",
                                                          style: TextStyle(
                                                              color: logocolo,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),




                                                InkWell(
                                                  onTap: () {
                                                    //Get.to(() => QrScreen());
                                                  },
                                                  child: QrImageView(
                                                    data: dataa
                                                        .elementAt(index)
                                                        ["orderId"]
                                                        .toString(),
                                                    version: QrVersions.auto,
                                                    size: 40.0,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ));
              },
            )));

    /* SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade400, blurRadius: 2),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/shops.png",
                            height: h / 10,
                            width: w / 12,
                          ),
                          Container(
                            height: 1.5,
                            width: w / 3,
                            color: logocolo,
                          ),
                          Image.asset(
                            "assets/images/deliverytruck.png",
                            height: h / 10,
                            width: w / 12,
                          ),
                          Container(
                            height: 1.5,
                            width: w / 3.8,
                            color: Colors.grey,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                          ),
                          Image.asset(
                            "assets/images/homes.png",
                            height: h / 18,
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(4),
                          width: w / 4,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              Text("Cancel", style: A_style_text_inside_button)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h / 100,
                      ),
                      SizedBox(
                        height: h / 7,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: new_arrivalimage.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(const OrderDetailsPage());
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5.0, top: 5, left: 5),
                                  child: Container(
                                    height: h / 8,
                                    width: w / 5,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                            "assets/images/french.png",
                                            fit: BoxFit.cover)),
                                  )),
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const OrderDetailsPage());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order date: December 11, 2023",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: A_style_order),
                              Text("Shipped date: December 13, 2023",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: A_style_order),
                              Text("Order Id: 233890",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: A_style_order),
                              Text("Order amount: \$499",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: A_style_text_head2),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const OrderDetailsPage());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => Chatall());
                                },
                                child: Container(
                                  margin: EdgeInsets.all(4),
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: logocolo)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.chat,
                                        color: logocolo,
                                        size: 15,
                                      ),
                                      const Text(
                                        "Chat",
                                        style: TextStyle(
                                            color: logocolo,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: w / 080,
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: button_red_color)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: button_red_color,
                                      size: 15,
                                    ),
                                    const Text(
                                      "Review",
                                      style: TextStyle(
                                          color: button_red_color,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   width: w / 080,
                              // ),
                              // Container(
                              //   padding: const EdgeInsets.all(4),
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(5),
                              //       border: Border.all(
                              //         color: Colors.red.shade700,
                              //       )),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceAround,
                              //     children: [
                              //       Image.asset(
                              //         "assets/images/liveicon.png",
                              //         height: 15,
                              //         width: 15,
                              //         color: Colors.red.shade700,
                              //       ),
                              //       Text(
                              //         "innt live",
                              //         style: TextStyle(
                              //             color: Colors.red.shade700,
                              //             fontSize: 12,
                              //             fontWeight: FontWeight.w500),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                width: w / 080,
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: logocolo,
                                    )),
                                child: Text(
                                  "innt live",
                                  style: TextStyle(
                                      color: logocolo,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: w / 080,
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.black,
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      "assets/images/reorder.png",
                                      height: 15,
                                      width: 15,
                                    ),
                                    Text(
                                      "Order again",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: w / 20,
                              ),
                              InkWell(
                                onTap: () {
                                  //Get.to(() => QrScreen());
                                },
                                child: Icon(
                                  Icons.qr_code_2,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: h / 80,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade400, blurRadius: 2),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/shops.png",
                            height: h / 10,
                            width: w / 12,
                          ),
                          Container(
                            height: 1.5,
                            width: w / 3,
                            color: logocolo,
                          ),
                          Image.asset(
                            "assets/images/deliverytruck.png",
                            height: h / 10,
                            width: w / 12,
                          ),
                          Container(
                            height: 1.5,
                            width: w / 3.8,
                            color: Colors.grey,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                          ),
                          Image.asset(
                            "assets/images/homes.png",
                            height: h / 18,
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(4),
                          width: w / 4,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              Text("Cancel", style: A_style_text_inside_button)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h / 100,
                      ),
                      SizedBox(
                        height: h / 7,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: new_arrivalimage.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(const OrderDetailsPage());
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5.0, top: 5, left: 5),
                                  child: Container(
                                    height: h / 8,
                                    width: w / 5,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                            "assets/images/chicken.png",
                                            fit: BoxFit.cover)),
                                  )),
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const OrderDetailsPage());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order date: December 11, 2023",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: A_style_order),
                              Text("Shipped date: December 13, 2023",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: A_style_order),
                              Text("Order Id: 233890",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: A_style_order),
                              Text("Order amount: \$499",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: A_style_text_head2),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const OrderDetailsPage());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => Chatall());
                                },
                                child: Container(
                                  margin: EdgeInsets.all(4),
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: logocolo)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.chat,
                                        color: logocolo,
                                        size: 15,
                                      ),
                                      const Text(
                                        "Chat",
                                        style: TextStyle(
                                            color: logocolo,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: w / 080,
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: button_red_color)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: button_red_color,
                                      size: 15,
                                    ),
                                    const Text(
                                      "Review",
                                      style: TextStyle(
                                          color: button_red_color,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   width: w / 080,
                              // ),
                              // Container(
                              //   padding: const EdgeInsets.all(4),
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(5),
                              //       border: Border.all(
                              //         color: Colors.red.shade700,
                              //       )),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceAround,
                              //     children: [
                              //       Image.asset(
                              //         "assets/images/liveicon.png",
                              //         height: 15,
                              //         width: 15,
                              //         color: Colors.red.shade700,
                              //       ),
                              //       Text(
                              //         "innt live",
                              //         style: TextStyle(
                              //             color: Colors.red.shade700,
                              //             fontSize: 12,
                              //             fontWeight: FontWeight.w500),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                width: w / 080,
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: logocolo,
                                    )),
                                child: Text(
                                  "innt live",
                                  style: TextStyle(
                                      color: logocolo,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: w / 080,
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.black,
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      "assets/images/reorder.png",
                                      height: 15,
                                      width: 15,
                                    ),
                                    Text(
                                      "Order again",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: w / 20,
                              ),
                              InkWell(
                                onTap: () {
                                  // Get.to(() => QrScreen());
                                },
                                child: Icon(
                                  Icons.qr_code_2,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )));*/
  }
}
