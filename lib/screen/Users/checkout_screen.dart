import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/addressList_api.dart';
import '../../Api/orderplaced_api.dart';
import '../../Controller/button.dart';
import '../../Controller/controller.dart';
import '../../Controller/text2.dart';
import 'order_success.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen(
      {super.key,
      required this.deliveryfee,
      required this.totalamount,
      required this.paltformfee,
      this.addressid});

  final deliveryfee;
  final totalamount;
  final paltformfee;
  final addressid;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  // bool _isAddress = true;
  final GetxControllers controller = Get.put(GetxControllers());
  final Address_api addressList = Get.put(Address_api());
  final chekoutt = Get.put(orderplaced());

  late var index;

  gg() {
    index = addressList.addressList[0].indexWhere(
      (element) => element["_id"].toString() == widget.addressid.toString(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    gg();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("CheckOut"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 1)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Bag",
                        style: A_style_medium,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.black,
                          ))
                    ],
                  ),
                  FutureBuilder(
                    future: chekoutt.checkoutlist_api(),
                    builder: (context, snapshot) {
                      print("hh${chekoutt.checkoutcartlistt}");
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(color: logocolo),
                            )
                          : chekoutt.checkoutcartlistt.isEmpty
                              ? const Text("no product")
                              : SizedBox(
                                  height: h / 5,
                                  child: ListView.builder(
                                    itemCount: chekoutt.checkoutcartlistt
                                        .elementAt(0)
                                        .data!
                                        .products!
                                        .length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Material(
                                          elevation: 1,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image.network(
                                                  "$image_url${chekoutt.checkoutcartlistt.elementAt(0).data!.products!.elementAt(index).image}",
                                                  height: 70,
                                                  width: 80,
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: h / 70,
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 1)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery options",
                    style: A_style_text,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        shape: const CircleBorder(),
                        value: true,
                        activeColor: const Color(0xff1455ac),
                        onChanged: (newBool) {
                          // setState(() {

                          // });
                        },
                      ),
                      Obx(
                        () => chekoutt.isAddress.value == true
                            ? Text("My address", style: A_style_medium)
                            : Text("Self pick up", style: A_style_medium),
                      )
                    ],
                  ),
                  SizedBox(
                    height: h / 70,
                  ),
                  Obx(() => chekoutt.isAddress.value == true
                      ? Padding(
                          padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                addressList.addressList[0][index]["place_type"],
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
                        )
                      : const SizedBox())

                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                        shape: CircleBorder(),
                        value: chekoutt.isAddress.value==false?true:false,
                        activeColor: Color(0xff1455ac),
                        onChanged: (newBool) {
                          // setState(() {
                          chekoutt.isAddress.value = false;
                          // });
                        },
                      ))
                      ,
                      Text("Self pick up", style: A_style_medium),
                    ],
                  ),*/
                ],
              ),
            ),
            SizedBox(
              height: h / 70,
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 1)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pay now",
                    style: A_style_text,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                            shape: const CircleBorder(),
                            value: chekoutt.pay.value == 1 ? true : false,
                            activeColor: const Color(0xff1455ac),
                            onChanged: (newBool) {
                              chekoutt.pay.value = 1;
                              chekoutt.payTypes.value = "wallet";
                              print('kkkll${chekoutt.payTypes.value}');
                            },
                          )),
                      Text("My wallet", style: A_style_medium),
                      SizedBox(
                        width: w / 80,
                      ),
                      Image.asset(
                        "assets/images/wallet_check.png",
                        height: h / 15,
                        width: w / 13,
                      ),
                      SizedBox(
                        width: w / 80,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                            shape: const CircleBorder(),
                            value: chekoutt.pay.value == 2 ? true : false,
                            activeColor: const Color(0xff1455ac),
                            onChanged: (newBool) {
                              chekoutt.pay.value = 2;
                              chekoutt.payTypes.value = "Orange money";
                              print('kkkll${chekoutt.payTypes.value}');
                            },
                          )),
                      Text("Orange money", style: A_style_medium),
                      SizedBox(
                        width: w / 80,
                      ),
                      Image.asset(
                        "assets/images/orange_money.png",
                        height: 15,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                            shape: const CircleBorder(),
                            value: chekoutt.pay.value == 3 ? true : false,
                            activeColor: const Color(0xff1455ac),
                            onChanged: (newBool) {
                              chekoutt.pay.value = 3;
                              chekoutt.payTypes.value = "Moov money";
                              print('kkkll${chekoutt.payTypes.value}');
                            },
                          )),
                      Text("Moov money", style: A_style_medium),
                      SizedBox(
                        width: w / 80,
                      ),
                      Image.asset(
                        "assets/images/Picture3.png",
                        scale: 1.5,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                            shape: const CircleBorder(),
                            value: chekoutt.pay.value == 4 ? true : false,
                            activeColor: const Color(0xff1455ac),
                            onChanged: (newBool) {
                              chekoutt.pay.value = 4;
                              chekoutt.payTypes.value = "Coris money";
                              print('kkkll${chekoutt.payTypes.value}');
                            },
                          )),
                      Text("Coris money", style: A_style_medium),
                      SizedBox(
                        width: w / 80,
                      ),
                      Image.asset("assets/images/Picture2.png", scale: 7.5)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                            shape: const CircleBorder(),
                            value: chekoutt.pay.value == 5 ? true : false,
                            activeColor: const Color(0xff1455ac),
                            onChanged: (newBool) {
                              chekoutt.pay.value = 5;
                              chekoutt.payTypes.value = "Credit card";
                              print('kkkll${chekoutt.payTypes.value}');
                            },
                          )),
                      Text("Credit card", style: A_style_medium),
                      Image.asset("assets/images/creadit.png", scale: 1.5),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: h / 70,
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 1)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pay later",
                    style: A_style_text,
                  ),
                  Obx(() => chekoutt.isAddress == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => Checkbox(
                                  shape: const CircleBorder(),
                                  value: chekoutt.pay.value == 0 ? true : false,
                                  activeColor: const Color(0xff1455ac),
                                  onChanged: (newBool) {
                                    chekoutt.pay.value = 0;
                                  },
                                )),
                            Text("Pay on delivery", style: A_style_medium),
                            Image.asset(
                              "assets/images/delivery.png",
                              height: h / 13,
                              width: w / 13,
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => Checkbox(
                                  shape: const CircleBorder(),
                                  value: chekoutt.pay.value == 0 ? true : false,
                                  activeColor: const Color(0xff1455ac),
                                  onChanged: (newBool) {
                                    chekoutt.pay.value = 0;
                                  },
                                )),
                            Text("Pay at the store", style: A_style_medium),
                            const Icon(Icons.location_on, color: Colors.black)
                          ],
                        )),
                ],
              ),
            ),
            SizedBox(
              height: h / 70,
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 1)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order note",
                    style: A_style_text,
                  ),
                  SizedBox(
                    height: h / 70,
                  ),
                  TextFormField(
                    controller: Ordernote,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: "Type your order note here",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )
                ],
              ),
            ),
            SizedBox(
              height: h / 70,
            ),
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade300, blurRadius: 1)
                    ]),
                child: ExpansionTile(
                    textColor: Colors.black,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter code"),
                      SizedBox(
                        height: h / 70,
                      ),
                      TextFormField(
                        controller: promocode,
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText: "Enter code",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: promocode.text.isEmpty
                                      ? Colors.grey
                                      : logocolo),
                              child: Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Text(
                                  "Apply",
                                  style: TextStyle(
                                      color: promocode.text.isEmpty
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              )),
                        ),
                      )
                    ],
                    title: Text("Gift card /  Coupon"))

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //
                //
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           "Promo code / Gift cards",
                //           style: A_style_medium,
                //         ),
                //
                //       ],
                //     ),
                //   ],
                // ),
                ),
            SizedBox(
              height: h / 70,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 8, bottom: 15, top: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Sub Total"),
                        SizedBox(
                          height: h / 50,
                        ),
                        const Text("Tax"),
                        SizedBox(
                          height: h / 50,
                        ),
                        const Text("Discount"),
                        SizedBox(
                          height: h / 50,
                        ),
                        const Text("Offer"),
                        SizedBox(
                          height: h / 50,
                        ),

                        const Text("Gift card /  Coupon"),
                        SizedBox(
                          height: h / 50,
                        ),
                        Obx(() => chekoutt.isAddress.value == true
                            ? const Text("Delivery fee")
                            : const SizedBox()),
                        SizedBox(
                          height: h / 50,
                        ),
                        // const Text("Paltform fee"),
                        // SizedBox(height: h / 50,),
                        const Text("Total"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${widget.totalamount.toStringAsFixed(2)}"),
                        SizedBox(
                          height: h / 50,
                        ),
                        const Text("0"),
                        SizedBox(
                          height: h / 50,
                        ),
                        const Text("0"),
                        SizedBox(
                          height: h / 50,
                        ),
                        const Text("0"),
                        SizedBox(
                          height: h / 50,
                        ),
                        const Text("0"),
                        SizedBox(
                          height: h / 50,
                        ),

                        Obx(() => chekoutt.isAddress.value == true
                            ? Text("${chekoutt.dddeliveryfee[0]["data"]}")
                            : const SizedBox()),
                        SizedBox(
                          height: h / 50,
                        ),
                        // Text("${widget.paltformfee}"),
                        // SizedBox(height: h / 50,),
                        Text(
                            "${(widget.totalamount + widget.paltformfee).toStringAsFixed(2)}"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: h / 70,
            ),
            ElevatedButton(
                style: buttonPrimary,
                onPressed: () async {
                  var rtr = widget.totalamount + widget.paltformfee;
                  await chekoutt.orderpalce(rtr, Ordernote.text.toString());
                  Get.to(const OrderSuccess());
                },
                child:
                    Text("Confirm order", style: A_style_text_inside_button)),
          ],
        ),
      ),
    );
  }

  TextEditingController promocode = TextEditingController();
  TextEditingController Ordernote = TextEditingController();
}
