import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:inntuser/Api/addressList_api.dart';
import 'package:inntuser/screen/Users/returnorder.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../../Controller/controller.dart';
import '../../Api/Addcart.dart';
import '../../Api/orderplaced_api.dart';
import '../../Controller/text2.dart';
import '../../main.dart';
import 'Navgationbar.dart';
import 'Reviewgiveinorder.dart';
import 'cart_screen.dart';
import 'chatting.dart';
import 'myorder.dart';

final orderlist = Get.put(orderplaced());

class OrderDetailsPage extends StatefulWidget {
  final orderid;
  final orderno;
  final productid;

  const OrderDetailsPage({
    super.key,
    this.orderid,
    this.orderno,
    this.productid,
  });

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  List<StepData> steps = [
    StepData(
      title: 'Order Placed',
      date: 'jan 23,2023',
    ),
    StepData(
      title: 'Confirmed',
      date: 'jan 24,2023',
    ),
    StepData(
      title: 'Packing',
      date: 'jan 25,2023',
    ),
    StepData(
      title: 'Shipped',
      date: 'jan 27,2023',
    ),
    StepData(
      title: 'Delivered',
      date: 'jan 28 ,2023',
    ),
    // StepData(
    //   title: 'Cancel',
    //   date: 'jan 28 ,2023',
    // ),
  ];

