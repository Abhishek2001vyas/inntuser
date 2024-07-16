import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/checkoutList.dart';
import '../screen/Users/myorder.dart';
import '../ulits/constant.dart';
import '../ulits/utils.dart';
import 'Addcart.dart';

class orderplaced extends GetxController {
  RxBool isAddress = false.obs;
  RxInt pay = 0.obs;
  RxString addressIds = "".obs;
  RxString addressIds1 = "".obs;
  RxString payTypes = "".obs;

  //var payType;
  var paymentMode;

  // RxInt isAddress = true.obs;
  //RxList selectaddressid = [].obs;
  RxList checkoutlist = [].obs;

  final cartlist = Get.put(Addcart());
  RxBool isloading = false.obs;
  RxList<CheckoutList> checkoutcartlistt = <CheckoutList>[].obs;
  RxList<CheckoutList> checkoutcartlisttinnout = <CheckoutList>[].obs;
  RxList OrderListlistt = [].obs;
  RxList Orderdeatilslistt = [].obs;
  RxString rating = "0".obs;
  RxList dddeliveryfee = [].obs;

  RxList<CheckoutList> checkoutcartlisttinntout = <CheckoutList>[].obs;
  RxList OrderListlisttinntout = [].obs;
  RxList Orderdeatilslisttinntout = [].obs;

  void loader() {
    isloading.value = true;
    update();
  }

  Future takeUserAddress() async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    dddeliveryfee.clear();
    print(
        "takeUserAddress${checkoutcartlistt.elementAt(0).data!.id.toString()}  ${addressIds.toString()}  ${userid.toString()}");

    try {
      var res = await http.post(Uri.parse("${base_url}takeUserAddress"), body: {
        "checkoutId": checkoutcartlistt.elementAt(0).data!.id.toString(),
        "addressId": addressIds.toString(),
        "userId": userid.toString(),
        "delivery_place": "Address",
      });
      print("ff$addressIds");
      var resData = json.decode(res.body);
      print("hjygjfgyhkj$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        dddeliveryfee.add(resData);
        print("fffftreryy" + resData);
        isloading.value = false;
      } else {
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      isloading.value = false;
      print("Error: $e");
    }
  }

  Future checkout(totalPrice, saveAmount, kkk, lengthh) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    log("dgffdgfdhf${cartlist.cartlistt}");

