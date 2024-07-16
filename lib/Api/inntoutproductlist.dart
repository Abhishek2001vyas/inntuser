import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/Users/cart_screen.dart';
import '../ulits/constant.dart';
import 'innoutaddcart.dart';



class InntOutproductlist extends GetxController {
  RxList inntOutproddlist = [].obs;
  RxList inntOutproddeta = [].obs;
  var currentindex = 0.obs;

  void changeindicator(intt){
    currentindex.value =intt;
    update();
  }


  Future inntOutproductlList(categoryId) async {
    final response =
    await http.post(Uri.parse('${base_url}categoryBase_productList'),body: {
      "categoryId":categoryId.toString()
    });
    var decodedData = json.decode(response.body);
    print("jjjj$decodedData");
    inntOutproddlist.clear();
    if (response.statusCode == 200 && decodedData["result"]=="true") {


        inntOutproddlist.add(decodedData);

      print(inntOutproddlist.toString());
      return inntOutproddlist;

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load innt category list');
    }
  }
  final Addcartinntout1_api=Get.put(Inntoutaddcard());
  Future<RxList?>inntOutprodeat(subsubid,shopid) async {
    print("idfjhidsjhifjhidsf33333$subsubid, $shopid");

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(' lat long  ${position.longitude} ${position.latitude}');
    print("uihghf");
    try{

    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.get("user_id");
    final response = await http.post(
        Uri.parse('${base_url}inntOut_productDetails'),
        body: {
          "productId": subsubid.toString(),
          "shopId": shopid.toString(),
          "userId":userid.toString(),
          "lat":position.latitude.toString(),
          "lon":position.longitude.toString()
        });
    var decodedData = json.decode(response.body);

    inntOutproddeta.clear();

    print("ojojdfjds$decodedData");
    if (response.statusCode == 200 && decodedData["result"].toString()=="true") {

      inntOutproddeta.add(decodedData);
      final attributes = inntOutproddeta.elementAt(0)["data"].elementAt(0)["attributes"];
      Addcartinntout1_api.selectedarr.clear();
      if (attributes != null && attributes.isNotEmpty) {
        for (var attribute in attributes) {
          Addcartinntout1_api.selectedarr.add({
            "name": attribute["attribute_name"].toString(),
            "value": attribute["attribute_values"][0].toString(),
          });
        }
      }
      update();
      print("sdfjjdsfojv ${cartlist.selectedarr}");
     // print("qwert" + inntOutproddeta.elementAt(0).data!.elementAt(0).toString());

      return inntOutproddeta;
      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load innt category list');
    }}
        catch(e){
      print("ffffrrr $e");
        }
    return null;
  }
}
