import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ulits/constant.dart';
import '../after/forgototp.dart';
import '../after/newpassword.dart';
import '../screen/credential/Login/login.dart';
import '../ulits/utils.dart';

class forgotforotp_api extends GetxController {
  RxBool isloading = false.obs;

  void loader() {
    isloading.value = true;
    update();
  }

/* For otp fo forgot password*/
  // Future phoneforgot(mobile) async {
  //   print("dsifhdsihf"+mobile.toString());
  //   loader();
  //   var shared_preferences = await SharedPreferences.getInstance();
  //   try {
  //     var res =
  //     await http.post(Uri.parse("${base_url}resendOtp"),
  //         body: {
  //           'mobile_number': mobile.toString(),
  //           "choose_status": "1".toString()
  //         });
  //
  //     var resData = json.decode(res.body);
  //     print(resData);
  //     if (res.statusCode == 200 &&
  //         resData["result"].toString() == "true".toString()) {
  //       // shared_preferences.setString(
  //       //     "user_id", resData["data"]["_id"].toString());
  //       Utils().sendMassage('${resData['message'].toString()}');
  //       update();
  //       print(resData["data"].toString());
  //       isloading.value = false;
  //       return
  //         Get.to(Verify_Login(
  //           otp: resData["data"]["otp"],
  //           mobile: resData["data"]["mobile_number"],
  //         forgotpassword: resData["data"]["mobile_number"],
  //         ));
  //
  //     } else {
  //       Utils().sendMassage('${resData['message'].toString()}');
  //       //print(resData["msg"].toString());
  //       isloading.value = false;
  //     }
  //   } catch (e) {}
  // }
  //
  // Future emailforgot(email) async {
  //   loader();
  //   var shared_preferences = await SharedPreferences.getInstance();
  //   try {
  //     var res =
  //     await http.post(Uri.parse("${base_url}resendOtp"),
  //         body: {
  //           'email': email.toString(),
  //           "choose_status": "2".toString()
  //         });
  //
  //     var resData = json.decode(res.body);
  //     print(resData);
  //     if (res.statusCode == 200 &&
  //         resData["result"].toString() == "true".toString()) {
  //       Utils().sendMassage('${resData['message'].toString()}');
  //       update();
  //       print(resData["data"].toString());
  //       isloading.value = false;
  //       return
  //         Get.to(Verify_Login(
  //           otp: resData["data"]["otp"],
  //           mobile: resData["data"]["mobile_number"],
  //         forgotpassword: resData["data"]["mobile_number"],
  //         ));
  //
  //     } else {
  //       Utils().sendMassage('${resData['message'].toString()}');
  //
  //       isloading.value = false;
  //     }
  //   } catch (e) {}
  // }

  /*For new password */

  Future forgot(email) async {
    print("hhkjhvk$email");
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    try {
      var res = await http.post(Uri.parse("${base_url}forgotPassword"), body: {
        'mobile_number': email.toString(),
      });

      var resData = json.decode(res.body);
      print(resData);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print(resData["data"]["otp"].toString());
        isloading.value = false;
        return Get.to(() => forgototpp(
              number: email.toString(),
              otp: resData["data"]["otp"].toString(),
            ));
      } else {
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {}
  }

  /*For forgot otp verify */

  Future forgototpverify(email, otp) async {
    print("hhkjhvk$otp");
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    try {
      var res = await http.post(Uri.parse("${base_url}verifyEmail_andMobile"),
          body: {'otp': otp.toString(), 'key': email.toString()});

      var resData = json.decode(res.body);
      print(resData);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print(resData["data"]["otp"].toString());
        isloading.value = false;
        return Get.to(newpasswordd(
          number: email.toString(),
        ));
      } else {
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {}
  }

  /*For new newpassword*/
  Future forgotreset(email, password) async {
    print("hhkjhvk$password");
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    try {
      var res = await http.post(Uri.parse("${base_url}resetPassword"),
          body: {'password': password.toString(), 'key': email.toString()});

      var resData = json.decode(res.body);
      print(resData);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        //print("ggggg${resData["data"]}");
        isloading.value = false;
        Get.offAll(() => const Login_email());
      } else {
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {}
  }
}
