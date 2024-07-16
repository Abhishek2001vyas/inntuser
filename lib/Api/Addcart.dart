import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/Api/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/Users/wishlist/wishlist_controller.dart';
import '../ulits/constant.dart';
import '../ulits/utils.dart';

class Addcart extends GetxController {
  RxList cartlistt = [].obs;
  RxList cartlisttinnout = [].obs;
  RxDouble totalSalePrice = 0.0.obs;
  RxDouble totalunitPrice = 0.0.obs;
  late RxList selectedarr = [].obs;
  late RxString selectedSize1 = "".obs;
  late RxString selectedcolor1 = "".obs;

  RxList selectedsize = [].obs;
  RxList selectedwhishsize = [].obs;
  final wishh = Get.put(wishlist_api());
  RxBool isloading = false.obs;
  final changeviews1 = Get.put(wishlist());
  RxList mutipledeletelistcart = [].obs;

  void mutipledelete(val) {
    mutipledeletelistcart.add(val);
    update();
  }

  void loader() {
    isloading.value = true;
    update();
  }

  size(ind, ele) {
    selectedwhishsize.value[ind] = ele;
    update();
  }

  Future wishaddcartselcted() async {
    List<Map<String, dynamic>> kkk = [];
    var i = 0;
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    for (var element1 in changeviews1.mutipledeletelist) {
      var ijjj = wishh.wishlistlist
          .indexWhere((element) => element["productId"]["_id"] == element1);
      i + 1;
      kkk.add({
        "productId": element1,
        "attributes": wishh.wishlistlist
            .elementAt(ijjj)["productId"]["product_variation"]
            .map((attribute) {
          Map<String, dynamic> newAttribute = Map.from(attribute);
          return {
            "name": attribute["attribute_name"].toString(),
            "value": attribute["attribute_values"][0].toString(),
          };
          print("ddddtttttt$kkk");
        }).toList(),
        // "size":selectedwhishsize[ijjj],
        // "color":wishh.wishlistlist.elementAt(0).data!.elementAt(ijjj).productId!.color![0],
        "qty": "1"
      });

      wishh.wishlistlist
          .elementAt(ijjj)["productId"]["product_variation"]
          .map((attribute) {
        Map<String, dynamic> newAttribute = Map.from(attribute);

        // kkk[i]["attributes"]
        //     .add({
        //   "name":newAttribute ["attribute_name"].toString(),
        //   "value": newAttribute["attribute_values"][0].toString(),
        // });

        print("ddddtttttt$kkk");
      }).toList();

      print("jjjj$ijjj");
    }
    print("ddddtttt$kkk");
    try {
      var res = await http.post(Uri.parse("${base_url}AddMultiplecarts"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'userId': userid, "products": kkk, "status": "0"}));
      print("Array${jsonEncode(kkk)}");
      var resData = json.decode(res.body);
      print("iuy$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;
      } else {
        print("ppppppppioi${resData['message'].toString()}");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future addcartupdated(kkk, cartId) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    print("dddd$kkk");
    try {
      var res = await http.post(Uri.parse("${base_url}Updatecarts"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'userId': userid,
            "cartId": cartId,
            "products": kkk,
            "status": "0"
          }));
      print("Array${jsonEncode(kkk)}");
      var resData = json.decode(res.body);
      print("iuy$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        cartlistinnt();
        print("ffff" + resData["data"]);
        isloading.value = false;
      } else {
        print("ppppppppioi${resData['message'].toString()}");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future cartdeleteselcted() async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print(mutipledeletelistcart.join(","));

    try {
      var res =
          await http.post(Uri.parse("${base_url}deleteMultipleCart"), body: {
        'userId': userid.toString(),
        "productids": mutipledeletelistcart.join(",").toString(),
        "status": "0".toString()
      });
      var resData = json.decode(res.body);
      print("iuy$resData");
      //profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;
      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {}
  }

  Future cartsavedselcted() async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print(mutipledeletelistcart);

    try {
      var res = await http.post(Uri.parse("${base_url}likeMultipleProducts"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'userId': userid.toString(),
            "productIds": mutipledeletelistcart,
            "status": "0".toString()
          }));
      var resData = json.decode(res.body);
      print("iuy$resData");
      //profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;
      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {}
  }

  Future Addcartinnt(productId, sourceName) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.get("user_id");
    print("fffopkgopdfjdfjhbojohgkopkghogf1");
    loader();
    print("$selectedSize1,$selectedcolor1");
    try {
      final response = await http.post(Uri.parse('${base_url}Addcart'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "userId": userid,
            "productId": productId,
            "attributes": selectedarr,
            if (sourceName.toString() != "0") "sourceName": sourceName,
            "qty": "1",
            "status": "0"
          }));
      var decodedData = json.decode(response.body);
      print("jjjj$decodedData");

      if (response.statusCode == 200 && decodedData["result"] == "true") {
        selectedSize1.value = '';
        selectedcolor1.value = '';
        Utils().sendMassage(decodedData['message'].toString());

        // return data.map((json) => InntCategoryList.fromJson(json)).toList();
      } else {
        Utils().sendMassage(decodedData['message'].toString());
        throw Exception('Failed to load innt category list');
      }
    } catch (e) {
      print("jjgjjdrj $e");
    }
  }

