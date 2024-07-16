import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/qr_scanner.dart';
import 'package:inntuser/screen/Users/qrcode_scan.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../Api/orderplaced_api.dart';
import '../../Controller/text2.dart';
import '../../main.dart';
import 'Navgationbar.dart';
import 'chatting.dart';
import 'order_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  final orderlist = Get.put(orderplaced());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        backgroundColor:   darkomdee.darkomde==true?
        Colors.black:Colors.white,
        appBar: AppBar(centerTitle: true,
          leading: IconButton(
              onPressed: () {
                setState(() {
                  currentTab = 4;
                });
                Get.offAll(const DashBoardScreen());
              },
              icon: const Icon(Icons.arrow_back)),

          title:  Text(
            AppLocalizations.of(context)!.myorders,
          ),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: FutureBuilder(
              future: orderlist.orderlist_api(),
              builder: (context, snapshot) {
                return
                  snapshot.connectionState == ConnectionState.waiting ?
                  const Center(child: CircularProgressIndicator(color: logocolo),)
                      :
                  Obx(() =>
                  orderlist.OrderListlistt.isEmpty ?
                  const Center(child: Text("No order"))
                      :

                  ListView.builder(
                    shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                    itemCount: orderlist.OrderListlistt
                        .elementAt(0)
                        ["data"]!
                        .length,
                    itemBuilder: (context, index) {
                      var dataa = orderlist.OrderListlistt
                          .elementAt(0)
                          ["data"];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color:   darkomdee.darkomde==true?
                              Colors.black:Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade400, blurRadius: 2),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color:   darkomdee.darkomde==true?
                                        Colors.black: const Color(0xD7E2F1FF),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      "Order Id: ${dataa
                                          !.elementAt(index)
                                          ["orderId"]}",
                                      style:  TextStyle(
                                          color:   darkomdee.darkomde==true?
                                          Colors.white:const Color(0xff1455ac),
                                          fontSize: 17,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 2,
                                    )),
                                SizedBox(
                                  height: h / 150,
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Order date",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:  darkomdee.darkomde==true?
                                            const TextStyle(
                                              //letterSpacing: 1.5,
                                                color: Colors.white,

                                                fontFamily: "Amazon_med",
                                                fontSize: 16) :A_style_order),
                                        SizedBox(height: h/100,),
                                        Text("Delivery status",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:  darkomdee.darkomde==true?
                                            const TextStyle(
                                              //letterSpacing: 1.5,
                                                color: Colors.white,

                                                fontFamily: "Amazon_med",
                                                fontSize: 16) :A_style_order),
                                        SizedBox(height: h/100,),
                                        Text("Delivery code",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:  darkomdee.darkomde==true?
                                            const TextStyle(
                                              //letterSpacing: 1.5,
                                                color: Colors.white,

                                                fontFamily: "Amazon_med",
                                                fontSize: 16) :A_style_order),



                                      ],
                                    ),
                                    Column(crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text("${dataa
                                            .elementAt(index)
                                        ["createdAt"]!
                                            .substring(0, 10)}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:  darkomdee.darkomde==true?
                                            const TextStyle(
                                              //letterSpacing: 1.5,
                                                color: Colors.white,

                                                fontFamily: "Amazon_med",
                                                fontSize: 16) :A_style_order),

                                        SizedBox(height: h/100,),

                                        Text(
                                            dataa.elementAt(index)['status'].toString()=="0"?
                                            "Ordered":
                                            dataa
                                                .elementAt(index)['status'].toString()=="2"?
                                            "Confirmed":
                                            dataa
                                                .elementAt(index)['status'].toString()=="4"?
                                            "Packing":
                                            dataa
                                                .elementAt(index)['status'].toString()=="6"?
                                            "Shipped":
                                            dataa
                                                .elementAt(index)['status'].toString()=="5"?
                                            "Delivered":
                                            dataa
                                                .elementAt(index)['status'].toString()=="1"?
                                            "Cancelled":
                                            ""

                                        ,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:  darkomdee.darkomde==true?
                                            const TextStyle(
                                              //letterSpacing: 1.5,
                                                color: Colors.white,

                                                fontFamily: "Amazon_med",
                                                fontSize: 16) :A_style_order),
                                        SizedBox(height: h/100,),
                                        Text("${dataa
                                            .elementAt(index)
                                        ["orderVerification_code"]!
                                            }",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:  darkomdee.darkomde==true?
                                            const TextStyle(
                                              //letterSpacing: 1.5,
                                                color: Colors.white,

                                                fontFamily: "Amazon_med",
                                                fontSize: 16) :A_style_order),

                                      ],
                                    ),

                                  ],
                                )


                               ,
                                SizedBox(
                                  height: h / 150,
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                  dataa.elementAt(index)["products"]!.length,
                                  itemBuilder: (context, indexx) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child:
                                      GestureDetector(
                                        onTap: (){
                                          Get.to(OrderDetailsPage(productid: dataa.elementAt(index)["products"].elementAt(indexx)["productId"],orderid: dataa
                                              .elementAt(index)
                                              ["_id"], orderno: dataa
                                              .elementAt(index)
                                              ["orderId"]),);
                                           },
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                "$image_url${dataa.elementAt(index)["products"].elementAt(indexx)["image"]}",
                                                fit: BoxFit.fill,
                                                height: h / 10,
                                                width: w / 6,
                                              ),
                                              SizedBox(
                                                width: w / 50,
                                              ),
                                              SizedBox(width: w / 1.8,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [

                                                    Text(dataa.elementAt(index)["products"].elementAt(indexx)["product_name"].toString(),
                                                        style: TextStyle(
                                                          //letterSpacing: 1.5,
                                                          //color: Colors.white,
                                                            overflow: TextOverflow.ellipsis,
                                                            fontWeight: FontWeight.w500,
                                                            color:
                                                            darkomdee.darkomde==true?
                                                            Colors.white:
                                                            Colors.black,
                                                            fontFamily: "Amazon_med",
                                                            fontSize: 16),maxLines: 2),

                                                    SizedBox(
                                                      height: h / 80,
                                                    ),
                                                    SizedBox(width: w/3,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: dataa.elementAt(index)["products"].elementAt(indexx)["attributes"].length,
                                                        itemBuilder: (context, indext) {
                                                          return Padding(
                                                            padding: const EdgeInsets.all(3.0),
                                                            child: Text(
                                                              "${ dataa.elementAt(index)["products"].elementAt(indexx)["attributes"][indext]["name"]}: ${dataa.elementAt(index)["products"].elementAt(indexx)["attributes"][indext]["value"]} ",
                                                              style:  TextStyle(
                                                                //letterSpacing: 1.5,
                                                                //color: Colors.white,
                                                                  color:  Colors.grey.shade700,
                                                                  fontFamily: "Amazon_med",
                                                                  fontSize: 14),
                                                            ),
                                                          );
                                                        },),
                                                    )
                                                  ],
                                                ),
                                              ),
                                               Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(
                                                    Icons.keyboard_arrow_right,color:   darkomdee.darkomde==true?
                                                Colors.white:Colors.black,),
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
                                  /*  Get.to(OrderDetailsPage(orderid: dataa
                                        .elementAt(index)
                                        .id,));*/
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(UserChat(status: 1,
                                              shopname:  dataa.elementAt(index)["products"][0]["shop_name"].toString(),
                                              venderid: dataa.elementAt(index)["shopId"]["_id"]!.toString(),
                                              venderimage:dataa.elementAt(index)["shopId"]["shop_logo"].toString(),
                                            ));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(4),
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: logocolo)),
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
                                                      fontWeight: FontWeight
                                                          .w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),


                                        InkWell(
                                          onTap: () {
                                         Get.to(() => QRCodeScan(
                                           qrcode: dataa
                                               .elementAt(index)
                                           ["qrcodes"]
                                               .toString(),
                                           qrname: dataa
                                           !.elementAt(index)
                                           ["orderId"].toString(),


                                         ));
                                          },
                                          child: QrImageView(
                                            data: dataa
                                                .elementAt(index)
                                                ["qrcodes"]
                                                .toString(),
                                            foregroundColor:    darkomdee.darkomde==true?Colors.white:
                                            Colors.black ,
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
            )
        )
    );
  }
}

  // old desgin
  // Container(
  // decoration: BoxDecoration(
  // color: Colors.white,
  // borderRadius: BorderRadius.circular(5),
  // boxShadow: [
  // BoxShadow(
  // color: Colors.grey.shade400, blurRadius: 2),
  // ]),
  // child: Column(
  // crossAxisAlignment: CrossAxisAlignment.start,
  // children: [
  // Row(
  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  // children: [
  //
  // Image.asset(
  // "assets/images/shops.png",
  // height: h / 10,
  // width: w / 12,
  // ),
  // Container(
  // height: 1.5,
  // width: w / 3,
  // color: logocolo,
  // ),
  // Image.asset(
  // "assets/images/deliverytruck.png",
  // height: h / 10,
  // width: w / 12,
  // ),
  // Container(
  // height: 1.5,
  // width: w / 3.8,
  // color: Colors.grey,
  // ),
  // Icon(
  // Icons.arrow_forward_ios_sharp,
  // color: Colors.grey,
  // ),
  // Image.asset(
  // "assets/images/homes.png",
  // height: h / 18,
  // ),
  // ],
  // ),
  // Center(
  // child: Container(
  // padding: EdgeInsets.all(4),
  // width: w / 4,
  // decoration: BoxDecoration(
  // color: Colors.black,
  // ),
  // child: Row(
  // mainAxisAlignment:
  // MainAxisAlignment.spaceEvenly,
  // crossAxisAlignment: CrossAxisAlignment.center,
  // children: [
  // Icon(
  // Icons.close,
  // color: Colors.white,
  // ),
  // Text("Cancel",
  // style: A_style_text_inside_button)
  // ],
  // ),
  // ),
  // ),
  // SizedBox(
  // height: h / 100,
  // ),
  // SizedBox(
  // height: h / 7,
  // child: ListView.builder(
  // shrinkWrap: true,
  // scrollDirection: Axis.horizontal,
  // itemCount:dataa!.elementAt(index)["products"].length,
  // itemBuilder: (context, index1) {
  // return InkWell(
  // onTap: () {
  // Get.to( OrderDetailsPage(orderid: dataa.elementAt(index).id,));
  // },
  // child: Padding(
  // padding: const EdgeInsets.only(
  // right: 5.0, top: 5, left: 5),
  // child: Container(
  // height: h / 8,
  // width: w / 5,
  // child: ClipRRect(
  // borderRadius:
  // BorderRadius.circular(5),
  // child: Image.network(
  // "$image_url${dataa.elementAt(index)["products"].elementAt(index1).image.toString()}",
  // fit: BoxFit.contain)),
  // )),
  // );
  // },
  // ),
  // ),
  // Padding(
  // padding: const EdgeInsets.all(8),
  // child: Column(
  // crossAxisAlignment: CrossAxisAlignment.start,
  // children: [
  // Text("Order date: ${dataa.elementAt(index).createdAt!.substring(0,10)}",
  // maxLines: 1,
  // overflow: TextOverflow.ellipsis,
  // style: A_style_order),
  // Text("Shipped date: December 13, 2023",
  // maxLines: 1,
  // overflow: TextOverflow.ellipsis,
  // style: A_style_order),
  // Text("Order Id: ${dataa.elementAt(index).orderId}",
  // maxLines: 1,
  // overflow: TextOverflow.ellipsis,
  // style: A_style_order),
  // // Text("Order amount: \$${dataa.elementAt(index).grandTotal!.toStringAsFixed(2)}",
  // //     maxLines: 1,
  // //     overflow: TextOverflow.ellipsis,
  // //     style: A_style_text_head2),
  // ],
  // ),
  // ),
  // InkWell(
  // onTap: () {
  // Get.to( OrderDetailsPage(orderid: dataa.elementAt(index).id,));
  // },
  // child: Padding(
  // padding: const EdgeInsets.only(
  // bottom: 10,
  // ),
  // child: Row(
  // children: [
  // InkWell(
  // onTap: () {
  // Get.to(() => Chatall());
  // },
  // child: Container(
  // margin: EdgeInsets.all(4),
  // padding: const EdgeInsets.all(4),
  // decoration: BoxDecoration(
  // color: Colors.white,
  // borderRadius:
  // BorderRadius.circular(5),
  // border: Border.all(color: logocolo)),
  // child: Row(
  // mainAxisAlignment:
  // MainAxisAlignment.spaceAround,
  // children: [
  // Icon(
  // Icons.chat,
  // color: logocolo,
  // size: 15,
  // ),
  // const Text(
  // "Chat",
  // style: TextStyle(
  // color: logocolo,
  // fontSize: 12,
  // fontWeight: FontWeight.w500),
  // ),
  // ],
  // ),
  // ),
  // ),
  // SizedBox(
  // width: w / 080,
  // ),
  // Container(
  // padding: const EdgeInsets.all(4),
  // decoration: BoxDecoration(
  // color: Colors.white,
  // borderRadius: BorderRadius.circular(5),
  // border: Border.all(
  // color: button_red_color)),
  // child: Row(
  // mainAxisAlignment:
  // MainAxisAlignment.spaceAround,
  // children: [
  // Icon(
  // Icons.star,
  // color: button_red_color,
  // size: 15,
  // ),
  // const Text(
  // "Review",
  // style: TextStyle(
  // color: button_red_color,
  // fontSize: 12,
  // fontWeight: FontWeight.w500),
  // ),
  // ],
  // ),
  // ),
  // // SizedBox(
  // //   width: w / 080,
  // // ),
  // // Container(
  // //   padding: const EdgeInsets.all(4),
  // //   decoration: BoxDecoration(
  // //       color: Colors.white,
  // //       borderRadius: BorderRadius.circular(5),
  // //       border: Border.all(
  // //         color: Colors.red.shade700,
  // //       )),
  // //   child: Row(
  // //     mainAxisAlignment:
  // //         MainAxisAlignment.spaceAround,
  // //     children: [
  // //       Image.asset(
  // //         "assets/images/liveicon.png",
  // //         height: 15,
  // //         width: 15,
  // //         color: Colors.red.shade700,
  // //       ),
  // //       Text(
  // //         "innt live",
  // //         style: TextStyle(
  // //             color: Colors.red.shade700,
  // //             fontSize: 12,
  // //             fontWeight: FontWeight.w500),
  // //       ),
  // //     ],
  // //   ),
  // // ),
  // SizedBox(
  // width: w / 080,
  // ),
  // Container(
  // padding: const EdgeInsets.all(4),
  // decoration: BoxDecoration(
  // color: Colors.white,
  // borderRadius: BorderRadius.circular(5),
  // border: Border.all(
  // color: logocolo,
  // )),
  // child: Text(
  // "innt live",
  // style: TextStyle(
  // color: logocolo,
  // fontSize: 12,
  // fontWeight: FontWeight.w500),
  // ),
  // ),
  // SizedBox(
  // width: w / 080,
  // ),

  // SizedBox(
  // width: w / 20,
  // ),
  //
  // InkWell(
  // onTap: () {
  // //Get.to(() => QrScreen());
  // },
  // child: QrImageView(
  // data: dataa.elementAt(index).orderId.toString(),
  // version: QrVersions.auto,
  // size: 40.0,
  // ),
  // )
  // ],
  // ),
  // ),
  // )
  // ],
  // ),
  // )
