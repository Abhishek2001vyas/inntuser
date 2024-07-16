import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/Users/home.dart';
import '../ulits/constant.dart';
import '../ulits/utils.dart';

class Inntfavoriteshop extends GetxController {
  RxList Favshoplist = [].obs;
  var shopdistancemax;
  var shopdistancemin;

  Future Innt_favoriteshop(shopid) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print("useid$userid shop $shopid");
    try {
      final response =
          await http.post(Uri.parse('${base_url}favouriteShop'), body: {
        "userId": userid,
        "shopId": shopid,
      });
      var decodedData = json.decode(response.body);
      if (response.statusCode == 200 &&
          decodedData["result"].toString() == "true".toString()) {
        Utils().sendMassage(decodedData['message'].toString());
      } else {
        throw Exception('Failed to load innt category list');
      }
    } catch (e) {
      print("error $e");
    }
  }

  Future Innt_favoriteshoplist() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print("useid$userid");
    Favshoplist.clear();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(' lat long  ${position.longitude} ${position.latitude}');
    try {
      final response =
          await http.post(Uri.parse('${base_url}favouriteShopList'), body: {
        "userId": userid,
        "lon": position.longitude.toString(),
        "lat": position.latitude.toString()
      });
      var decodedData = json.decode(response.body);
      if (response.statusCode == 200 &&
          decodedData["result"].toString() == "true".toString()) {
        Favshoplist.add(decodedData);
        print("${Favshoplist[0]["data"]![0]}");
        shopdistancemax = decodedData["data"].reduce((a, b) =>
            double.parse(a["distances"]!) > double.parse(b["distances"]!)
                ? a
                : b);

        // Find the product with the lowest sale price
        shopdistancemin = decodedData["data"].reduce((a, b) =>
            double.parse(a["distances"]!) < double.parse(b["distances"]!)
                ? a
                : b);
        print(" max ${shopdistancemax} ");

        print("min ${shopdistancemin}");
        //  Utils().sendMassage('${decodedData['message'].toString()}');
        return Favshoplist;
      } else {
        Utils().sendMassage(decodedData['message'].toString());
        throw Exception('Failed to load innt category list');
      }
    } catch (e) {
      print("error $e");
    }
  }

  RxInt changeviews = 0.obs;

  void changes(val) {
    changeviews.value = val;
    update();
  }

  RxList favshopsearchlisttt = [].obs;
  searchfavshop(String searchTerm) {
    // Convert the search term to lowercase for case-insensitive search

    String searchTermLower = searchTerm.toLowerCase();
    favshopsearchlisttt.clear();
    print("ggggddd");
    for (var myfriendss in Favshoplist[0]["data"]) {
      print("ggggddd $myfriendss");
      List<int> indices = [];
      if (myfriendss["shop_name"].toLowerCase().contains(searchTermLower)) {
        favshopsearchlisttt.add(myfriendss);
        print('kkkkkkkddd1 ${favshopsearchlisttt.length}');
        print('kkkkkkkddd $favshopsearchlisttt');
      }
    }

    return favshopsearchlisttt;
  }

  RxList favsellerfilterlist = [].obs;
  Future favsellerfilter({rating, distances2, distances1}) async {
    favsellerfilterlist.clear();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print(
        "ggddd ${currentLocation.latitude}, ${currentLocation.longitude} , $rating,$distances1,$distances2");
    final response =
        await http.post(Uri.parse('${base_url}favouriteShopList_filter'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              "userId": userid.toString(),
              "distances1": distances1.toString(),
              "distances2": distances2.toString(),
              "lat": currentLocation.latitude.toString(),
              "lon": currentLocation.longitude.toString(),
              "rating": rating.toString()
            }));
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200 && decodedData["result"] == "true") {
      print("kkkkfilterShop ${decodedData}");
      favsellerfilterlist.add(decodedData);
      print("llkdkd $favsellerfilterlist");
      return favsellerfilterlist;
    } else {
      favsellerfilterlist.add(decodedData);
    }
  }
}
