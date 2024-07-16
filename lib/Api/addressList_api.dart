import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/screen/Users/add_address/address_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/Users/Navgationbar.dart';
import '../ulits/constant.dart';
import '../ulits/utils.dart';
import 'getuserprofile.dart';

class Address_api extends GetxController {
  RxList addressList = [].obs;
  RxBool isloading = false.obs;
  RxList addresssearchlisttt = [].obs;
  void loader() {
    isloading.value = true;
    update();
  }

  Addaddressapi(cityName, buildingNo, landmark, placeType, state, pinCode,
      villageName, lat, lon) async {
    loader();
    print("ijdsfgijdskijgoij $lat $lon");
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    print("kkkkkk ");
    try {
      var request = await http.post(Uri.parse("${base_url}addAddress"), body: {
        "userId": userId,
        "place_type": placeType.toString(),
        'state': state.toString(),
        "village_name": villageName.toString(),
        "pin_code": pinCode.toString(),
        "building_no": buildingNo.toString(),
        'city_name': cityName.toString(),
        "landmark": landmark.toString(),
        "latitude": lat.toString(),
        "longitude": lon.toString(),
      });
      print(request.statusCode);
      var resData = json.decode(request.body);
      print("ttt$resData");
      if (request.statusCode == 200 &&
          resData["result"].toString() == "false".toString()) {
        Utils().sendMassage(resData['message'].toString());
        loader();
        print("111${resData["data"]}");
        isloading.value = false;
        // goto == 1 ? Get.to(YourOrder()) :
        // Get.to(const AddressScreen());

        currentTab = 0;

        Get.off(const DashBoardScreen());
      } else {
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  searchaddress(String searchTerm) {
    // Convert the search term to lowercase for case-insensitive search

    String searchTermLower = searchTerm.toLowerCase();
    addresssearchlisttt.clear();
    print("ggggddd");
    for (var myfriendss in addressList[0]) {
      print("ggggddd $myfriendss");
      List<int> indices = [];
      if (myfriendss["place_type"].toLowerCase().contains(searchTermLower) ||
          myfriendss["building_no"].toLowerCase().contains(searchTermLower) ||
          myfriendss["village_name"].toLowerCase().contains(searchTermLower) ||
          myfriendss["city_name"].toLowerCase().contains(searchTermLower) ||
          myfriendss["landmark"].toLowerCase().contains(searchTermLower) ||
          myfriendss["state"].toLowerCase().contains(searchTermLower) ||
          myfriendss["pin_code"].toLowerCase().contains(searchTermLower)) {
        addresssearchlisttt.add(myfriendss);
        print('kkkkkkkddd1 ${addresssearchlisttt.length}');
        print('kkkkkkkddd $addresssearchlisttt');
      }
    }

    return addresssearchlisttt;
  }

  Future getAddressListApi() async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}getAddress"), body: {
        "userId": userId.toString(),
      });
      var resData = json.decode(res.body);
      addressList.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        loader();
        addressList.add(resData["data"]);
        print("aaaaa$addressList");
        isloading.value = false;
      } else {
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  final getprofile = Get.put(Getuserprofile_api());
  Future getAddressListApi2() async {
    loader();
    await getprofile.userprofile();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}getAddress"), body: {
        "userId": userId.toString(),
      });

      print("pp${res.body}");
      var resData = json.decode(res.body);
      print("ttt$resData");
      addressList.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        loader();
        print(resData["data"].toString());
        addressList.add(resData["data"]);
        print("aaaaa$addressList");
        isloading.value = false;
      } else {
        //Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future deleteAddressListApi(addressId) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}deleteAddress"), body: {
        "addressId": addressId.toString(),
        "userId": userId,
      });

      print("pp${res.body}");
      var resData = json.decode(res.body);
      print("ttt$resData");

      if (res.statusCode == 200 &&
          resData["result"].toString() == "false".toString()) {
        getAddressListApi();
        loader();

        print(resData["data"].toString());

        isloading.value = false;
      } else {
        //Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  updateeAddaddressapi(cityName, buildingNo, landmark, placeType, state,
      pinCode, villageName, lat, lon, addrid) async {
    loader();
    print("ijdsfgijdskijgoij $lat $lon");
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    print("kihkhdskjk$placeType");
    try {
      var request =
          await http.post(Uri.parse("${base_url}updateAddress"), body: {
        "userId": userId,
        "place_type": placeType.toString(),
        'state': state.toString(),
        "village_name": villageName.toString(),
        "pin_code": pinCode.toString(),
        "building_no": buildingNo.toString(),
        'city_name': cityName.toString(),
        "landmark": landmark.toString(),
        "latitude": lat.toString(),
        "longitude": lon.toString(),
        "addressId": addrid.toString()
      });
      print(request.statusCode);
      var resData = json.decode(request.body);
      print("ttt$resData");
      if (request.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());

        print("111${resData["data"]}");
        isloading.value = false;
        // goto == 1 ? Get.to(YourOrder()) :
        Get.to(const AddressScreen());
      } else {
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future setdeafultaddressApi(addressid) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}setDefault_address"),
          body: {
            "userId": userId.toString(),
            "addressId": addressid.toString()
          });

      print("pp${res.body}");
      var resData = json.decode(res.body);
      print("ttt$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['message'].toString()}');
        print(resData["data"].toString());
        isloading.value = false;

        currentTab = 0;

        Get.off(const DashBoardScreen());
      } else {
        Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
