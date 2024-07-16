import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/Api/productlistbysubsubcat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ulits/constant.dart';
import '../ulits/utils.dart';



class wishlist_api extends GetxController {
  RxBool isloading = false.obs;
  RxList wishlist = [].obs;
  RxList wishlistlist = [].obs;
  final proddea = Get.put(fetchInntsubsubCategoryproductList());

  void loader() {
    isloading.value = true;
    update();
  }

  Future wishlike(productid,shopid) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
print("ujihujhgvuihui huihfioh $productid  $shopid");
    try {
      var res =
      await http.post(Uri.parse("${base_url}like_dislike_product_api"),  body: {
        'userId': userid.toString(),
        "productId": productid.toString()
      });
      var resData = json.decode(res.body);
      print("iuy$resData");
      //profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
       // proddea.subsubcatprodeat(subsubcateid,shopid);
       // profiledata.add(resData["data"]);
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

  Future wishlike22(productid,shopid,) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    try {
      var res =
      await http.post(Uri.parse("${base_url}like_dislike_product_api"),  body: {
        'userId': userid.toString(),
        "productId": productid.toString()
      });
      var resData = json.decode(res.body);
      print("iuy$resData");
      //profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        // profiledata.add(resData["data"]);
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
  Future wishlike1(productid) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    try {
      var res =
      await http.post(Uri.parse("${base_url}like_dislike_product_api"),  body: {
        'userId': userid.toString(),
        "productId": productid.toString()
      });
      var resData = json.decode(res.body);
      print("iuy$resData");
      //profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {

        // profiledata.add(resData["data"]);
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

  Future wishlikelist() async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    try {
      var res =
      await http.post(Uri.parse("${base_url}likeProduct_listApi"),  body: {
        'userId': userid.toString(),

      });
      var resData = json.decode(res.body);
      print("iuy$resData");
      //profiledata.clear();
      wishlistlist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print("djj");
        wishlistlist.addAll(resData["data"]);
       // Utils().sendMassage('${resData['message'].toString()}');
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;
        
        return wishlistlist;
      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
        //return wishlistlist;
      }
    } catch (e) {print("Error $e");}
    //return wishlistlist;

  }

  Future wishlikelist1() async {
    wishlistlist.clear();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res = await http.post(
        Uri.parse("${base_url}likeProduct_listApi"),
        body: {'userId': userid.toString()},
      );

      var resData = json.decode(res.body);

      if (res.statusCode == 200 && resData["result"].toString() == "true") {

        wishlistlist.addAll(resData["data"]);
        // wishlistlist.add(Wishliklist.fromJson(resData));
        return wishlistlist;
      } else {
        Utils().sendMassage(resData['message'].toString());
        return wishlistlist;
      }
    } catch (e) {
      print("Error fetching wishlist: $e");
      return wishlistlist;
    }
  }

  Future wishdeleteselcted(productid) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    try {
      var res =
      await http.post(Uri.parse("${base_url}deleteLikeProduct_listApi"),  body: {
        'userId': userid.toString(),
        "productId": productid.toString(),
        "status":'0'

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

  RxBool loading=false.obs;
  RxList wishprofsearch=[].obs;
  RxList wishproffilter=[].obs;
  // final Addcartinnt_api = Get.put(Addcart());

  Future wishlistsearchww(key) async {
    wishprofsearch.clear();

    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    loading.value =true;
    final response = await http.post(
        Uri.parse('${base_url}wishList_Productsearch'),
        body: {
          "key":key.toString(),
          'userId': userid.toString(),
        }
    );
    var decodedData = json.decode(response.body);
    print(decodedData);
    if (response.statusCode == 200 && decodedData["result"].toString()=="true") {
      print("hhhj");

      wishprofsearch.add(decodedData);
      print("fffdgfh${wishprofsearch[0]["data"].length}");
      print(wishprofsearch.elementAt(0));
      loading.value =false;
      return wishprofsearch;
    } else {
      loading.value =false;
    }
  }

  Future wishlistfilter(status) async {
    wishproffilter.clear();

    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    loading.value =true;
    try{
    final response = await http.post(
        Uri.parse('${base_url}wishList_search'),
        body: {
          "status":status.toString(),
          'userId': userid.toString(),
        }
    );
    var decodedData = json.decode(response.body);
    print(decodedData);
    if (response.statusCode == 200 && decodedData["result"].toString()=="true") {
      print("hhhjrrr");

      wishproffilter.add(decodedData);
      print("fffdgfh${wishproffilter[0]}");
      print(wishproffilter.elementAt(0));
      loading.value =false;
      return wishproffilter;
    } else {
      loading.value =false;
    }
  }catch(e){
print("fffefewsrf $e");
  }}

  RxList seesimilarlist = [].obs;
  Future seesimilar(subsubcatid) async {
    seesimilarlist.clear();

    loading.value =true;
    try{
      final response = await http.post(
          Uri.parse('${base_url}similarInntproductLists'),
          body: {
            'subSubcategoryId': subsubcatid.toString(),
          }
      );
      var decodedData = json.decode(response.body);
      print(decodedData);
      if (response.statusCode == 200 && decodedData["result"].toString()=="true") {
        print("hhhjrrr");

        seesimilarlist.add(decodedData);
        print("fffdgfh${seesimilarlist[0]}");
        print(seesimilarlist.elementAt(0));
        loading.value =false;
        return seesimilarlist;
      } else {
        loading.value =false;
      }
    }catch(e){
      print("fffefewsrf $e");
    }}

}
