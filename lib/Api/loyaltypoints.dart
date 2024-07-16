import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/screen/Users/Navgationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ulits/constant.dart';
import '../screen/Users/verifycashback.dart';
import '../ulits/utils.dart';



class loyaltypointsapi extends GetxController {
  RxBool isloading = false.obs;
  RxList profiledata = [].obs;
  RxList friendslist=[].obs;
  RxBool erorrcashback = false.obs;

  void loader() {
    isloading.value = true;
    update();
  }

  Future cashback(mobile) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");


    try {
      var res =
      await http.post(Uri.parse("${base_url}addCashback"),
          body: {
            'userId': userid.toString(),
          });
      var resData = json.decode(res.body);
      print("iuy$resData");

      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Get.to( Verify_cashback(mobile:mobile ,otp: resData["data"]["otp"],));

         Utils().sendMassage(resData['message'].toString());
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;


      } else {
        print("ppppppppioi");
        // Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {}
  }

  Future verifycashback(otp) async {

    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res =
      await http.post(Uri.parse("${base_url}verificationCashback_otp"),
          body: {
            "userId":userid.toString(),
            "otp":otp.toString()

          });
      var resData = json.decode(res.body);
      print("iuy$resData");

      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
      currentTab=0;
      Get.offAll(const DashBoardScreen());
      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());

      }
    } catch (e) {
      print("errorrrfriends $e");
    }
  }

  Future sendloyatlypoints(points,key) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    try {
      var res =
      await http.post(Uri.parse("${base_url}sendloyalty_points"),
          body: {
            'senderId': userid.toString(),
            "key":key.toString(),
            "points":points.toString()
          });
      var resData = json.decode(res.body);
      print("iuy$resData");

      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        currentTab=0;
        Get.offAll(const DashBoardScreen());
        Utils().sendMassage(resData['message'].toString());
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;

      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {print("error$e");}
  }


}