    print("dddd1$kkk");
    try {
      var res = await http.post(Uri.parse("${base_url}checkOut"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'userId': userid,
            "products": kkk,
            "total_item": lengthh,
            "save_amount": saveAmount,
            "total_price": totalPrice,
            "status": "0"
          }));
      var resData = json.decode(res.body);
      print("iuy$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print("oijdsijd");
        //print("ffff" + resData);
        isloading.value = false;
      } else {
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      isloading.value = false;
      print("Errorinnt: $e");
    }
  }

  Future checkoutinnout(totalPrice, saveAmount) async {
    List<Map<String, dynamic>> kkk = [];
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print("kjvjdvjj");
    for (var element1 in checkoutlist) {
      var ijjj = cartlist.cartlisttinnout[0]["data"][0]["products"]
          .indexWhere((element) => element["productId"]["_id"] == element1);
      kkk.add({
        "productId": element1,
        "qty": cartlist.cartlisttinnout[0]["data"][0]["products"][ijjj]["qty"],
        "attributes": cartlist.cartlisttinnout[0]["data"][0]["products"][ijjj]
                ["attributes"]
            .map((attribute) {
          Map<String, dynamic> newAttribute = Map.from(attribute);
          print("jgjoggj $newAttribute");
          newAttribute.remove('_id');
          return newAttribute;
        }).toList(),
        "shop_name": cartlist.cartlisttinnout[0]["data"][0]["products"][ijjj]
            ["productId"]["venderId"]["shop_name"],
        "product_name": cartlist.cartlisttinnout[0]["data"][0]["products"][ijjj]
            ["productId"]["product_name"],
        "shopId": cartlist.cartlisttinnout[0]["data"][0]["products"][ijjj]
            ["productId"]["venderId"]["_id"],
        "image": cartlist.cartlisttinnout[0]["data"][0]["products"][ijjj]
            ["productId"]["image1"],
        "shipping_charge": "0",
        "tax": cartlist.cartlisttinnout[0]["data"][0]["products"][ijjj]
            ["productId"]["Tax"][0]["tax_value"],
        "discount": cartlist.cartlisttinnout[0]["data"][0]["products"][ijjj]
            ["productId"]["discount"][0]["discount_value"],
        "subtotal": (cartlist.cartlisttinnout[0]["data"][0]["products"][ijjj]
                    ["productId"]["sale_price"] *
                cartlist.cartlisttinnout[0]["data"][0]["products"][ijjj]["qty"])
            .toString(),
        "total": (cartlist.cartlisttinnout[0]["data"][0]["products"][ijjj]
                    ["productId"]["sale_price"] *
                cartlist.cartlisttinnout[0]["data"][0]["products"][ijjj]["qty"])
            .toString()
      });
      print("jjjj$ijjj");
    }
    print("dddd1$kkk");
    try {
      var res = await http.post(Uri.parse("${base_url}checkOut"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'userId': userid,
            "products": kkk,
            "total_item":
                cartlist.cartlisttinnout[0]["data"][0]["products"].length,
            "save_amount": saveAmount,
            "total_price": totalPrice,
            "status": "1"
          }));
      var resData = json.decode(res.body);
      print("iuy$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print("ffff" + resData);
        isloading.value = false;
      } else {
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      isloading.value = false;
      print("Error22: $e");
    }
  }

  Future checkoutselected(totalPrice, saveAmount) async {
    List<Map<String, dynamic>> kkk = [];
    kkk.clear();
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    for (var element1 in cartlist.mutipledeletelistcart) {
      var ijjj = cartlist.cartlistt[0]["data"][0]["products"]
          .indexWhere((element) => element["productId"]["_id"] == element1);
      kkk.add({
        "productId": element1,
        "size": cartlist.cartlistt[0]["data"][0]["products"][ijjj]["size"],
        "color": cartlist.cartlistt[0]["data"][0]["products"][ijjj]["color"],
        "qty": cartlist.cartlistt[0]["data"][0]["products"][ijjj]["qty"],
        "shop_name": cartlist.cartlistt[0]["data"][0]["products"][ijjj]
            ["productId"]["venderId"]["shop_name"],
        "product_name": cartlist.cartlistt[0]["data"][0]["products"][ijjj]
            ["productId"]["product_name"],
        "shopId": cartlist.cartlistt[0]["data"][0]["products"][ijjj]
            ["productId"]["venderId"]["_id"],
        "image": cartlist.cartlistt[0]["data"][0]["products"][ijjj]["productId"]
            ["image1"],
        "shipping_charge": "0",
        "tax": cartlist.cartlistt[0]["data"][0]["products"][ijjj]["productId"]
            ["Tax"][0]["tax_value"],
        "discount": cartlist.cartlistt[0]["data"][0]["products"][ijjj]
            ["productId"]["discount"][0]["discount_value"],
        "subtotal": (cartlist.cartlistt[0]["data"][0]["products"][ijjj]
                    ["productId"]["sale_price"] *
                cartlist.cartlistt[0]["data"][0]["products"][ijjj]["qty"])
            .toString(),
        "total": (cartlist.cartlistt[0]["data"][0]["products"][ijjj]
                    ["productId"]["sale_price"] *
                cartlist.cartlistt[0]["data"][0]["products"][ijjj]["qty"])
            .toString()
      });
      print("jjjj$ijjj");
      print(cartlist.cartlistt[0]["data"][0]["products"][ijjj]["productId"]
          .toString());
    }

    print("dddd1234$kkk");
    try {
      var res = await http.post(Uri.parse("${base_url}checkOut"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'userId': userid,
            "products": kkk,
            "total_item": cartlist.cartlistt[0]["data"][0]["products"].length,
            "save_amount": saveAmount,
            "total_price": totalPrice
          }));
      var resData = json.decode(res.body);
      print("iuy$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;
      } else {
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      isloading.value = false;
      print("Error: $e");
    }
  }

  Future<RxList<CheckoutList>> checkoutlist_api() async {
    loader();
    checkoutcartlistt.clear();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}checkoutList"), body: {
        'userId': userid.toString(),
      });
      var resData = json.decode(res.body);
      print("iuyff$resData");
      //profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        // Utils().sendMassage('${resData['message'].toString()}');
        checkoutcartlistt.add(CheckoutList.fromJson(resData));
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;

        return checkoutcartlistt;
      } else {
        print("ppppppppioi");

        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
        return checkoutcartlistt;
      }
    } catch (e) {
      isloading.value = false;
      return checkoutcartlistt;
    }
  }

  Future orderpalce(grandTotal, note) async {
    List<Map<String, dynamic>> kkk = [];
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    //print("dddd1${kkk}");
    try {
      var res = await http.post(Uri.parse("${base_url}addOrder"),
          body: isAddress.value == true
              ? {
                  'userId': userid,
                  "checkoutId":
                      checkoutcartlistt.elementAt(0).data!.id.toString(),
                  "addressId": addressIds.toString(),
                  "delivery_place": "Address",
                  if (pay != 0) "payType": payTypes.value.toString(),
                  if (pay == 0)
                    "paymentMode": isAddress.value == true
                        ? "Pay at deliver"
                        : "Pay at store",
                  "grand_total": grandTotal.toString(),
                  "payment_status": pay != 0 ? "Paid" : "Unpaid"
                }
              : {
                  'userId': userid,
                  "checkoutId":
                      checkoutcartlistt.elementAt(0).data!.id.toString(),
                  "delivery_place": "Pickup".toString(),
                  if (pay != 0) "payType": payTypes.toString(),
                  if (pay == 0)
                    "paymentMode": isAddress.value == true
                        ? "Pay at deliver"
                        : "Pay at store",
                  "grand_total": grandTotal.toString(),
                  "payment_status": pay != 0 ? "Paid" : "Unpaid"
                });
      print("ff$addressIds");
      var resData = json.decode(res.body);
      print("iuy$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;
      } else {
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      isloading.value = false;
      print("Error: $e");
    }
  }

  Future orderpalceinntout(grandTotal) async {
    List<Map<String, dynamic>> kkk = [];
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    //print("dddd1${kkk}");
    try {
      var res = await http.post(Uri.parse("${base_url}inntOutaddOrder"),
          body: isAddress.value == true
              ? {
                  'userId': userid,
                  "checkoutId":
                      checkoutcartlisttinntout.elementAt(0).data!.id.toString(),
                  "addressId": addressIds.toString(),
                  "delivery_place": "Address",
                  if (pay != 0) "payType": payTypes.value.toString(),
                  if (pay == 0)
                    "paymentMode": isAddress.value == true
                        ? "Pay at deliver"
                        : "Pay at store",
                  "grand_total": grandTotal.toString(),
                  "payment_status": pay != 0 ? "Paid" : "Unpaid"
                }
              : {
                  'userId': userid,
                  "checkoutId":
                      checkoutcartlisttinntout.elementAt(0).data!.id.toString(),
                  "delivery_place": "Pickup".toString(),
                  if (pay != 0) "payType": payTypes.toString(),
                  if (pay == 0)
                    "paymentMode": isAddress.value == true
                        ? "Pay at deliver"
                        : "Pay at store",
                  "grand_total": grandTotal.toString(),
                  "payment_status": pay != 0 ? "Paid" : "Unpaid"
                });
      print("ff$addressIds");
      var resData = json.decode(res.body);
      print("iuyeeeee$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print("ffffinnotouttt" + resData);
        isloading.value = false;
      } else {
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      isloading.value = false;
      print("Errorinnotouttttt: $e ");
    }
  }

  Future orderlist_api() async {
    loader();
    OrderListlistt.clear();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}orderList"), body: {
        'userId': userid.toString(),
      });
      var resData = json.decode(res.body);
      print("iuyfddd$resData");
      //profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print('klkk');
        OrderListlistt.add(resData);
        print(OrderListlistt);
        update();
        print("ffffggg" + resData["data"]);
        isloading.value = false;

        return OrderListlistt;
      } else {
        print("ppppppppioi");

        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
        return OrderListlistt;
      }
    } catch (e) {
      print("fff $e");
      isloading.value = false;
      return OrderListlistt;
    }
  }

  Future orderlistdeatils_api(orderId, productid) async {
    loader();
    print("kkjhfh");
    Orderdeatilslistt.clear();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print("kkjhfhfff");
    try {
      var res = await http.post(Uri.parse("${base_url}orderDetails"), body: {
        'orderId': orderId.toString(),
        "productId": productid.toString()
      });
      var resData = json.decode(res.body);
      print("iuyddaddreaaa$resData");
      //profiledata.clear();
      print("ffff$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        //Utils().sendMassage('${resData['message'].toString()}');
        print("jkjkkk1223");
        Orderdeatilslistt.add(resData);
        print("asdfg");
        update();
        print("jjjjj${Orderdeatilslistt.toString()}");
        print("ffff" + resData["data"]);
        isloading.value = false;

        return Orderdeatilslistt;
      } else {
        print("ppppppppioi");

        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      isloading.value = false;
    }
  }

  Future cahngeaddress_api(checkoutId, addressId) async {
    loader();
    print("kkjhfh");

    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print("kkjhfhfff");
    try {
      var res = await http.post(Uri.parse("${base_url}changeAddress"), body: {
        'checkoutId': checkoutId.toString(),
        "addressId": addressId.toString()
      });
      var resData = json.decode(res.body);
      print("iuyddaddreaaa$resData");
      //profiledata.clear();
      print("ffff$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        print("jkjkkk1223");
        // currentTab=0;
        // Get.offAll(DashBoardScreen());
        print("asdfg");
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;
      } else {
        print("ppppppppioi");

        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      isloading.value = false;
    }
  }

  Future Revie_api(productid, rating, venderId, comment) async {
    loader();
    print("kkjhfh");
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print("kkjhfhfff11");
    try {
      var res =
          await http.post(Uri.parse("${base_url}givingRating_api"), body: {
        "userId": userid.toString(),
        "productId": productid.toString(),
        "rating": rating.toString(),
        "venderId": venderId.toString(),
        "comment": comment.toString()
      });
      print("hh${res.body}");
      var resData = json.decode(res.body);
      print("iuyddaddreaaa$resData");
      print("ffff$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        Get.offAll(const MyOrder());
      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
      }
    } catch (e) {
      isloading.value = false;
    }
  }

  Future orderreturn(
      productid, orderid, venderId, text, usedreturn_method, context) async {
    loader();
    print("kkjhfh");
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print("kkjhfhfff11");
    try {
      var res =
          await http.post(Uri.parse("${base_url}requestReturn_order"), body: {
        "userId": userid.toString(),
        "productId": productid.toString(),
        "orderId": orderid.toString(),
        "shopId": venderId.toString(),
        "reason": text.toString(),
        "usedreturn_method": usedreturn_method.toString()
      });
      print("hh${res.body}");
      var resData = json.decode(res.body);
      print("iuyddaddreaaa$resData");
      print("ffff$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "false".toString()) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      "Return successfully placed",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 40),
                    Icon(
                      Icons.check_circle_outline,
                      color: logocolo,
                      size: 25,
                    ),
                    SizedBox(height: 40),
                    // Add any other widgets you want in the dialog
                  ],
                ),
              ),
            );
          },
        );
        Get.offAll(const MyOrder());
        Utils().sendMassage(resData['message'].toString());
      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
      }
    } catch (e) {
      isloading.value = false;
    }
  }

  Future ordercancel({
    required dynamic order_id,
    required dynamic productId,
    required payment_status,
  }) async {
    print("kjkjk");
    try {
      var res =
          await http.post(Uri.parse("${base_url}updateOrder_status"), body: {
        "orderId": order_id.toString(),
        "status": "1",
        "productId": productId.toString(),
        // "payment_status":payment_status.toString()
      });
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
      } else {
        Utils().sendMassage(resData['message'].toString());
      }
    } catch (e) {
      print("hh$e");
    }
  }

  Future inntoutcheckoutselected(totalPrice, saveAmount) async {
    List<Map<String, dynamic>> kkk = [];
    kkk.clear();
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    for (var element1 in cartlist.mutipledeletelistcart) {
      var ijjj = cartlist.cartlistt[0]["data"][0]["products"]
          .indexWhere((element) => element["productId"]["_id"] == element1);
      kkk.add({
        "productId": element1,
        "size": cartlist.cartlistt[0]["data"][0]["products"][ijjj]["size"],
        "color": "No color",
        "qty": cartlist.cartlistt[0]["data"][0]["products"][ijjj]["qty"],
        "shop_name": cartlist.cartlistt[0]["data"][0]["products"][ijjj]
            ["productId"]["venderId"]["shop_name"],
        "product_name": cartlist.cartlistt[0]["data"][0]["products"][ijjj]
            ["productId"]["product_name"],
        "shopId": cartlist.cartlistt[0]["data"][0]["products"][ijjj]
            ["productId"]["venderId"]["_id"],
        "image": cartlist.cartlistt[0]["data"][0]["products"][ijjj]["productId"]
            ["image1"],
        "shipping_charge": "0",
        "tax": cartlist.cartlistt[0]["data"][0]["products"][ijjj]["productId"]
            ["Tax"][0]["tax_value"],
        "discount": cartlist.cartlistt[0]["data"][0]["products"][ijjj]
            ["productId"]["discount"][0]["discount_value"],
        "subtotal": (cartlist.cartlistt[0]["data"][0]["products"][ijjj]
                    ["productId"]["sale_price"] *
                cartlist.cartlistt[0]["data"][0]["products"][ijjj]["qty"])
            .toString(),
        "total": (cartlist.cartlistt[0]["data"][0]["products"][ijjj]
                    ["productId"]["sale_price"] *
                cartlist.cartlistt[0]["data"][0]["products"][ijjj]["qty"])
            .toString()
      });
      print("jjjj$ijjj");
      print(cartlist.cartlistt[0]["data"][0]["products"][ijjj]["productId"]
          .toString());
    }

    print("dddd1234$kkk");
    try {
      var res = await http.post(Uri.parse("${base_url}checkOut"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'userId': userid,
            "products": kkk,
            "total_item": cartlist.cartlistt[0]["data"][0]["products"].length,
            "save_amount": saveAmount,
            "total_price": totalPrice,
            "status": "1"
          }));
      var resData = json.decode(res.body);
      print("iuy$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;
      } else {
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      isloading.value = false;
      print("Error: $e");
    }
  }

  Future<RxList<CheckoutList>> inntoutcheckoutlist_api() async {
    loader();
    checkoutcartlisttinntout.clear();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res =
          await http.post(Uri.parse("${base_url}InntOutcheckoutList"), body: {
        'userId': userid.toString(),
      });
      var resData = json.decode(res.body);
      print("iuyff$resData");
      //profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        // Utils().sendMassage('${resData['message'].toString()}');
        checkoutcartlisttinntout.add(CheckoutList.fromJson(resData));
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;

        return checkoutcartlisttinntout;
      } else {
        print("ppppppppioi");

        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
        return checkoutcartlistt;
      }
    } catch (e) {
      isloading.value = false;
      return checkoutcartlistt;
    }
  }

  Future orderlistinnout_api() async {
    loader();
    OrderListlisttinntout.clear();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}InntorderList"), body: {
        'userId': userid.toString(),
      });
      var resData = json.decode(res.body);
      print("iuyfddddd$resData");
      //profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print('klkk');
        OrderListlisttinntout.add(resData);
        print(OrderListlisttinntout);
        update();
        print("ffffggg" + resData["data"]);
        isloading.value = false;

        return OrderListlistt;
      } else {
        print("ppppppppioi");

        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
        return OrderListlistt;
      }
    } catch (e) {
      isloading.value = false;
      return OrderListlistt;
    }
  }
}
