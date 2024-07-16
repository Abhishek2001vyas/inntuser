import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ulits/constant.dart';
import '../../../ulits/utils.dart';
import '../screen/Users/Navgationbar.dart';

class Verify_api extends GetxController {
  RxBool isloading = false.obs;
  var newotp = "".obs;

  void loader() {
    isloading.value = true;
    update();
  }

  verify(body) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    try {
      var res = await http.post(Uri.parse("${base_url}VerifyOtp"), body: body);
      var resData = json.decode(res.body);
      print("qqqq$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        sharedPreferences.setString(
            "user_id", resData["data"]["_id"].toString());
        sharedPreferences.setString("token", resData["token"].toString());
        Utils().sendMassage(resData['message'].toString());
        update();
        print(resData["data"].toString());
        isloading.value = false;
        print("done");
        // forgot==null?
        Get.offAll(const DashBoardScreen());
        //: Get.to(newpassword(mobile: forgot,));
      } else {
        Utils().sendMassage(resData['message'].toString());
        //print(resData["msg"].toString());
        isloading.value = false;
      }
    } catch (e) {}
  }

  resend_otpmobile(mobile) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    // // var isLogedIn = shared_preferences.getString('user1_id');
    Map body = {"mobile_number": mobile.toString(), "choose_status": "1"};
    print("ppp");
    try {
      var res = await http.post(Uri.parse("${base_url}resendOtp"), body: body);
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print(resData["data"].toString());
        var otpSet = sharedPreferences.setString(
            'otp', resData["data"]["otp"].toString());
        // verify_otp_user.resentagain();
        print("resent${resData["data"]}");
        newotp.value = resData["data"]["otp"].toString();
        update();
      } else {
        Utils().sendMassage(resData['message'].toString());
        //print(resData["msg"].toString());
      }
    } catch (e) {}
  }

  resend_otpemail(email) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    // // var isLogedIn = shared_preferences.getString('user1_id');
    Map body = {"email": email.toString(), "choose_status": "2"};
    try {
      var res = await http.post(Uri.parse("${base_url}resendOtp"), body: body);
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        update();
        print(resData["data"].toString());
        var otpSet = sharedPreferences.setString(
            'otp', resData["data"]["otp"].toString());
        newotp.value = resData["data"]["otp"].toString();
        update();
        // verify_otp_user.resentagain();
      } else {
        Utils().sendMassage(resData['message'].toString());
        //print(resData["msg"].toString());
      }
    } catch (e) {}
  }
}
