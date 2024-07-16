import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/productdeatils.dart';

import '../../Api/Addcart.dart';
import '../../Api/orderplaced_api.dart';
import '../../Api/productlistbysubsubcat.dart';
import '../../Api/wishlist.dart';
import '../../Controller/text2.dart';
import '../../main.dart';
import '../../ulits/constant.dart';
import 'selectaddress.dart';

final cartlist = Get.put(Addcart());

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final checkout = Get.put(orderplaced());
  String? selectedBagItem;
  final wishh = Get.put(wishlist_api());

  final List<String> _dropdownQuantity = [
    '1',
    '2',
    '3',
    '4',
    '5',
    "6",
    '7',
    '8',
    '9',
    '10',
  ];
  bool qq = false;

  void _toggleQQ() {
    setState(() {
      qq = !qq;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Bag",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Amazon_bold",
            fontSize: 20,
          ),
        ),
        actions: [
          qq == false
              ? IconButton(
                  onPressed: () {
                    _toggleQQ();
                  },
                  icon: const Icon(Icons.more_vert_outlined))
              : Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Container(
                    width: w / 10,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    padding: const EdgeInsets.only(left: 18),
                    child: GestureDetector(
                        onTap: () {
                          _toggleQQ();
                        },
                        child: const Icon(Icons.close)),
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: Stream.periodic(const Duration(
            milliseconds: 0,
          )).asyncMap((i) => cartlist.cartlistinnt()),
          builder: (context, snapshot) {
            if (cartlist.cartlistt.isNotEmpty) {
              cartlist.totalSalePrice.value = 0.0;
              cartlist.totalunitPrice.value = 0.0;
              List<dynamic> products =
                  cartlist.cartlistt[0]['data'][0]['products'];
              for (var product in products) {
                print("$product");
                cartlist.totalSalePrice.value += double.parse(
                        product['productId']['sale_price'].toString()) *
                    product["qty"];
                cartlist.totalunitPrice.value +=
                    product['productId']['unit_price'] * product["qty"];
              }
            }
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(color: logocolo),
                  )
                : Obx(() => cartlist.cartlistt.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: h / 5,
                          ),
                          Center(
                              child: Image.asset(
                                  "assets/images/Animation - 1716016516986.gif")),
                        ],
                      )
                    : qq == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: darkomdee.darkomde == true
                                        ? Colors.black
                                        : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 3)
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${cartlist.cartlistt[0]["data"][0]["products"].length} items: Total ",
                                      style: TextStyle(
                                          //letterSpacing: 1.5,
                                          //color: Colors.white,
                                          color: darkomdee.darkomde == true
                                              ? Colors.white
                                              : Colors.grey.shade700,
                                          fontFamily: "Amazon_med",
                                          fontSize: 14),
                                    ),
                                    Text(
                                      "${cartlist.totalSalePrice.value.toStringAsFixed(2)} CFA",
                                      style: TextStyle(
                                          //letterSpacing: 1.5,
                                          //color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          color: darkomdee.darkomde == true
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: "Amazon_med",
                                          fontSize: 14),
                                    ),
                                    Text(
                                      " (excluding delivery)",
                                      style: TextStyle(
                                          //letterSpacing: 1.5,
                                          //color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          color: darkomdee.darkomde == true
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: "Amazon_med",
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, left: 8, top: 12),
                                child: ListView.builder(
                                    itemCount: cartlist
                                        .cartlistt[0]["data"][0]["products"]
                                        .length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      //  cartlist.selectedsize.value= RxList.generate( cartlist.cartlistt[0]["data"][0]["products"].length, (index) => cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["size"][0]);
                                      print(cartlist.selectedsize);
                                      return Row(
                                        children: [
                                          Obx(() => Checkbox(
                                                focusColor: logocolo,
                                                activeColor: logocolo,
                                                checkColor: Colors.white,
                                                value: cartlist
                                                    .mutipledeletelistcart
                                                    .contains(cartlist
                                                        .cartlistt[0]["data"][0]
                                                            ["products"][index]
                                                            ["productId"]["_id"]
                                                        .toString()),
                                                onChanged: (newValue) {
                                                  if (cartlist
                                                      .mutipledeletelistcart
                                                      .contains(cartlist
                                                          .cartlistt[0]["data"]
                                                              [0]["products"]
                                                              [index]
                                                              ["productId"]
                                                              ["_id"]
                                                          .toString())) {
                                                    cartlist
                                                        .mutipledeletelistcart
                                                        .remove(cartlist
                                                            .cartlistt[0]
                                                                ["data"][0]
                                                                ["products"]
                                                                [index]
                                                                ["productId"]
                                                                ["_id"]
                                                            .toString());
                                                  } else {
                                                    cartlist.mutipledelete(
                                                        cartlist.cartlistt[0]
                                                                ["data"][0]
                                                                ["products"]
                                                                [index]
                                                                ["productId"]
                                                                ["_id"]
                                                            .toString());
                                                  }

                                                  print(cartlist
                                                      .mutipledeletelistcart
                                                      .toString());
                                                },
                                              )),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(Product_deatils(
                                                    sourceName: "0",
                                                    shopid: cartlist
                                                        .cartlistt[0]["data"][0]
                                                            ["products"][index]
                                                            ["productId"]
                                                            ["venderId"]["_id"]
                                                        .toString(),
                                                    subsubcateid: cartlist
                                                        .cartlistt[0]["data"][0]
                                                            ["products"][index]
                                                            ["productId"]["_id"]
                                                        .toString(),
                                                  ));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          darkomdee.darkomde ==
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
                                                            blurRadius: 1)
                                                      ]),
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: Image.network(
                                                            "$image_url${cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["image1"].toString()}",
                                                            height: 200,
                                                            width: 80,
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          )),
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: w / 50,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              w / 2.5,
                                                                          child:
                                                                              Text(
                                                                            cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["product_name"].toString(),
                                                                            style: TextStyle(
                                                                                overflow: TextOverflow.ellipsis,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: darkomdee.darkomde == true ? Colors.white : Colors.black,
                                                                                fontFamily: "Amazon_med",
                                                                                fontSize: 16),
                                                                            maxLines:
                                                                                2,
                                                                          ),
                                                                        ),
                                                                        PopupMenuButton(
                                                                          onSelected:
                                                                              (value) async {
                                                                            print("gg$value");
                                                                            value == "Delete item"
                                                                                ? await cartlist.cartdelteinnt(cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["_id"].toString())
                                                                                : null;
                                                                            setState(() {});
                                                                          },
                                                                          color:
                                                                              Colors.white,
                                                                          surfaceTintColor:
                                                                              Colors.white,
                                                                          initialValue:
                                                                              selectedBagItem,
                                                                          icon:
                                                                              Icon(
                                                                            Icons.more_horiz,
                                                                            color: darkomdee.darkomde == true
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                          ),
                                                                          itemBuilder:
                                                                              (_) {
                                                                            return <PopupMenuEntry<String>>[
                                                                              PopupMenuItem<String>(
                                                                                height: h / 25,
                                                                                value: 'Delete item',
                                                                                child: const Row(
                                                                                  children: [
                                                                                    Text("Delete item"),
                                                                                    Spacer(),
                                                                                    Icon(
                                                                                      Icons.delete,
                                                                                      size: 20,
                                                                                      color: Colors.black,
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              const PopupMenuDivider(),
                                                                              PopupMenuItem<String>(
                                                                                height: h / 25,
                                                                                value: 'Send to wish list',
                                                                                child: const Row(
                                                                                  children: [
                                                                                    Text("Send to wish list"),
                                                                                    Spacer(),
                                                                                    Icon(
                                                                                      Icons.favorite_border,
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
                                                                    Text(
                                                                      cartlist
                                                                          .cartlistt[
                                                                              0]
                                                                              [
                                                                              "data"]
                                                                              [
                                                                              0]
                                                                              [
                                                                              "products"]
                                                                              [
                                                                              index]
                                                                              [
                                                                              "productId"]
                                                                              [
                                                                              "venderId"]
                                                                              [
                                                                              "shop_name"]
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color: darkomdee.darkomde == true
                                                                              ? Colors
                                                                                  .white
                                                                              : Colors
                                                                                  .black,
                                                                          fontFamily:
                                                                              "Amazon_med",
                                                                          fontSize:
                                                                              16),
                                                                      maxLines:
                                                                          2,
                                                                    ),
                                                                    SizedBox(
                                                                      height: h /
                                                                          100,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          h / 10,
                                                                      width:
                                                                          w / 2,
                                                                      child: GridView
                                                                          .builder(
                                                                        itemBuilder:
                                                                            (context,
                                                                                indexxx) {
                                                                          // if(  proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["attributes"]!.isNotEmpty
                                                                          // ){
                                                                          //
                                                                          //   Addcart_api.selectedarr
                                                                          //       .add({
                                                                          //     "name":proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["attributes"][index] ["attribute_name"].toString(),
                                                                          //     "value": proddea.inntsubsubCateproddeta[0]["data"][0]["attributes"][index]["attribute_values"][0].toString(),
                                                                          //   });
                                                                          //   // innn=  Addcart_api.selectedarr .indexWhere((element) =>element["attribute_name"] ==
                                                                          //   //     proddea.inntsubsubCateproddeta.elementAt(0)["data"].elementAt(0)["attributes"][index] ["attribute_name"]);
                                                                          //
                                                                          // }
                                                                          return cartlist.cartlistt[0]["data"][0]["products"][index]["attributes"]!.isEmpty
                                                                              ? const SizedBox()
                                                                              : Container(
                                                                                  height: h / 20,
                                                                                  padding: const EdgeInsets.only(left: 4),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black12, width: 1)),
                                                                                  child: droop(
                                                                                    index: index,
                                                                                    indexxx: indexxx,
                                                                                  ));
                                                                        },
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount: cartlist
                                                                            .cartlistt[0]["data"][0]["products"][index]["attributes"]
                                                                            .length,
                                                                        gridDelegate:
                                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              3,
                                                                          crossAxisSpacing:
                                                                              5,
                                                                          childAspectRatio:
                                                                              (MediaQuery.of(context).size.width / 5) / (MediaQuery.of(context).size.height / 20),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Obx(() =>
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              height: h / 20,
                                                                              padding: const EdgeInsets.only(left: 4),
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black12, width: 1)),
                                                                              child: DropdownButton(
                                                                                iconEnabledColor: darkomdee.darkomde == true ? Colors.white : Colors.black,
                                                                                dropdownColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
                                                                                underline: const SizedBox(),
                                                                                value: cartlist.cartlistt[0]["data"][0]["products"][index]['qty'].toString(),
                                                                                items: _dropdownQuantity.map((String item) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: item,
                                                                                    child: Text("Quantity $item", style: TextStyle(fontSize: 12, color: darkomdee.darkomde == true ? Colors.white : Colors.black)),
                                                                                  );
                                                                                }).toList(),
                                                                                onChanged: (String? newValue) {
                                                                                  List<Map<String, dynamic>> kkk = [];
                                                                                  kkk.clear();

                                                                                  kkk.add({
                                                                                    "productId": cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["_id"],
                                                                                    "qty": newValue
                                                                                  });
                                                                                  print("hgghg$kkk");

                                                                                  cartlist.addcartupdated(kkk, cartlist.cartlistt[0]["data"][0]["_id"]);
                                                                                  setState(() {
                                                                                    // _selectedColor = newValue!;
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                    SizedBox(
                                                                      height: h /
                                                                          100,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "${cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["sale_price"].toString()}  CFA",
                                                                          style: const TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 16,
                                                                              fontFamily: "Amazon_med"),
                                                                        ),
                                                                        Text(
                                                                          "${cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["unit_price"].toString()} CFA",
                                                                          style: const TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 16,
                                                                              decoration: TextDecoration.lineThrough,
                                                                              decorationColor: Colors.grey,
                                                                              fontFamily: "Amazon_med"),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              w / 40,
                                                                        ),
                                                                        Text(
                                                                          "${cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["discount"][0]["discount_value"].toString()}  ${cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["discount"][0]["discount_type"].toString() == "Percent off" ? "%" : "CFA"} ",
                                                                          style:
                                                                              const TextStyle(
                                                                            fontFamily:
                                                                                "Ember_Bold",
                                                                            color:
                                                                                Colors.red,
                                                                            fontSize:
                                                                                18,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
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
                                                height: h / 70,
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: Colors.white,
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0,
                                        left: 8,
                                        bottom: 15,
                                        top: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              const Text("Sub Total"),
                                              SizedBox(
                                                height: h / 50,
                                              ),
                                              const Text("Discount"),
                                              SizedBox(
                                                height: h / 50,
                                              ),
                                              const Text("Total"),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(cartlist.totalunitPrice.value
                                                  .toStringAsFixed(2)),
                                              SizedBox(
                                                height: h / 50,
                                              ),
                                              const Text("Sub Total"),
                                              SizedBox(
                                                height: h / 50,
                                              ),
                                              Text(cartlist.totalSalePrice.value
                                                  .toStringAsFixed(2)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: darkomdee.darkomde == true
                                        ? Colors.black
                                        : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 3)
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${cartlist.cartlistt[0]["data"][0]["products"].length} items: Total ",
                                      style: TextStyle(
                                          //letterSpacing: 1.5,
                                          //color: Colors.white,
                                          color: darkomdee.darkomde == true
                                              ? Colors.white
                                              : Colors.grey.shade700,
                                          fontFamily: "Amazon_med",
                                          fontSize: 14),
                                    ),
                                    Text(
                                      "${cartlist.totalSalePrice.value.toStringAsFixed(2)} CFA",
                                      style: TextStyle(
                                          //letterSpacing: 1.5,
                                          //color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          color: darkomdee.darkomde == true
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: "Amazon_med",
                                          fontSize: 14),
                                    ),
                                    Text(
                                      " (excluding delivery)",
                                      style: A_style_mid,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, left: 8, top: 12),
                                child: ListView.builder(
                                    itemCount: cartlist
                                        .cartlistt[0]["data"][0]["products"]
                                        .length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      cartlist.selectedsize.value =
                                          RxList.generate(
                                              cartlist
                                                  .cartlistt[0]["data"][0]
                                                      ["products"]
                                                  .length,
                                              (index) => cartlist.cartlistt[0]
                                                      ["data"][0]["products"]
                                                  [index]["size"]);
                                      print(cartlist.selectedsize);
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(Product_deatils(
                                                sourceName: "0",
                                                shopid: cartlist.cartlistt[0]
                                                        ["data"][0]["products"]
                                                        [index]["productId"]
                                                        ["venderId"]["_id"]
                                                    .toString(),
                                                subsubcateid: cartlist
                                                    .cartlistt[0]["data"][0]
                                                        ["products"][index]
                                                        ["productId"]["_id"]
                                                    .toString(),
                                              ));
                                            },
                                            child: Dismissible(
                                              direction:
                                                  DismissDirection.endToStart,
                                              onDismissed: (direction) async {
                                                await cartlist.cartdelteinnt(
                                                    cartlist.cartlistt[0]
                                                            ["data"][0]
                                                            ["products"][index]
                                                            ["productId"]["_id"]
                                                        .toString());
                                                setState(() {});
                                              },
                                              key: Key(index.toString()),
                                              background: Container(
                                                color: Colors.red.shade700,
                                                child: const Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.0),
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 35,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              child: Container(
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
                                                          blurRadius: 1)
                                                    ]),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 200,
                                                      width: 100,
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: Image.network(
                                                            "$image_url${cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["image1"].toString()}",
                                                            height: 200,
                                                            width: 100,
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          )),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: w / 50,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: w /
                                                                            2.9,
                                                                        child:
                                                                            Text(
                                                                          cartlist
                                                                              .cartlistt[0]["data"][0]["products"][index]["productId"]["product_name"]
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              //letterSpacing: 1.5,
                                                                              //color: Colors.white,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: darkomdee.darkomde == true ? Colors.white : Colors.black,
                                                                              fontFamily: "Amazon_med",
                                                                              fontSize: 16),
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: w /
                                                                            7.5,
                                                                      ),
                                                                      PopupMenuButton(
                                                                        onSelected:
                                                                            (value) async {
                                                                          print(
                                                                              "gg$value");
                                                                          value == "Delete item"
                                                                              ? await cartlist.cartdelteinnt(cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["_id"].toString())
                                                                              : null;
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        color: Colors
                                                                            .white,
                                                                        surfaceTintColor:
                                                                            Colors.white,
                                                                        initialValue:
                                                                            selectedBagItem,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .more_horiz,
                                                                          color: darkomdee.darkomde == true
                                                                              ? Colors.white
                                                                              : Colors.black,
                                                                        ),
                                                                        itemBuilder:
                                                                            (_) {
                                                                          return <PopupMenuEntry<
                                                                              String>>[
                                                                            PopupMenuItem<String>(
                                                                              height: h / 25,
                                                                              value: 'Delete item',
                                                                              child: const Row(
                                                                                children: [
                                                                                  Text("Delete item"),
                                                                                  Spacer(),
                                                                                  Icon(
                                                                                    Icons.delete,
                                                                                    size: 20,
                                                                                    color: Colors.black,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            const PopupMenuDivider(),
                                                                            PopupMenuItem<String>(
                                                                              onTap: () async {
                                                                                await wishh.wishlike1(cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["_id"].toString());
                                                                                await cartlist.cartdelteinnt(cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["_id"].toString());

                                                                                setState(() {});
                                                                              },
                                                                              height: h / 25,
                                                                              value: 'Send to wish list',
                                                                              child: const Row(
                                                                                children: [
                                                                                  Text("Send to wish list"),
                                                                                  Spacer(),
                                                                                  Icon(
                                                                                    Icons.favorite_border,
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
                                                                  Text(
                                                                    cartlist
                                                                        .cartlistt[
                                                                            0][
                                                                            "data"]
                                                                            [0][
                                                                            "products"]
                                                                            [
                                                                            index]
                                                                            [
                                                                            "productId"]
                                                                            [
                                                                            "venderId"]
                                                                            [
                                                                            "shop_name"]
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: darkomdee.darkomde ==
                                                                                true
                                                                            ? Colors
                                                                                .white
                                                                            : Colors
                                                                                .black,
                                                                        fontFamily:
                                                                            "Amazon_med",
                                                                        fontSize:
                                                                            16),
                                                                    maxLines: 2,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        h / 100,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        h / 10,
                                                                    width:
                                                                        w / 2,
                                                                    child: GridView
                                                                        .builder(
                                                                      itemBuilder:
                                                                          (context,
                                                                              indexxx) {
                                                                        return cartlist.cartlistt[0]["data"][0]["products"][index]["attributes"]!.isEmpty
                                                                            ? const SizedBox()
                                                                            : Container(
                                                                                height: h / 20,
                                                                                padding: const EdgeInsets.only(left: 4),
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black12, width: 1)),
                                                                                child: droop(
                                                                                  index: index,
                                                                                  indexxx: indexxx,
                                                                                ));
                                                                      },
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount: cartlist
                                                                          .cartlistt[
                                                                              0]
                                                                              [
                                                                              "data"]
                                                                              [
                                                                              0]
                                                                              [
                                                                              "products"]
                                                                              [
                                                                              index]
                                                                              [
                                                                              "attributes"]
                                                                          .length,
                                                                      gridDelegate:
                                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                                        crossAxisCount:
                                                                            3,
                                                                        crossAxisSpacing:
                                                                            5,
                                                                        childAspectRatio: (MediaQuery.of(context).size.width /
                                                                                5) /
                                                                            (MediaQuery.of(context).size.height /
                                                                                20),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Obx(() => Row(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                h / 20,
                                                                            padding:
                                                                                const EdgeInsets.only(left: 4),
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black12, width: 1)),
                                                                            child:
                                                                                DropdownButton(
                                                                              iconEnabledColor: darkomdee.darkomde == true ? Colors.white : Colors.black,
                                                                              dropdownColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
                                                                              underline: const SizedBox(),
                                                                              value: cartlist.cartlistt[0]["data"][0]["products"][index]['qty'].toString(),
                                                                              items: _dropdownQuantity.map((String item) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: item,
                                                                                  child: Text("Quantity $item", style: TextStyle(color: darkomdee.darkomde == true ? Colors.white : Colors.black, fontSize: 12)),
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (String? newValue) {
                                                                                List<Map<String, dynamic>> kkk = [];
                                                                                kkk.clear();

                                                                                kkk.add({
                                                                                  "productId": cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["_id"],
                                                                                  "qty": newValue
                                                                                });
                                                                                print("hgghg$kkk");

                                                                                cartlist.addcartupdated(kkk, cartlist.cartlistt[0]["data"][0]["_id"]);
                                                                                setState(() {
                                                                                  // _selectedColor = newValue!;
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),
                                                                  SizedBox(
                                                                    height:
                                                                        h / 100,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "${(cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["sale_price"] * cartlist.cartlistt[0]["data"][0]["products"][index]["qty"]).toStringAsFixed(2)}  CFA",
                                                                        style: TextStyle(
                                                                            color: darkomdee.darkomde == true
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                            fontSize: 16,
                                                                            fontFamily: "Amazon_med"),
                                                                      ),
                                                                      Text(
                                                                        "${(cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["unit_price"] * cartlist.cartlistt[0]["data"][0]["products"][index]["qty"]).toStringAsFixed(2)} CFA",
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .grey,
                                                                            fontSize:
                                                                                16,
                                                                            decoration:
                                                                                TextDecoration.lineThrough,
                                                                            decorationColor: Colors.grey,
                                                                            fontFamily: "Amazon_med"),
                                                                      ),
                                                                      SizedBox(
                                                                        width: w /
                                                                            40,
                                                                      ),
                                                                      Text(
                                                                        "-${cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["discount"][0]["discount_value"].toString()} ${cartlist.cartlistt[0]["data"][0]["products"][index]["productId"]["discount"][0]["discount_type"].toString() == "Percent off".toString() ? "%" : "CFA"} ",
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              "Ember_Bold",
                                                                          color: darkomdee.darkomde == true
                                                                              ? Colors.white
                                                                              : Colors.red,
                                                                          fontSize:
                                                                              18,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
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
                                          ),
                                          SizedBox(
                                            height: h / 70,
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: Colors.white,
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0,
                                        left: 8,
                                        bottom: 15,
                                        top: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("Sub Total"),
                                              SizedBox(
                                                height: h / 50,
                                              ),
                                              const Text("Discount"),
                                              SizedBox(
                                                height: h / 50,
                                              ),
                                              const Text("Total"),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(cartlist.totalunitPrice.value
                                                  .toStringAsFixed(2)),
                                              SizedBox(
                                                height: h / 50,
                                              ),
                                              Text((double.parse(cartlist
                                                          .totalunitPrice.value
                                                          .toStringAsFixed(2)) -
                                                      double.parse(cartlist
                                                          .totalSalePrice.value
                                                          .toStringAsFixed(2)))
                                                  .toStringAsFixed(2)),
                                              SizedBox(
                                                height: h / 50,
                                              ),
                                              Text(cartlist.totalSalePrice.value
                                                  .toStringAsFixed(2)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ));
          },
        ),
      ),
      bottomNavigationBar: Obx(() => cartlist.cartlistt.isEmpty
          ? const SizedBox()
          : qq == false
              ? Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  height: h / 13,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: InkWell(
                    onTap: () async {
                      checkout.checkoutlist.clear();
                      await cartlist.cartlistt[0]["data"]
                          .elementAt(0)["products"]
                          .forEach((elem) {
                        print("ffff$elem");
                        checkout.checkoutlist.add(elem["productId"]["_id"]);
                      });
                      List<Map<String, dynamic>> kkk = [];
                      for (var element1 in checkout.checkoutlist) {
                        var ijjj = cartlist.cartlistt[0]["data"][0]["products"]
                            .indexWhere((element) =>
                                element["productId"]["_id"] == element1);
                        print(
                            "fdsgjg ${cartlist.cartlistt[0]["data"][0]["products"][ijjj]["attributes"]}");
                        kkk.add({
                          "productId": element1,
                          "qty": cartlist.cartlistt[0]["data"][0]["products"]
                              [ijjj]["qty"],
                          "attributes": cartlist.cartlistt[0]["data"][0]
                                  ["products"][ijjj]["attributes"]
                              .map((attribute) {
                            Map<String, dynamic> newAttribute =
                                Map.from(attribute);
                            print("jgjoggj $newAttribute");
                            newAttribute.remove('_id');
                            return newAttribute;
                          }).toList(),
                          "shop_name": cartlist.cartlistt[0]["data"][0]
                                  ["products"][ijjj]["productId"]["venderId"]
                              ["shop_name"],
                          "product_name": cartlist.cartlistt[0]["data"][0]
                              ["products"][ijjj]["productId"]["product_name"],
                          "shopId": cartlist.cartlistt[0]["data"][0]["products"]
                              [ijjj]["productId"]["venderId"]["_id"],
                          "image": cartlist.cartlistt[0]["data"][0]["products"]
                              [ijjj]["productId"]["image1"],
                          "shipping_charge": "0",
                          "tax": cartlist.cartlistt[0]["data"][0]["products"]
                              [ijjj]["productId"]["Tax"][0]["tax_value"],
                          "discount": cartlist.cartlistt[0]["data"][0]
                                  ["products"][ijjj]["productId"]["discount"][0]
                              ["discount_value"],
                          "subtotal": (cartlist.cartlistt[0]["data"][0]
                                          ["products"][ijjj]["productId"]
                                      ["sale_price"] *
                                  cartlist.cartlistt[0]["data"][0]["products"]
                                      [ijjj]["qty"])
                              .toString(),
                          "total": (cartlist.cartlistt[0]["data"][0]["products"]
                                      [ijjj]["productId"]["sale_price"] *
                                  cartlist.cartlistt[0]["data"][0]["products"]
                                      [ijjj]["qty"])
                              .toString()
                        });
                        print("jjjjrree$ijjj $kkk ");
                      }

                      print(checkout.checkoutlist.toString());
                      await checkout.checkout(
                        cartlist.totalSalePrice.value,
                        0,
                        kkk,
                        cartlist.cartlistt[0]["data"][0]["products"].length,
                      );
                      print(
                          "hgf${cartlist.totalSalePrice.value.toStringAsFixed(2)}");
                      Get.to(Selectedaddress(
                          totalamount: cartlist.totalSalePrice.value,
                          paltformfee: cartlist.cartlistt[0]["charge"]
                                  ["commission"] ??
                              "0"));

                      // Get.to( CheckOutScreen(deliveryfee: cartlist.cartlistt[0]["charge"]["delivery_charge"],totalamount: cartlist.totalSalePrice.value, paltformfee:  cartlist.cartlistt[0]["charge"]["commission"] ));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: logocolo,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "Check out",
                          style: A_style_text_inside_button,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await cartlist.cartsavedselcted();
                          await cartlist.cartdeleteselcted();
                          setState(() {
                            qq = false;
                          });
                          cartlist.mutipledeletelistcart.clear();
                        },
                        child: Container(
                          width: w / 2.7,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                              Text(
                                "Save",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontFamily: "Amazon_med",
                                    fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await cartlist.cartdeleteselcted();
                          setState(() {
                            qq = false;
                          });
                          cartlist.mutipledeletelistcart.clear();
                        },
                        child: Container(
                          width: w / 2.7,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.red.shade700,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                              ),
                              Text(
                                "Delete",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontFamily: "Amazon_med",
                                    fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }

  Future onRefresh() async {
    await cartlist.cartlistinnt();
    setState(() {});
  }
}

class droop extends StatefulWidget {
  final index;
  final indexxx;
  const droop({super.key, this.index, this.indexxx});

  @override
  State<droop> createState() => _droopState();
}

class _droopState extends State<droop> {
  final proddea = Get.put(fetchInntsubsubCategoryproductList());
  final wishl = Get.put(wishlist_api());
  final Addcart_api = Get.put(Addcart());
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      iconEnabledColor:
          darkomdee.darkomde == true ? Colors.white : Colors.black,
      dropdownColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      underline: const SizedBox(),
      hint: Text(
          "Select ${cartlist.cartlistt[0]["data"][0]["products"][widget.index]["attributes"][widget.indexxx]["name"]}"),
      value: cartlist.cartlistt[0]["data"][0]["products"][widget.index]
          ["attributes"][widget.indexxx]["value"],
      items: (cartlist.cartlistt[0]["data"][0]["products"][widget.index]
                  ["productId"]["product_variation"][widget.indexxx]
              ["attribute_values"] as List<dynamic>)
          .map<DropdownMenuItem<String>>((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item,
              style: TextStyle(
                  fontSize: 12,
                  color: darkomdee.darkomde == true
                      ? Colors.white
                      : Colors.black)),
        );
      }).toList(),
      onChanged: (newValue) {
        List<Map<String, dynamic>> kkk = [];
        List attributesWithoutId = cartlist.cartlistt[0]["data"][0]["products"]
                [widget.index]["attributes"]
            .map((attribute) {
          Map<String, dynamic> newAttribute = Map.from(attribute);
          print("jgjoggj $newAttribute");
          newAttribute.remove('_id');
          return newAttribute;
        }).toList();
        kkk.clear();
        print("djfiiojg $attributesWithoutId");

        attributesWithoutId[widget.indexxx]["value"] = newValue;

        kkk.add({
          "productId": cartlist.cartlistt[0]["data"][0]["products"]
              [widget.index]["productId"]["_id"],
          "attributes": attributesWithoutId,
          "qty": cartlist.cartlistt[0]["data"][0]["products"][widget.index]
              ['qty']
        });
        print("hgghg$kkk");
        //[{"name":"${cartlist.cartlistt[0]["data"][0]["products"][widget.index] ["attributes"] [widget.indexxx] ["name"]}","value":"${newValue}"}],
        cartlist.addcartupdated(kkk, cartlist.cartlistt[0]["data"][0]["_id"]);
        // Addcart_api.selectedarr[widget.index]["value"]=newValue.toString();
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
