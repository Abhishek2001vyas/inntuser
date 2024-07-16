import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:inntuser/screen/Users/Navgationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ulits/constant.dart';
import '../../../ulits/utils.dart';
import '../screen/Users/updatemobileotp.dart';

class updateprofileapi extends GetxController {
  RxBool isloading = false.obs;
  RxList resw = [].obs;
  void loader() {
    isloading.value = true;
    update();
  }

  updateprofile(firstName, lastName, email, mobile, image, date,gender) async {
    print("fsedfds$date");
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.get("user_id");
    var token = sharedPreferences.getString("token");
    print("hhi$token ");
    loader();resw.clear();
    if (image != "") {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse("${base_url}updateUser_profile"),
        );
        var headers = {'token': token.toString()};
        request.headers.addAll(headers);
        request.fields.addAll({
          "first_name": firstName.toString(),
          "last_name": lastName.toString(),
          "email": email.toString(),
          "mobile_number": mobile.toString(),
          "userId": userid.toString(),
          "dob": date.toString(),
          "gender": gender.toString(),
        });
        print("shlkihlh");
        request.files.add(await http.MultipartFile.fromPath(
          "user_profile",
          image.toString(),
          contentType: MediaType(
            'image',
            'png',
          ),
        ));

        http.StreamedResponse response1 = await request.send();
        print(response1.statusCode);
        if (response1.statusCode == 200) {
          var responseString = await response1.stream.bytesToString();
          var jsonResponse = json.decode(responseString.toString());
          if (jsonResponse['result'].toString() == "true".toString()) {
            Utils().sendMassage(jsonResponse['message'].toString());
            isloading.value = false;
            print("cvdxvgfdgbf${jsonResponse["updateData"]}");
            update();
            isloading.value = false;
            resw.add(jsonResponse);  print("fijhfijh $resw");
           return  Get.to(Verify_updatemobile(mobile: jsonResponse["updateData"]["newmobile_number"],otp: jsonResponse["updateData"]["otp"],));

          }
        } else {
          isloading.value = false;
          // Utils().alertbox(
          //     '${jsonResponse['msg'].toString()} Please fill all field & all photo');
          print(response1.toString());
        }
      } catch (e) {}
    } else {
      try {
        var res = await http
            .post(Uri.parse("${base_url}updateUser_profile"), headers: {
          "token": token.toString()
        }, body: {
          "userId": userid.toString(),
          "first_name": firstName.toString(),
          "last_name": lastName.toString(),
          "email": email.toString(),
          "mobile_number": mobile.toString(),
          "dob": date.toString(),
          "gender": gender.toString(),
        });
        var resData = json.decode(res.body);
        print(resData);
        if (res.statusCode == 200 &&
            resData["result"].toString() == "true".toString()) {
          Utils().sendMassage(resData['message'].toString());
          update();
          print(resData["updateData"].toString());
          isloading.value = false;
          resw.add(resData);
          print("fijhfijh $resw");
          return
            Get.to(Verify_updatemobile(
              mobile: resData["updateData"]["newmobile_number"],
              otp: resData["updateData"]["otp"],));

          //Get.off(ViewProfile());
        } else {
          Utils().sendMassage(resData['message'].toString());
          //print(resData["msg"].toString());
          isloading.value = false;
        }
      } catch (e) {}
    }
    print("jijj");
  }

  Future updatemobile(phone) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    try {
      var res =
      await http.post(Uri.parse("${base_url}updatePhone"),  body: {
        'userId': userid.toString(),
        "phone": phone.toString()
      });
      var resData = json.decode(res.body);
      print("iuy$resData");
      //profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {

        // profiledata.add(resData["data"]);
        Utils().sendMassage(resData['message'].toString());
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;


      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) {}
  }


  Future updatemobileverfiyotp(otp) async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print("fijhfijh ${resw[0]["updateData"]["newuser_profile"]}  $resw");
    try {
      var res =
      await http.post(Uri.parse("${base_url}verifyPhone"),  body: {
        'userId': userid.toString(),
        "otp": otp.toString(),

      if(resw[0]["updateData"]["newuser_profile"]!=" ")"user_profile": resw[0]["updateData"]["newuser_profile"].toString(),
      if(resw[0]["updateData"]["newfirst_name"]!="")   "first_name": resw[0]["updateData"]["newfirst_name"].toString(),
      if(resw[0]["updateData"]["newlast_name"]!="") "last_name": resw[0]["updateData"]["newlast_name"].toString(),
      if(resw[0]["updateData"]["newdob"]!="") "dob":resw[0]["updateData"]["newdob"].toString(),
      if(resw[0]["updateData"]["newemail"]!="") "email": resw[0]["updateData"]["newemail"].toString(),
      if(resw[0]["updateData"]["newmobile_number"]!="")  "mobile_number": resw[0]["updateData"]["newmobile_number"].toString(),
      if(resw[0]["updateData"]["newgender"]!="")  "gender": resw[0]["updateData"]["newgender"].toString(),
        // "newMobile_number":newMobile_number.toString()
      });
      var resData = json.decode(res.body);
      print("iuy$resData");
      //profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
     print("huihhdgihi $resData");
       currentTab=0;
        Get.offAll(const DashBoardScreen());
        // profiledata.add(resData["data"]);
        Utils().sendMassage(resData['message'].toString());
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;


      } else {
        print("ppppppppioi");
        Utils().sendMassage(resData['message'].toString());
        isloading.value = false;
      }
    } catch (e) { isloading.value = false;}
  }
}
