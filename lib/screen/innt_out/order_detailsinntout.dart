import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Controller/text2.dart';
import '../Users/order_details.dart';
import 'dashboardinntout.dart';





class OrderDetailsinnoutPage extends StatefulWidget {
  final orderid;
  final orderno;
  final productid;

  const OrderDetailsinnoutPage({
    super.key,
    this.orderid,
    this.orderno,
    this.productid,
  });

  @override
  State<OrderDetailsinnoutPage> createState() => _OrderDetailsinnoutPageState();
}

class _OrderDetailsinnoutPageState extends State<OrderDetailsinnoutPage> {
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
      title: 'Shipping',
      date: 'jan 27,2023',
    ),
    StepData(
      title: 'Delivered',
      date: 'jan 28 ,2023',
    ),
    StepData(
      title: 'Cancel',
      date: 'jan 28 ,2023',
    ),
  ];
  List time = ["10:35 PM", "10:40 PM", "10:45 PM", "10:45 PM", "11:15 PM"];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: secondryColor,
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
                            Text("Product Details", style: A_style_text_head2),
                            Container(
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
                                                      style: A_style_text)),
                                              Text(
                                                "Qty:${orderlist.Orderdeatilslistt[0]["data"]["products"]["qty"]} ",
                                                style: A_style_mid,
                                              ),

                                              SizedBox(width: w/2,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:   orderlist.Orderdeatilslistt[0]["data"]["products"]["attributes"].length,
                                                  itemBuilder: (context, indext) {
                                                    return Padding(
                                                      padding: const EdgeInsets.all(3.0),
                                                      child: Text(
                                                        "${ orderlist.Orderdeatilslistt[0]["data"]["products"]["attributes"][indext]["name"]}: ${ orderlist.Orderdeatilslistt[0]["data"]["products"]["attributes"][indext]["value"]} ",
                                                        style: A_style_mid,
                                                      ),
                                                    );
                                                  },),
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
                            Text("Review", style: A_style_text_head2),
                            SizedBox(
                              height: h / 80,
                            ),
                            Material(
                              color: Colors.white,
                              elevation: 1,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: w,
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
                                      itemCount: 5,
                                      ignoreGestures: true,
                                      itemPadding:
                                          const EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star_rate,
                                        color: Colors.yellow.shade800,
                                      ),
                                      onRatingUpdate: (double value) {},
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          // Get.to(Reviewgive(
                                          //   productid: widget.productid,
                                          //   orderno: widget.orderno,
                                          //   orderid: widget.orderid,
                                          //   shopid:
                                          //       orderlist.Orderdeatilslistt[0]
                                          //           ["data"]["shopId"],
                                          // ));
                                        },
                                        icon: const Icon(Icons.keyboard_arrow_right))
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
                                  style: A_style_text_head2),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: steps.length,
                              itemBuilder: (context, index) {
                                int selectedIndex =   orderlist.Orderdeatilslistt[0]["data"]["products"]["order_status"].toString()=="0"?
                                0 :
                                orderlist.Orderdeatilslistt[0]["data"]["products"]["order_status"].toString()=="2"?
                                1:
                                orderlist.Orderdeatilslistt[0]["data"]["products"]["order_status"].toString()=="4"?
                                3:
                                orderlist.Orderdeatilslistt[0]["data"]["products"]["order_status"].toString()=="6"?
                                4:

                                orderlist.Orderdeatilslistt[0]["data"]["products"]["order_status"].toString()=="1"?
                                5:0
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
                                                style: A_style_text_head2),


                                          ],
                                        ),

                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: h / 80,
                            ),
                            InkWell(
                              onTap: () {
                                showOrderCancelDialog(context);
                              },
                              child: Container(
                                width: w,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 2)
                                    ]),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Cancel Order",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
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
                                                    // Text(
                                                    //   "\$ ${orderlist.Orderdeatilslistt[0]["data"]["other_products"].elementAt(index)["sale_price"]! * int.parse(orderlist.Orderdeatilslistt[0]["data"]["other_products"].elementAt(index)["qty"].toString())}",
                                                    //   style: A_style_order,
                                                    // ),
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
                                              style: A_style_text,
                                            )
                                          : Text(
                                              "Delivery Address :",
                                              style: A_style_text,
                                            ),
                                      orderlist.Orderdeatilslistt.elementAt(0)[
                                                      "data"]["delivery_place"]
                                                  .toString() ==
                                              "Pickup"
                                          ? const SizedBox()
                                          : Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                    color: logocolo,
                                                  )),
                                              child: const Text(
                                                "Change",
                                                style: A_style_text_button,
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
                                          "${orderlist.Orderdeatilslistt.elementAt(0)["data"]["building_no"]},${orderlist.Orderdeatilslistt.elementAt(0)["data"]["village_name"]},${orderlist.Orderdeatilslistt.elementAt(0)["data"]["landmark"]},${orderlist.Orderdeatilslistt.elementAt(0)["data"]["city_name"]},${orderlist.Orderdeatilslistt.elementAt(0)["data"]["state"]}, ${orderlist.Orderdeatilslistt.elementAt(0)["data"]["pin_code"]}",
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
                                        style: A_style_text_head2),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text("Price Details(1 item)",
                                        style: A_style_medium),
                                    Divider(
                                      height: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Total Price"),
                                        Text("+\$ 399")
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
                                        Text(
                                          "Order Total",
                                          style: A_style_text,
                                        ),
                                        Text(
                                          "${orderlist.Orderdeatilslistt.elementAt(0)["data"]["products"]["total"].toStringAsFixed(2)} CFA",
                                          style: A_style_text,
                                        )
                                      ],
                                    ),
                                  ],
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

  void showOrderCancelDialog(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Cancel Order')),
          titleTextStyle: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          content: RichText(
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
                      selectedindex = 0;
                    });
                    Get.to(() => const DashboardInntOut());
                  },
                  child: Container(
                      height: h / 20,
                      width: w / 3,
                      decoration: BoxDecoration(
                        color: logocolo,
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
                            color: logocolo,
                          )),
                      child: const Center(
                          child: Text(
                        'No',
                        style: TextStyle(
                          color: logocolo,
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
