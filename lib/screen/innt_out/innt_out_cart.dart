import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/innt_out/selectaddress.dart';

import '../../Api/Addcart.dart';
import '../../Api/orderplaced_api.dart';
import '../../Controller/text2.dart';
import '../../ulits/constant.dart';
import '../Users/cart_screen.dart';
import 'innt_out_productdetails.dart';

class InntOutCartScreen extends StatefulWidget {
  const InntOutCartScreen({super.key});

  @override
  State<InntOutCartScreen> createState() => _InntOutCartScreenState();
}

class _InntOutCartScreenState extends State<InntOutCartScreen> {
  final bool _isLoading = false;
  final checkout = Get.put(orderplaced());
  String selectedBagItem = 'Delete item';
  final String _selectedItem = 'Unit';
  final List<String> _dropdownItems = [
    'Unit',
    'Kilogram',
    'Gram',
  ];

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

  final cartlist = Get.put(Addcart());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: secondryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Bag",
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: Stream.periodic(const Duration(
            milliseconds: 0,
          )).asyncMap((i) => cartlist.cartlistinntout()),

//    FutureBuilder(future: cartlist.cartlistinntout(),builder: (context, snapshot) {
          builder: (context, snapshot) {
            if (cartlist.cartlisttinnout.isNotEmpty) {
              cartlist.totalSalePrice.value = 0.0;
              cartlist.totalunitPrice.value = 0.0;
              List<dynamic> products =
                  cartlist.cartlisttinnout[0]['data'][0]['products'];
              for (var product in products) {
                print("ddd$product");
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
                : cartlist.cartlisttinnout.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: h / 5,
                          ),
                          Center(
                            child: Image.asset(
                              "assets/images/Animation - 1716016516986.gif",
                              color: secondryColor,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade50,
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
                                  "${cartlist.cartlisttinnout[0]["data"][0]["products"].length} items: Total ",
                                  style: A_style_mid,
                                ),
                                Text(
                                  " \$${cartlist.totalSalePrice.value.toStringAsFixed(2)} ",
                                  style: A_style_mid_black,
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
                                    .cartlisttinnout[0]["data"][0]["products"]
                                    .length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(InntoutProduct_deatils(
                                            shopid: cartlist.cartlisttinnout[0]
                                                    ["data"][0]["products"]
                                                    [index]["productId"]
                                                    ["venderId"]["_id"]
                                                .toString(),
                                            subsubcateid: cartlist
                                                .cartlisttinnout[0]["data"][0]
                                                    ["products"][index]
                                                    ["productId"]["_id"]
                                                .toString(),
                                          ));
                                        },
                                        child: Dismissible(
                                          key: Key(index.toString()),
                                          onDismissed: (direction) async {
                                            await cartlist.Inntoutcarddelete(
                                                cartlist.cartlisttinnout[0]
                                                        ["data"][0]["products"]
                                                        [index]["productId"]
                                                        ["_id"]
                                                    .toString());
                                            setState(() {});
                                          },
                                          direction:
                                              DismissDirection.endToStart,
                                          background: Container(
                                            color: Colors.red.shade700,
                                            child: const Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
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
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade300,
                                                      blurRadius: 1)
                                                ]),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: Image.network(
                                                            "$image_url${cartlist.cartlisttinnout[0]["data"][0]["products"][index]["productId"]["image1"].toString()}",
                                                            height: 100,
                                                            width: 100,
                                                            fit: BoxFit.cover,
                                                          )),
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
                                                                width: w / 2.9,
                                                                child: Text(
                                                                  cartlist
                                                                      .cartlisttinnout[
                                                                          0][
                                                                          "data"]
                                                                          [0][
                                                                          "products"]
                                                                          [
                                                                          index]
                                                                          [
                                                                          "productId"]
                                                                          [
                                                                          "product_name"]
                                                                      .toString(),
                                                                  style:
                                                                      A_style_medium,
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: w / 7.5,
                                                              ),
                                                              PopupMenuButton(
                                                                color: Colors
                                                                    .white,
                                                                surfaceTintColor:
                                                                    Colors
                                                                        .white,
                                                                icon:
                                                                    const Icon(
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
                                                                          () async {
                                                                        await cartlist.Inntoutcarddelete(cartlist
                                                                            .cartlisttinnout[0]["data"][0]["products"][index]["productId"]["_id"]
                                                                            .toString());
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      height:
                                                                          h / 25,
                                                                      value:
                                                                          'Delete item',
                                                                      child:
                                                                          const Row(
                                                                        children: [
                                                                          Text(
                                                                              "Delete item"),
                                                                          Spacer(),
                                                                          Icon(
                                                                            Icons.delete,
                                                                            size:
                                                                                20,
                                                                            color:
                                                                                Colors.black,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    // PopupMenuDivider(),
                                                                    // PopupMenuItem<String>(
                                                                    //   height: h / 25,
                                                                    //   value:
                                                                    //   'Send to wish list',
                                                                    //   child: Row(
                                                                    //     children: [
                                                                    //       const Text(
                                                                    //           "Send to wish list"),
                                                                    //       Spacer(),
                                                                    //       const Icon(
                                                                    //         Icons
                                                                    //             .favorite_border,
                                                                    //         size: 20,
                                                                    //         color: Colors.black,
                                                                    //       )
                                                                    //     ],
                                                                    //   ),
                                                                    // ),
                                                                  ];
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            cartlist
                                                                .cartlisttinnout[
                                                                    0]["data"]
                                                                    [0]
                                                                    ["products"]
                                                                    [index][
                                                                    "productId"]
                                                                    ["venderId"]
                                                                    [
                                                                    "shop_name"]
                                                                .toString(),
                                                            style:
                                                                A_style_medium,
                                                            maxLines: 2,
                                                          ),
                                                          SizedBox(
                                                            height: h / 100,
                                                          ),
                                                          SizedBox(
                                                            height: h / 10,
                                                            width: w / 2,
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
                                                                return cartlist
                                                                        .cartlisttinnout[
                                                                            0][
                                                                            "data"]
                                                                            [0]
                                                                            ["products"]
                                                                            [index][
                                                                            "attributes"]!
                                                                        .isEmpty
                                                                    ? const SizedBox()
                                                                    : Container(
                                                                        height:
                                                                            h /
                                                                                20,
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                4),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            border: Border.all(color: Colors.black12, width: 1)),
                                                                        child: drooop(
                                                                          index:
                                                                              index,
                                                                          indexxx:
                                                                              indexxx,
                                                                        ));
                                                              },
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount: cartlist
                                                                  .cartlisttinnout[
                                                                      0]["data"]
                                                                      [0][
                                                                      "products"]
                                                                      [index][
                                                                      "attributes"]
                                                                  .length,
                                                              gridDelegate:
                                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3,
                                                                crossAxisSpacing:
                                                                    5,
                                                                mainAxisSpacing:
                                                                    5,
                                                                childAspectRatio: (MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        5) /
                                                                    (MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        20),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: h / 100,
                                                          ),
                                                          Row(
                                                            children: [
                                                              // Container(
                                                              //   height: h / 20,
                                                              //   padding: const EdgeInsets.only(
                                                              //       left: 4),
                                                              //   decoration: BoxDecoration(
                                                              //       borderRadius:
                                                              //       BorderRadius.circular(
                                                              //           5),
                                                              //       border: Border.all(
                                                              //           color: Colors.black12,
                                                              //           width: 1)),
                                                              //   child: DropdownButton<String>(
                                                              //     underline: const SizedBox(),
                                                              //     value: _selectedItem,
                                                              //     items: _dropdownItems
                                                              //         .map((String item) {
                                                              //       return DropdownMenuItem<
                                                              //           String>(
                                                              //         value: item,
                                                              //         child: Text(item,
                                                              //             style: TextStyle(
                                                              //                 fontSize: 12)),
                                                              //       );
                                                              //     }).toList(),
                                                              //     onChanged:
                                                              //         (String? newValue) {
                                                              //       setState(() {
                                                              //         _selectedItem = newValue!;
                                                              //       });
                                                              //     },
                                                              //   ),
                                                              // ),
                                                              SizedBox(
                                                                width: w / 40,
                                                              ),
                                                              Container(
                                                                height: h / 20,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            4),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                5),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            1)),
                                                                child:
                                                                    DropdownButton<
                                                                        String>(
                                                                  underline:
                                                                      const SizedBox(),
                                                                  value: cartlist
                                                                      .cartlisttinnout[
                                                                          0][
                                                                          "data"]
                                                                          [0][
                                                                          "products"]
                                                                          [
                                                                          index]
                                                                          [
                                                                          'qty']
                                                                      .toString(),
                                                                  items: _dropdownQuantity
                                                                      .map((String
                                                                          item) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          item,
                                                                      child: Text(
                                                                          "Quantity $item",
                                                                          style:
                                                                              const TextStyle(fontSize: 12)),
                                                                    );
                                                                  }).toList(),
                                                                  onChanged:
                                                                      (String?
                                                                          newValue) {
                                                                    List<Map<String, dynamic>>
                                                                        kkk =
                                                                        [];
                                                                    kkk.clear();
                                                                    kkk.add({
                                                                      "productId":
                                                                          cartlist.cartlisttinnout[0]["data"][0]["products"][index]["productId"]
                                                                              [
                                                                              "_id"],
                                                                      "qty":
                                                                          newValue
                                                                    });
                                                                    print(
                                                                        "hgghg$kkk");
                                                                    cartlist.inntoutaddcartupdated(
                                                                        kkk,
                                                                        cartlist.cartlisttinnout[0]["data"][0]
                                                                            [
                                                                            "_id"]);
                                                                    setState(
                                                                        () {
                                                                      // _selectedColor = newValue!;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: h / 100,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "\$ ${cartlist.cartlisttinnout[0]["data"][0]["products"][index]["productId"]["sale_price"]} ",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "Amazon_med"),
                                                              ),
                                                              Text(
                                                                "\$ ${cartlist.cartlisttinnout[0]["data"][0]["products"][index]["productId"]["unit_price"]}",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    decorationColor:
                                                                        Colors
                                                                            .grey,
                                                                    fontFamily:
                                                                        "Amazon_med"),
                                                              ),
                                                              SizedBox(
                                                                width: w / 40,
                                                              ),
                                                              Text(
                                                                "${cartlist.cartlisttinnout[0]["data"][0]["products"][index]["productId"]["discount"][0]["discount_type"].toString() != "Percent" ? "\$" : ""}${cartlist.cartlisttinnout[0]["data"][0]["products"][index]["productId"]["discount"][0]["discount_value"].toString()}  ${cartlist.cartlisttinnout[0]["data"][0]["products"][index]["productId"]["discount"][0]["discount_type"].toString() == "Percent" ? "%" : ""} ",
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      "Ember_Bold",
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
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
                                    right: 8.0, left: 8, bottom: 15, top: 15),
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
                      );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        height: h / 13,
        decoration: const BoxDecoration(color: Colors.white),
        child: InkWell(
          onTap: () async {
            checkout.checkoutlist.clear();
            await cartlist.cartlisttinnout[0]["data"]
                .elementAt(0)["products"]
                .forEach((elem) {
              print("ffff$elem");
              checkout.checkoutlist.add(elem["productId"]["_id"]);
            });
            print(checkout.checkoutlist.toString());
            await checkout.checkoutinnout(cartlist.totalSalePrice.value, 0);
            print("hgf${cartlist.totalSalePrice.value.toStringAsFixed(2)}");
            Get.to(Selectedaddressinntout(
                totalamount: cartlist.totalSalePrice.value,
                paltformfee: cartlist.cartlisttinnout[0]["charge"]
                    ["commission"]));

            //   Get.to(inntoutCheckOutScreen(deliveryfee: cartlist.cartlisttinnout[0]["charge"]["delivery_charge"],totalamount: cartlist.totalSalePrice.value, paltformfee:  cartlist.cartlisttinnout[0]["charge"]["commission"] ));
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: secondryColor, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                "Check out",
                style: A_style_text_inside_button,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class drooop extends StatefulWidget {
  final index;
  final indexxx;
  const drooop({super.key, this.index, this.indexxx});

  @override
  State<drooop> createState() => _drooopState();
}

class _drooopState extends State<drooop> {
  final Addcart_api = Get.put(Addcart());
  @override
  Widget build(BuildContext context) {
    print("fddsfsdf  ${cartlist.cartlisttinnout}");
    return DropdownButton(
      isExpanded: true,
      underline: const SizedBox(),
      // hint: Text("Select ${ cartlist.cartlisttinnout[0]["data"][0]["products"][widget.index] ["attributes"] [widget.indexxx] ["name"]}"),
      value: cartlist.cartlisttinnout[0]["data"][0]["products"][widget.index]
          ["attributes"][widget.indexxx]["value"],
      items: (cartlist.cartlisttinnout[0]["data"][0]["products"][widget.index]
                  ["productId"]["product_variation"][widget.indexxx]
              ["attribute_values"] as List<dynamic>)
          .map<DropdownMenuItem<String>>((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item, style: const TextStyle(fontSize: 12)),
        );
      }).toList(),
      onChanged: (newValue) {
        List<Map<String, dynamic>> kkk = [];
        List attributesWithoutId = cartlist.cartlisttinnout[0]["data"][0]
                ["products"][widget.index]["attributes"]
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
          "productId": cartlist.cartlisttinnout[0]["data"][0]["products"]
              [widget.index]["productId"]["_id"],
          "attributes": attributesWithoutId,
          "qty": cartlist.cartlisttinnout[0]["data"][0]["products"]
              [widget.index]['qty']
        });
        print("hgghg$kkk");
        cartlist.inntoutaddcartupdated(
            kkk, cartlist.cartlisttinnout[0]["data"][0]["_id"]);

        setState(() {});

        print("ggdsd ${Addcart_api.selectedarr}");

        // gggg = newValue!;
      },
    );
  }
}
