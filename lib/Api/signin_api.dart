import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ulits/constant.dart';
import '../../../ulits/utils.dart';
import '../firebase/fcm.dart';
import '../screen/Users/Navgationbar.dart';
import '../screen/credential/Login/otp_Login.dart';

class signIn_api extends GetxController {
  RxBool isloading = false.obs;

  void loader() {
    isloading.value = true;
    update();
  }

  Future signIn(mobile, password) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    try {
      var res = await http.post(Uri.parse("${base_url}userLogin"), body: {
        'mobile_number': mobile.toString(),
        "password": password.toString(),
        "fcm_id":fCMToken.toString(),
      });
      var resData = json.decode(res.body);
      print(resData);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        sharedPreferences.setString(
            "user_id", resData["data"]["_id"].toString());
        sharedPreferences.setString("token", resData["token"].toString());
        Utils().sendMassage(resData['message'].toString());

        update();
        print(resData["data"].toString());
        isloading.value = false;
        Get.defaultDialog(
          title: "Wellcome",
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          content: Text(
            resData["data"]["first_name"].toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
        // Get.defaultDialogTransitionDuration()
        Future.delayed(
          const Duration(milliseconds: 250),
          () => Get.to(
            () => const DashBoardScreen(),
          ),
        );
      }
      else if(  resData["result"].toString() == "false".toString() &&resData["message"].toString()=="Please verify your mobile number".toString()){
        Get.to(Verify_Login(
          otp: resData["data"]["otp"],
          countrycode: 226,
          email:  resData["data"]["email"],
          mobile:  resData["data"]["mobile_number"],
        ));
        isloading.value = false;
      }
      else {
        Utils().sendMassage(resData['message'].toString());
        //print(resData["msg"].toString());
        isloading.value = false;
      }
    } catch (e) {

    }
  }
}
