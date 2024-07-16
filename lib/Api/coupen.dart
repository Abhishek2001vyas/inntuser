import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inntuser/ulits/constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ulits/utils.dart';


class coupenn extends GetxController{
  RxList coupenlist=[].obs;

  Future coupen_list() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    coupenlist.clear();
   try{
      final response = await http.post(Uri.parse("${base_url}coupon_list"),
          body: {
            "userId":userId.toString(),

          }

      );
      var resData =jsonDecode(response.body);
      if (response.statusCode == 200 && resData["result"].toString() == "true".toString() ) {
        coupenlist.add(resData);

      } else {
       // Utils().sendMassage(resData['message'].toString());
      }
    }catch(e){

    }
  }


}