  Future orderagain(productId, quan) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.get("user_id");
    print("fffopkgopdfjdfjhbojohgkopkghogf1");
    loader();

    final response = await http.post(Uri.parse('${base_url}Addcart'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": userid.toString(),
          "productId": productId.toString(),
          "attributes": selectedarr,
          "qty": '1'.toString(),
          "status": "0"
        }));
    var decodedData = json.decode(response.body);
    print("jjjj$decodedData");

    if (response.statusCode == 200 && decodedData["result"] == "true") {
      selectedSize1.value = '';
      selectedcolor1.value = '';
      Utils().sendMassage(decodedData['message'].toString());

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      Utils().sendMassage(decodedData['message'].toString());
      throw Exception('Failed to load innt category list');
    }
  }

  Future Addcartinnt1(
    productId,
  ) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.get("user_id");
    loader();
    print("$selectedSize1,$selectedcolor1");
    final response = await http.post(Uri.parse('${base_url}Addcart'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": userid,
          "productId": productId,
          "attributes": selectedarr,
          "qty": '1',
          "status": "0"
        }));
    var decodedData = json.decode(response.body);
    print("jjjj$decodedData");

    if (response.statusCode == 200 && decodedData["result"] == "true") {
      selectedSize1.value = '';
      selectedcolor1.value = '';
      var res = await http
          .post(Uri.parse("${base_url}like_dislike_product_api"), body: {
        'userId': userid.toString(),
        "productId": productId.toString()
      });
      print("fffopkgopdfjdfjhbojohgkopkghogf");
      Utils().sendMassage(decodedData['message'].toString());

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      Utils().sendMassage(decodedData['message'].toString());
      throw Exception('Failed to load innt category list');
    }
  }

  Future cartlistinnt() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.get("user_id");

    loader();
    final response = await http.post(Uri.parse('${base_url}cartList'),
        body: {"userId": userid.toString(), "status": "0"});
    var decodedData = json.decode(response.body);

    cartlistt.clear();
    if (response.statusCode == 200 && decodedData["result"] == "true") {
      cartlistt.add(decodedData);

      return cartlistt;
    } else {
      throw Exception('Failed to load innt category list');
    }
  }

  Future cartdelteinnt(productId) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.get("user_id");
    loader();
    final response = await http.post(Uri.parse('${base_url}deleteCart'), body: {
      "userId": userid.toString(),
      "productId": productId.toString(),
      "status": "0"
    });
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200 && decodedData["result"] == "true") {
      Utils().sendMassage(decodedData['message'].toString());

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      Utils().sendMassage(decodedData['message'].toString());
      throw Exception('Failed to load innt category list');
    }
  }

  Future Addcartinntout(productId) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.get("user_id");
    loader();
    final response = await http.post(Uri.parse('${base_url}Addcart'), body: {
      "userId": userid.toString(),
      "productId": productId.toString(),
      "status": "1"
    });
    var decodedData = json.decode(response.body);
    // print("jjjj$decodedData");

    if (response.statusCode == 200 && decodedData["result"] == "true") {
      Utils().sendMassage(decodedData['message'].toString());

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      Utils().sendMassage(decodedData['message'].toString());
      throw Exception('Failed to load innt category list');
    }
  }

  Future cartlistinntout() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.get("user_id");

    loader();
    final response = await http.post(Uri.parse('${base_url}InnoutcartList'),
        body: {"userId": userid.toString(), "status": "1"});
    var decodedData = json.decode(response.body);
    print("jjjj$decodedData");
    cartlisttinnout.clear();
    if (response.statusCode == 200 && decodedData["result"] == "true") {
      cartlisttinnout.add(decodedData);
      //Utils().sendMassage('${decodedData['message'].toString()}');

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
      return cartlisttinnout;
    } else {
      //Utils().sendMassage('${decodedData['message'].toString()}');

      throw Exception('Failed to load innt category list');
    }
  }

  Future Inntoutcarddelete(productid) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print("useid$userid");
    try {
      final response =
          await http.post(Uri.parse('${base_url}deleteinntoutCart'), body: {
        "userId": userid,
        "productId": productid,
      });
      var decodedData = json.decode(response.body);
      if (response.statusCode == 200 &&
          decodedData["result"].toString() == "true".toString()) {
        Utils().sendMassage(decodedData['message'].toString());
      } else {
        Utils().sendMassage(decodedData['message'].toString());
        throw Exception('Failed to load innt category list');
      }
    } catch (e) {
      print("error $e");
    }
  }

  Future inntoutaddcartupdated(kkk, cartId) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    print("dddd$kkk  $cartId");
    try {
      var res = await http.post(Uri.parse("${base_url}inntOutUpdatecarts"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'userId': userid,
            "cartId": cartId,
            "products": kkk,
          }));
      print("Array${jsonEncode(kkk)}");
      var resData = json.decode(res.body);
      print("iuy$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        cartlistinnt();
        print("ffff" + resData["data"]);
        isloading.value = false;
      } else {
        print("ppppppppioi${resData['message'].toString()}");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
