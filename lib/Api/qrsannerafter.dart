import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/screen/Users/Navgationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ulits/constant.dart';
import '../screen/Users/Addfriends.dart';
import '../screen/Users/pay.dart';
import '../screen/Users/productdeatils.dart';
import '../screen/Users/qrorderdetails.dart';
import '../screen/Users/sellers/sellerdeatils.dart';
import '../screen/Users/verifypay.dart';
import '../ulits/utils.dart';

class Getdatafromqr_api extends GetxController {
  RxBool isloading = false.obs;
  RxList profiledata = [].obs;
  RxBool erorr = false.obs;
  RxBool passwordObscured = true.obs;
  RxList profiledata1 = [].obs;

  void loader() {
    isloading.value = true;
    update();
  }

  Future qrscannerr(qrcode) async {
    print('kklfiifo $qrcode');
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}getDataToQrcode"), body: {
        'qrcode': qrcode.toString(),
      });
      var resData = json.decode(res.body);
      print("iuy$resData");
      profiledata.clear();
      profiledata1.clear();
      var res1 = await http.post(Uri.parse("${base_url}getUser_profile"),
          //         headers: {
          //   "token": token.toString()
          // },
          body: {
            'userId': userid.toString(),
          });
      var resData1 = json.decode(res1.body);
      if (res.statusCode == 200 &&
          res1.statusCode == 200 &&
          resData1["result"].toString() == "true".toString() &&
          resData["result"].toString() == "true".toString()) {
        print("");
        profiledata1.add(resData1);
        profiledata.add(resData);
        resData["message"] ==
                "Vendor Product details QR code scanned successfully"
            ? Get.to(Product_deatils(
                sourceName: resData["qrcodes"]["qrcode_name"].toString(),
                subsubcateid: resData["data"]["_id"].toString(),
                shopid: resData["data"]["venderId"].toString(),
              ))
            : resData["message"] ==
                    "Vendor Shop details QR code scanned successfully"
                ? Get.to(SellerDetails(
                    sourceName: resData["qrcodes"]["qrcode_name"].toString(),
                    shopanme: resData["data"]["shop_name"].toString(),
                    shopid: resData["data"]["_id"].toString(),
                  ))
                : resData["data"]["friend_qrcode"].toString() == qrcode
                    ? Get.to(const Add_Friends())
                    : resData["data"]["payment_qrcode"].toString() == qrcode
                        ? Get.to(Pay(
                            qrcode: qrcode,
                          ))
                        : resData["data"]["qrcodes"].toString() == qrcode
                            ? Get.to(Qrorderdetails())
                            : null;

        // Utils().sendMassage('${resData['message'].toString()}');
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;

        return profiledata;
      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {
      print("errorrr $e");
    }
  }

  Future addfriends() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}Addfriends"), body: {
        "userId": userid.toString(),
        "friendId": profiledata[0]["data"]["_id"].toString(),
        'qrcode': profiledata[0]["data"]["friend_qrcode"].toString(),
      });
      var resData = json.decode(res.body);
      print("iuy$resData");
      // profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        currentTab = 0;

        Get.offAll(const DashBoardScreen());

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

  Future sendMoney_request(amount, qrcode) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res =
          await http.post(Uri.parse("${base_url}sendMoney_request"), body: {
        "senderId": userid.toString(),
        "amount": amount.toString(),
        'qrcode': qrcode.toString(),
      });
      var resData = json.decode(res.body);

      var res1 = await http.post(Uri.parse("${base_url}getUser_profile"),
          //         headers: {
          //   "token": token.toString()
          // },
          body: {
            'userId': userid.toString(),
          });
      var resData1 = json.decode(res1.body);
      print("iuy$resData");
      // profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        print("fjjgfjggj $resData1");
        Get.to(Verify_pay(
            amount: resData['data']["amount"],
            reid: resData['data']["receiverId"],
            otp: resData['data']["otp"],
            mobile: resData1["data"][0]["mobile_number"] ?? "00",
            id: resData['data']["senderId"]));

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

  Future verifypay(id, otp, amount, receiverId) async {
    print("fffff $id $otp  $amount $receiverId");
    try {
      var res = await http
          .post(Uri.parse("${base_url}verificationsendMoney_otp"), body: {
        "senderId": id.toString(),
        "otp": otp.toString(),
        "receiverId": receiverId.toString(),
        "amount": amount.toString()
      });
      var resData = json.decode(res.body);
      print("iuy$resData");
      // profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage(resData['message'].toString());
        currentTab = 0;
        Get.offAll(const DashBoardScreen());
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

  // verifypay(body) async {
  //   loader();
  //
  //   try {
  //     var res = await http.post(Uri.parse("${base_url}verificationsendMoney_otp"),
  //         body: body);
  //     var resData = json.decode(res.body);
  //     print("qqqq$resData");
  //     if (res.statusCode == 200 &&
  //         resData["result"].toString() == "true".toString()) {
  //
  //       Utils().sendMassage('${resData['message'].toString()}');
  //       update();
  //       print(resData["data"].toString());
  //       isloading.value = false;
  //       print("done");
  //       // forgot==null?
  //       currentTab=0;
  //       Get.offAll(DashBoardScreen());
  //       //: Get.to(newpassword(mobile: forgot,));
  //     } else {
  //       Utils().sendMassage('${resData['message'].toString()}');
  //       //print(resData["msg"].toString());
  //       isloading.value = false;
  //     }
  //   } catch (e) {}
  // }
}