  final Addcart_api = Get.put(Addcart());

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          "Order ID: ${widget.orderno}",
          style: const TextStyle(fontSize: 14),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: FutureBuilder(
            future: orderlist.orderlistdeatils_api(
                widget.orderid, widget.productid),
            builder: (context, snapshot) {
              other_products=0.0;
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(color: logocolo),
                    )
                  : orderlist.Orderdeatilslistt.isEmpty
                      ? const Center(child: Text("No order deatils"))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: h / 50,
                            ),
                            Text("Product Details",
                                style: TextStyle(
                                    //letterSpacing: 2.5,
                                    //color: Colors.white,
                                    color: darkomdee.darkomde == true
                                        ? Colors.white
                                        : Colors.grey.shade900,
                                    fontFamily: "Amazon_bold",
                                    fontSize: 20)),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                  color: darkomdee.darkomde == true
                                      ? Colors.black
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        blurRadius: 5)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      "$image_url${orderlist.Orderdeatilslistt[0]["data"]["products"]["image"]}",
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width: w / 2,
                                                  child: Text(
                                                      "${orderlist.Orderdeatilslistt[0]["data"]["products"]["product_name"]}",
                                                      style: TextStyle(
                                                          color: darkomdee
                                                                      .darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight
                                                              .w600))),
                                              Text(
                                                "Qty:${orderlist.Orderdeatilslistt[0]["data"]["products"]["qty"]} ",
                                                style: TextStyle(
                                                    //letterSpacing: 1.5,
                                                    //color: Colors.white,
                                                    color: darkomdee.darkomde ==
                                                            true
                                                        ? Colors.white
                                                        : Colors.grey.shade700,
                                                    fontFamily: "Amazon_med",
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                width: w / 3,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: orderlist
                                                      .Orderdeatilslistt[0]
                                                          ["data"]["products"]
                                                          ["attributes"]
                                                      .length,
                                                  itemBuilder:
                                                      (context, indext) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Text(
                                                        "${orderlist.Orderdeatilslistt[0]["data"]["products"]["attributes"][indext]["name"]}: ${orderlist.Orderdeatilslistt[0]["data"]["products"]["attributes"][indext]["value"]} ",
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
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h / 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    cartlist.selectedarr.clear();
                                    cartlist.selectedarr.value = orderlist
                                        .Orderdeatilslistt[0]["data"]
                                            ["products"]["attributes"]
                                        .map((attribute) {
                                      var newAttribute = Map.from(attribute);
                                      print("jgjoggj $newAttribute");
                                      newAttribute.remove('_id');
                                      return newAttribute;
                                    }).toList();
                                    await Addcart_api.orderagain(
                                      orderlist.Orderdeatilslistt[0]["data"]
                                              ["products"]["productId"]
                                          .toString(),
                                      orderlist.Orderdeatilslistt[0]["data"]
                                              ["products"]["qty"]
                                          .toString(),
                                    );
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: w / 4,
                                    padding: const EdgeInsets.all(10),
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
                                        const Text(
                                          "Order again",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(UserChat(
                                      status: 1,
                                      shopname: orderlist.Orderdeatilslistt[0]
                                          ["data"]["shop_name"],
                                      venderid: orderlist.Orderdeatilslistt[0]
                                          ["data"]["shopId"],
                                      venderimage:
                                          orderlist.Orderdeatilslistt[0]["data"]
                                              ["shop_image"],
                                    ));
                                    // Get.to(() => Chatall());
                                  },
                                  child: Container(
                                    width: w / 4,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: logocolo)),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                orderlist.Orderdeatilslistt[0]["data"]
                                                ["products"]["order_status"]
                                            .toString() ==
                                        "4" && orderlist.Orderdeatilslistt[0]["return_status"].toString()=="0"
                                    ? InkWell(
                                        onTap: () {
                                          // Get.to(UserChat(
                                          //   shopname: orderlist.Orderdeatilslistt[0]["data"]["shop_name"],
                                          //   venderid: orderlist.Orderdeatilslistt[0]["data"]["shopId"],
                                          //   venderimage:orderlist.Orderdeatilslistt[0]["data"]["shop_image"],
                                          // ));
                                          Get.to(() => Return(
                                                orderid: widget.orderid,
                                                productid: widget.productid,
                                                shopid: orderlist
                                                        .Orderdeatilslistt[0]
                                                    ["data"]["shopId"],
                                              ));
                                        },
                                        child: Container(
                                          width: w / 4,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border:
                                                  Border.all(color: logocolo)),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(
                                                CupertinoIcons.return_icon,
                                                color: logocolo,
                                                size: 15,
                                              ),
                                              Text(
                                                "Return",
                                                style: TextStyle(
                                                    color: logocolo,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                            SizedBox(
                              height: h / 50,
                            ),
                            Text("Review",
                                style: TextStyle(
                                    //letterSpacing: 2.5,
                                    //color: Colors.white,
                                    color: darkomdee.darkomde == true
                                        ? Colors.white
                                        : Colors.grey.shade900,
                                    fontFamily: "Amazon_bold",
                                    fontSize: 20)),
                            SizedBox(
                              height: h / 80,
                            ),
                            Material(
                              color: Colors.white,
                              elevation: 1,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  color: darkomdee.darkomde == true
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RatingBar.builder(
                                      itemSize: 30,
                                      initialRating: orderlist
                                                      .Orderdeatilslistt[0]
                                                  ["data"]["rating"] !=
                                              0
                                          ? double.parse(
                                              orderlist.Orderdeatilslistt[0]
                                                  ["data"]["rating"]["rating"])
                                          : 0.0,
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      unratedColor: darkomdee.darkomde == true
                                          ? Colors.white
                                          : Colors.grey,
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
                                    IconButton(
                                        onPressed: () {
                                          Get.to(Reviewgive(
                                            productid: widget.productid,
                                            orderno: widget.orderno,
                                            orderid: widget.orderid,
                                            shopid:
                                                orderlist.Orderdeatilslistt[0]
                                                    ["data"]["shopId"],
                                          ));
                                        },
                                        icon: Icon(Icons.keyboard_arrow_right,
                                            color: darkomdee.darkomde == true
                                                ? Colors.white
                                                : Colors.black))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("Order Tracking",
                                  style: TextStyle(
                                      //letterSpacing: 2.5,
                                      //color: Colors.white,
                                      color: darkomdee.darkomde == true
                                          ? Colors.white
                                          : Colors.grey.shade900,
                                      fontFamily: "Amazon_bold",
                                      fontSize: 20)),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: steps.length,
                              itemBuilder: (context, index) {
                                int selectedIndex = orderlist
                                                .Orderdeatilslistt[0]["data"]
                                                    ["products"]["order_status"]
                                                .toString() ==
                                            "0"
                                        ? 0
                                        : orderlist.Orderdeatilslistt[0]["data"]["products"]["order_status"].toString() ==
                                                "2"
                                            ? 1
                                            : orderlist.Orderdeatilslistt[0]
                                                            ["data"]["products"]
                                                            ["order_status"]
                                                        .toString() ==
                                                    "4"
                                                ? 3
                                                : orderlist.Orderdeatilslistt[0]
                                                                ["data"]["products"]
                                                                ["order_status"]
                                                            .toString() ==
                                                        "6"
                                                    ? 4
                                                    : 0

                                    // orderlist
                                    //     .Orderdeatilslistt[0]["data"]["products"]["order_status"]
                                    //     .toString() == "1" ?
                                    // 5 : 0
                                    ;
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: w / 10,
                                      height: h / 11,
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: w / 25,
                                            height: h / 28,
                                            decoration: BoxDecoration(
                                              color: index <= selectedIndex
                                                  ? logocolo
                                                  : Colors.grey,
                                              shape: BoxShape.circle,
                                            ),
                                            child: index <= selectedIndex
                                                ? const Center(
                                                    child: Text(
                                                    "✓",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                                : null,
                                          ),
                                          if (index < steps.length - 1)
                                            Expanded(
                                              child: Container(
                                                width: 2,
                                                color: index <= selectedIndex
                                                    ? logocolo
                                                    : Colors.grey,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(steps[index].title,
                                                style: TextStyle(
                                                    //letterSpacing: 2.5,
                                                    //color: Colors.white,
                                                    color: darkomdee.darkomde ==
                                                            true
                                                        ? Colors.white
                                                        : Colors.grey.shade900,
                                                    fontFamily: "Amazon_bold",
                                                    fontSize: 20)),
                                            // Text(steps[index].date, style: A_style_mid),
                                            // Text(time[index], style: A_style_mid),
                                            SizedBox(
                                              height: h / 80,
                                            ),
                                            // index == 1
                                            //     ? Text(
                                            //         "Date: ${serviceProvider.orderDetailList[0].inProgressDate.toString()}",
                                            //         style: TextStyle(
                                            //           color: Colors.grey,
                                            //           fontSize: w / 30,
                                            //         ),
                                            //       )
                                            //     : index == 2
                                            //         ? Text(
                                            //             "${serviceProvider.orderDetailList[0].asignDate.toString()}",
                                            //             style: TextStyle(
                                            //               color: Colors.grey,
                                            //               fontSize: w / 30,
                                            //             ),
                                            //           )
                                            //         : index == 3
                                            //             ? Text(
                                            //                 "${serviceProvider.orderDetailList[0].deliveryDate.toString()}",
                                            //                 style: TextStyle(
                                            //                   color: Colors.grey,
                                            //                   fontSize: w / 30,
                                            //                 ))
                                            //             : index == 4
                                            //                 ? Text(
                                            //                     "${serviceProvider.orderDetailList[0].completedDate.toString()}",
                                            //                     style: TextStyle(
                                            //                       color: Colors.grey,
                                            //                       fontSize: w / 30,
                                            //                     ),
                                            //                   )
                                            //                 : index == 0
                                            //                     ? Text(
                                            //                         "${serviceProvider.orderDetailList[0].orderDate.toString()}",
                                            //                         style: TextStyle(
                                            //                           color: Colors.grey,
                                            //                           fontSize: w / 30,
                                            //                         ),
                                            //                       )
                                            //                     : Text(""),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        // index == 3
                                        //     ? Row(
                                        //   mainAxisAlignment: MainAxisAlignment.end,
                                        //   children: [
                                        //     Container(
                                        //       height: h / 20,
                                        //       width: w / 2.9,
                                        //       decoration: BoxDecoration(
                                        //           color: Colors.deepPurple.shade100,
                                        //           borderRadius:
                                        //           BorderRadius.circular(10.0)),
                                        //       child: Center(
                                        //           child: Text(
                                        //             "Track Your Order",
                                        //             style: A_style_mid,
                                        //           )),
                                        //     ),
                                        //   ],
                                        // )
                                        //     : Text("")
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: h / 50,
                            ),
                            orderlist
                                    .Orderdeatilslistt[0]["data"]
                                        ["other_products"]
                                    .isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("Other product this order",
                                        style: A_style_text_head2),
                                  )
                                : const SizedBox(),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: orderlist
                                    .Orderdeatilslistt[0]["data"]
                                        ["other_products"]
                                    .length,
                                itemBuilder: (context, index) {

                                  other_products += double.parse(orderlist.Orderdeatilslistt.elementAt(0)["data"]["other_products"][index]["total"].toString());
                              print("jhjh ${other_products}");

                                  return Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade200,
                                              blurRadius: 5)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            "$image_url${orderlist.Orderdeatilslistt[0]["data"]["other_products"].elementAt(index)["image"]}",
                                                          ),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                        width: w / 2,
                                                        child: Text(
                                                            "${orderlist.Orderdeatilslistt[0]["data"]["other_products"].elementAt(index)["product_name"]}",
                                                            style:
                                                                A_style_text)),
                                                    Text(
                                                      "Qty:${orderlist.Orderdeatilslistt[0]["data"]["other_products"].elementAt(index)["qty"]} ",
                                                      style: A_style_mid,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: h / 80,
                            ),
                            Container(
                              width: w,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 2)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      orderlist.Orderdeatilslistt.elementAt(0)[
                                                      "data"]["delivery_place"]
                                                  .toString() ==
                                              "Pickup"
                                          ? Text(
                                              "Pickup Address :",
                                              style: TextStyle(
                                                  color:
                                                      darkomdee.darkomde == true
                                                          ? Colors.black
                                                          : Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          : Text(
                                              "Delivery Address :",
                                              style: TextStyle(
                                                  color:
                                                      darkomdee.darkomde == true
                                                          ? Colors.black
                                                          : Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                      orderlist.Orderdeatilslistt.elementAt(0)[
                                                      "data"]["delivery_place"]
                                                  .toString() ==
                                              "Pickup"
                                          ? const SizedBox()
                                          :
                                      orderlist.Orderdeatilslistt.elementAt(0)[
                                      "data"]["delivery_place"]
                                          .toString() !=
                                          "Pickup"  &&     orderlist.Orderdeatilslistt[0]
                                      ["data"]["products"]
                                      ["order_status"]
                                          .toString() ==
                                          "4"   && orderlist.Orderdeatilslistt[0]
                                      ["data"]["products"]
                                      ["order_status"]
                                          .toString() ==
                                          "6" ?
                                          SizedBox():
                                      GestureDetector(
                                              onTap: () {
                                                Get.to(orderaddress1(
                                                  addressid: orderlist
                                                              .Orderdeatilslistt
                                                          .elementAt(0)["data"]
                                                      ["addressId"],
                                                  checkoutid: orderlist
                                                              .Orderdeatilslistt
                                                          .elementAt(0)["data"]
                                                      ["checkoutId"],
                                                ));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: Border.all(
                                                      color: logocolo,
                                                    )),
                                                child: const Text(
                                                  "Change",
                                                  style: A_style_text_button,
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
                                  SizedBox(
                                    height: h / 50,
                                  ),
                                  orderlist.Orderdeatilslistt.elementAt(
                                                  0)["data"]["delivery_place"]
                                              .toString() ==
                                          "Pickup"
                                      ? Text(
                                          "${orderlist.Orderdeatilslistt.elementAt(0)["data"]["shop_address"]}",
                                          style: TextStyle(
                                              //letterSpacing: 1.5,
                                              //color: Colors.white,
                                              color: Colors.grey.shade700,
                                              fontFamily: "Amazon_med",
                                              fontSize: 16),
                                        )
                                      : Text(
                                          "${orderlist.Orderdeatilslistt.elementAt(0)["data"]["placeType"]} \n ${orderlist.Orderdeatilslistt.elementAt(0)["data"]["building_no"] ?? ""},${orderlist.Orderdeatilslistt.elementAt(0)["data"]["village_name"] ?? ""},${orderlist.Orderdeatilslistt.elementAt(0)["data"]["landmark"] ?? ""},${orderlist.Orderdeatilslistt.elementAt(0)["data"]["city_name"] ?? ""},${orderlist.Orderdeatilslistt.elementAt(0)["data"]["state"] ?? ""}, ${orderlist.Orderdeatilslistt.elementAt(0)["data"]["pin_code"] ?? ""}",
                                          style: TextStyle(
                                              //letterSpacing: 1.5,
                                              //color: Colors.white,
                                              color: Colors.grey.shade700,
                                              fontFamily: "Amazon_med",
                                              fontSize: 16),
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        blurRadius: 5)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Payment Details",
                                        style: TextStyle(
                                            //letterSpacing: 2.5,
                                            //color: Colors.white,
                                            color: Colors.grey.shade900,
                                            fontFamily: "Amazon_bold",
                                            fontSize: 20)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("Price Details(1 item)",
                                        style: TextStyle(
                                            //letterSpacing: 1.5,
                                            //color: Colors.white,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontFamily: "Amazon_med",
                                            fontSize: 16)),
                                    Divider(
                                      height: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                     Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Product Price"),
                                        Text("${orderlist.Orderdeatilslistt.elementAt(0)["data"]["products"]["total"].toStringAsFixed(2)} CFA")
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Order Total",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(

                                          " ${(double.parse(orderlist.Orderdeatilslistt.elementAt(0)["data"]["products"]["total"].toString()) +double.parse(other_products.toString())).toStringAsFixed(2)} CFA",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h / 50,
                            ),
                            orderlist.Orderdeatilslistt[0]["data"]["products"]
                                            ["order_status"]
                                        .toString() ==
                                    "1"
                                ? Container(
                                    width: w,
                                    height: h / 18,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 2)
                                        ]),
                                    child: Center(
                                      child: Text(
                                        "Order cancelled",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                : orderlist.Orderdeatilslistt[0]["data"]
                                                ["products"]["order_status"]
                                            .toString() ==
                                        "0"
                                    ? InkWell(
                                        onTap: () {
                                          showOrderCancelDialog(context);
                                        },
                                        child: Container(
                                          width: w,
                                          height: h / 18,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.black,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    blurRadius: 2)
                                              ]),
                                          child: Center(
                                            child: Text(
                                              "Cancel Order",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: w,
                                        height: h / 18,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  blurRadius: 2)
                                            ]),
                                        child: Center(
                                          child: Text(
                                            "Cancel Order",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                          ],
                        );
            },
          ),
        ),
      ),
    );
  }
var other_products=0.0;

  void showOrderCancelDialog(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            'Cancel Order',
          )),
          titleTextStyle: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          content: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                    text: "Are you sure you'd like to cancel this order? ",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: 'This action cannot be undone.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await orderlist.ordercancel(
                        order_id:
                            orderlist.Orderdeatilslistt.elementAt(0)["data"]
                                ["_id"],
                        productId:
                            orderlist.Orderdeatilslistt.elementAt(0)["data"]
                                ["products"]["productId"],
                        payment_status:
                            orderlist.Orderdeatilslistt.elementAt(0)["data"]
                                ["products"]["payment_status"]);
                    setState(() {
                      currentTab = 0;
                    });
                    Get.to(() => const DashBoardScreen());
                  },
                  child: Container(
                      height: h / 20,
                      width: w / 3,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        'Yes, Cancel',
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Container(
                      height: h / 20,
                      width: w / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                          )),
                      child: const Center(
                          child: Text(
                        'No',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ))),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

class StepData {
  final String title;
  final String? subtitle;
  final String date;

  final String? assetImage;

  StepData({
    required this.title,
    this.subtitle,
    required this.date,
    this.assetImage,
  });
}

// ________________________________________ ui for change address __________________________________//
class orderaddress1 extends StatefulWidget {
  final checkoutid;
  final addressid;

  const orderaddress1({
    Key? key,
    this.checkoutid,
    this.addressid,
  }) : super(key: key);

  @override
  State<orderaddress1> createState() => _orderaddress1State();
}

class _orderaddress1State extends State<orderaddress1> {
  final GetxControllers controller = Get.put(GetxControllers());
  final Address_api addressList = Get.put(Address_api());
  final chekoutt = Get.put(orderplaced());

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Row(
          children: [
            Text("select Address"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 12.0, left: 12, top: 12),
        child: FutureBuilder(
          future: addressList.getAddressListApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: logocolo,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Obx(() => addressList.addressList.isEmpty
                  ? const Center(
                      child: Text(
                      "Add Address",
                      style: TextStyle(color: Colors.black),
                    ))
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: addressList.addressList[0].length,
                      itemBuilder: (BuildContext context, int index) {
                        chekoutt.addressIds1.value = widget.addressid;
                        // print("kkkjjjj");
                        // chekoutt.addressId.value =addressList.addressList.value[0][0]["_id"];
                        // print("kkkjjjj${addressList.addressList.value[0][0]
                        // ["_id"].toString()}");
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Obx(() => Checkbox(
                                        focusColor: logocolo,
                                        activeColor: logocolo,
                                        checkColor: Colors.white,
                                        value: chekoutt.addressIds1.value ==
                                                addressList.addressList[0]
                                                        [index]["_id"]
                                                    .toString()
                                            ? true
                                            : false,
                                        onChanged: (newValue) {
                                          final selectedAddressId = addressList
                                              .addressList[0][index]["_id"]
                                              .toString();
                                          chekoutt.addressIds1.value =
                                              selectedAddressId;
                                          print(chekoutt.addressIds1.value);
                                        },
                                      )),
                                  SizedBox(
                                    width: w / 70,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        addressList.addressList[0][index]
                                            ["place_type"],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Ember",
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        width: w / 3,
                                        child: Text(
                                          "${addressList.addressList[0][index]["building_no"]} ${addressList.addressList[0][index]["village_name"]}${addressList.addressList[0][index]["city_name"]},  ${addressList.addressList[0][index]["landmark"]} ${addressList.addressList[0][index]["state"]}, ${addressList.addressList[0][index]["pin_code"]}",
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.black,
                                            fontFamily: "Ember",
                                            fontSize: 15,
                                          ),
                                          maxLines: 4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ));
            }
          },
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          await chekoutt.cahngeaddress_api(
              widget.checkoutid, chekoutt.addressIds1);
          Get.to(const MyOrder());
        },
        child: Container(
          margin: const EdgeInsets.all(15),
          height: 70,
          width: w,
          decoration: BoxDecoration(
            color: logocolo,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
                child: Text(
              "Change Address",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}
