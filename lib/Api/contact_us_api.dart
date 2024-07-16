import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/screen/Users/Navgationbar.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ulits/utils.dart';

List contactUs = [];

class fetchContactUs extends GetxController {


  Future contact_Us(first,last,phone,eamil,object,message) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    try{
    final response = await http.post(Uri.parse("${base_url}user_queries"),
    body: {
      "userId":userId.toString(),
      "title":object.toString(),
      "message":message.toString(),
      "phone":phone.toString(),
      "email":eamil.toString(),
      "lname":last.toString(),
      "fname":first.toString()
    }

    );
    var resData =jsonDecode(response.body);
    if (response.statusCode == 200 && resData["result"].toString() == "true".toString() ) {
      Utils().sendMassage(resData['message'].toString());
      currentTab =0;
      Get.offAll(const DashBoardScreen());

    } else {
      Utils().sendMassage(resData['message'].toString());
    }
  }catch(e){

    }
    }
}

