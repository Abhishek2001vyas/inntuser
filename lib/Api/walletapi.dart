import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/screen/Users/Navgationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ulits/constant.dart';
import '../screen/Users/trasferdatawallet.dart';
import '../ulits/utils.dart';



class wallet_api extends GetxController {
  RxBool isloading = false.obs;
  RxList profiledata = [].obs;
  RxBool erorr = false.obs;
  RxList transjectionlist =[].obs;

  void loader() {
    isloading.value = true;
    update();
  }


  Future tranferMoney(amount,mobile,) async {

    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res =
      await http.post(Uri.parse("${base_url}tranferMoney"),
          body: {
            "senderId":userid.toString(),
            "amount":amount.toString(),
            'key': mobile.toString(),
          });
      var resData = json.decode(res.body);

      var res1 =
      await http.post(Uri.parse("${base_url}getUser_profile"),
          //         headers: {
          //   "token": token.toString()
          // },
          body: {
            'userId': userid.toString(),
          });
      var resData1= json.decode(res1.body);
      print("iuy$resData");
      // profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {

        Utils().sendMassage(resData['message'].toString());

        Get.to( Trasferdatawallet(
            amount: resData['data']["amount"],
            // reid: resData['data']["receiverId"],
            otp: resData['data']["otp"],
            name: "${resData['data']["fname"]} ${resData['data']["lname"]}",
            mobile: resData1["data"][0]["mobile_number"]??"00",
            recid: resData['data']["receiverId"]
        ));

        update();
        print("ffff" + resData["data"]);
        isloading.value = false;

      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      print("errorrr $e");
    }



  }

  Future verifypay(otp,amount,receiverId) async {


    print("fffff  $otp  $amount $receiverId");
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    try {
      var res =
      await http.post(Uri.parse("${base_url}verificationsendMoney_otp"),
          body: {
            "senderId":userId.toString(),
            "otp":otp.toString(),
            "receiverId":receiverId.toString(),
            "amount":amount.toString()

          });
      var resData = json.decode(res.body);
      print("iuy$resData");
      // profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {

        Utils().sendMassage(resData['message'].toString());
        currentTab=0;
        Get.offAll(const DashBoardScreen ());
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;

      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      print("errorrr $e");
    }



  }


  Future transjection_history() async {

    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res =
      await http.post(Uri.parse("${base_url}transjection_history"),
          body: {
            "userId":userid.toString(),

          });
      var resData = json.decode(res.body);


      print("iuy$resData");
      transjectionlist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        transjectionlist.add(resData);

        update();
        print("ffff" + resData["data"]);
        isloading.value = false;

      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      print("errorrr $e");
    }



  }




}
