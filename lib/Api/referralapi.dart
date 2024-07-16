import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ulits/constant.dart';
import '../ulits/utils.dart';

class refer_api extends GetxController {
  RxList referlist = [].obs;

  Future referhistroy() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}refferalHistory"), body: {
        'userId': userid.toString(),
      });
      var resData = json.decode(res.body);
      print("iuy$resData");
      referlist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        referlist.add(resData);
        return referlist;
      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
      }
    } catch (e) {
      print("errorrr $e");
    }
  }
}
