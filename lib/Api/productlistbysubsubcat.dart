import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/screen/Users/Navgationbar.dart';
import 'package:inntuser/screen/Users/cart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/productbysubsubcate.dart';
import '../screen/Users/home.dart';
import '../ulits/constant.dart';
import '../ulits/utils.dart';

class fetchInntsubsubCategoryproductList extends GetxController {
  var currentindex = 0.obs;
  RxList inntsubsubCateproddeta = [].obs;
  RxList<Productbysubsubcate> inntsubsubCateprod12 =
      <Productbysubsubcate>[].obs;

  RxList<Productbysubsubcate> inntsubsubCateprofilter =
      <Productbysubsubcate>[].obs;
  var productWithHighestSalePrice;
  var productWithLowestSalePrice;

  void changeindicator(intt) {
    currentindex.value = intt;
    update();
  }

  Future<RxList<Productbysubsubcate>> subsubcatproList(subsubid, shopid) async {
    print("idfjhidsjhifjhidsf5555");
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.get("user_id");
    inntsubsubCateprod12.clear();
    final response = await http
        .post(Uri.parse('${base_url}sub_subcategoryBase_productList'), body: {
      "sub_subcategoryId": subsubid.toString(),
    });
    print("idfjhidsjhifjhidsf55555584545${response.statusCode}");
    var decodedData = json.decode(response.body);
    print("idfjhidsjhifjhidsf55555587415$decodedData");
    // List privacypolicy = decodedData;
    print('jkhhkhk');
    print("ojojdfjds$decodedData");
    if (response.statusCode == 200) {
      print('jkkhkfdshjkihgf');
      inntsubsubCateprod12.add(Productbysubsubcate.fromJson(decodedData));
      update();
      productWithHighestSalePrice = decodedData["data"]
          .reduce((a, b) => a["sale_price"]! > b["sale_price"]! ? a : b);

      // Find the product with the lowest sale price
      productWithLowestSalePrice = decodedData["data"]
          .reduce((a, b) => a["sale_price"]! < b["sale_price"]! ? a : b);

      print('Product with highest sale price:');
      print(productWithHighestSalePrice.toString());

      print('\nProduct with lowest sale price:');
      print(productWithLowestSalePrice["sale_price"].toString());
      print("sdfjjdsfojv");
      print("qwert${inntsubsubCateprod12.elementAt(0).data!.elementAt(0)}");
      return inntsubsubCateprod12;

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load innt category list');
    }
  }

  Future subsubcatprodeat(subsubid, shopid) async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      var userid = sharedPreferences.get("user_id");
      print("oifihjihfgihighv13");
      print(
          ' lat long  ${currentLocation.longitude} ${currentLocation.latitude}');
      print("jdjkjdjdj");
      print("idfjhidsjhifjhidsf$subsubid, $shopid $userid ");

      final response =
          await http.post(Uri.parse('${base_url}productDetails'), body: {
        "productId": subsubid.toString(),
        "shopId": shopid.toString(),
        "userId": userid.toString(),
        "lat": currentLocation.latitude.toString(),
        "lon": currentLocation.longitude.toString()
      });
      final response2 = await http.post(Uri.parse('${base_url}addViewproduct'),
          body: {
            "productId": subsubid.toString(),
            "userId": userid.toString()
          });

      print("idfjhidsjhifjhidsf55555584545${response.statusCode}");
      var decodedData = json.decode(response.body);
      print("idfjhidsjhifjhidsf55555587415$decodedData");
      // List privacypolicy = decodedData;
      print('jkhhkhk');
      print("ojojdfjds$decodedData");
      inntsubsubCateproddeta.clear();
      cartlist.selectedarr.clear();
      if (response.statusCode == 200 &&
          decodedData["result"].toString() == "true") {
        print('jkkhkfdshjkihgf');
        inntsubsubCateproddeta.add(decodedData);
        print("sdfjjdsfojv ");

        final attributes = inntsubsubCateproddeta
            .elementAt(0)["data"]
            .elementAt(0)["attributes"];

        if (attributes != null && attributes.isNotEmpty) {
          for (var attribute in attributes) {
            cartlist.selectedarr.add({
              "name": attribute["attribute_name"].toString(),
              "value": attribute["attribute_values"][0].toString(),
            });
          }
        }
        print("sdfjjdsfojv ${cartlist.selectedarr}");
        return inntsubsubCateproddeta;
        // return data.map((json) => InntCategoryList.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load innt category list');
      }
    } catch (e) {
      debugPrint("jihdfoijfrrrrr response");
      print("Error1productdeatils $e");
    }
  }

  Future productreport(productid, shopid, title, text, status) async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      var userid = sharedPreferences.get("user_id");

      print("idfjhidsjhifjhidsf$productid, $shopid $status ");

      final response =
          await http.post(Uri.parse('${base_url}addReportOf_product'),
              body: status.toString() == "0"
                  ? {
                      "productId": productid.toString(),
                      "shopId": shopid.toString(),
                      "userId": userid.toString(),
                      "title": title.toString(),
                      "text": text.toString()
                    }
                  : {
                      "shopId": shopid.toString(),
                      "userId": userid.toString(),
                      "title": title.toString(),
                      "text": text.toString()
                    });

      var decodedData = json.decode(response.body);

      if (response.statusCode == 200 &&
          decodedData["result"].toString() == "true") {
        Utils().sendMassage(decodedData['message'].toString());
        currentTab = 0;
        Get.offAll(const DashBoardScreen());
        // return data.map((json) => InntCategoryList.fromJson(json)).toList();
      } else {
        Utils().sendMassage(decodedData['message'].toString());
        throw Exception('Failed to load innt category list');
      }
    } catch (e) {
      debugPrint("jihdfoijfrrrrr response");
      print("Error1productdeatils $e");
    }
  }

  Future<RxList<Productbysubsubcate>?> subsubcatprofilter(
      {subsubid, price, price1, discount, rating}) async {
    print(
        "idfjhidsjhifjhidsf$subsubid,${price.runtimeType} ${price1.runtimeType}");
    inntsubsubCateprofilter.clear();

    try {
      final response = await http.post(Uri.parse('${base_url}filterproducts'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "sub_subcategoryId": subsubid.toString(),
            "price": price,
            if (rating != null) "rating": rating,
            if (discount != null) "discount": discount,
            "price1": price1,
          }));

      print("idfjhidsjhifjhidsf55555584545 ${response.statusCode}");
      var decodedData = json.decode(response.body);
      print("idfjhidsjhifjhidsf55555587415$decodedData");
      // List privacypolicy = decodedData;
      print('jkhhkhk');
      print("ojojdfjds$decodedData");
      if (response.statusCode == 200 &&
          decodedData["result"].toString() == "true") {
        print('jkkhkfdshjkihgf');
        inntsubsubCateprofilter.add(Productbysubsubcate.fromJson(decodedData));
        update();
        print("sdfjjdsfojv ");

        return inntsubsubCateprofilter;
      } else {
        throw Exception('Failed to load innt category list');
        return inntsubsubCateprofilter;
      }
    } catch (e) {
      print("Error1 $e");
    }
    return null;
  }
}
