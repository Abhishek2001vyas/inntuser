import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../ulits/constant.dart';
import '../../../ulits/utils.dart';
import '../Controller/controller.dart';
import '../screen/credential/Login/otp_Login.dart';

class Signupapi extends GetxController {
  RxBool isloading = false.obs;
  GetxControllers controller = Get.put(GetxControllers());

  void loader() {
    isloading.value = true;
    update();
  }

  signupApi(firstName, lastName, email, mobile, password, conformPassword,
      friendReferralCode, fcmId, image, countrycode) async {
    loader();
    List<int> imageBytes=[];
 if( image == "")   imageBytes = await readAssetImage();
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse("${base_url}userSignup"));
      request.fields.addAll({
        "first_name": firstName.toString(),
        "last_name": lastName.toString(),
        "email": email.toString(),
        "mobile_number": mobile.toString(),
        "password": password.toString(),
        "conform_password": conformPassword.toString(),
        "friend_referral_code": friendReferralCode.toString(),
        "fcm_id": fcmId.toString()
      });
      image == ""
          ? request.files.add(http.MultipartFile.fromBytes(
              "user_profile",
              imageBytes,
              filename: 'user_profile.jpg',
              contentType: MediaType('image', 'jpeg'),
            ))
          : request.files.add(await http.MultipartFile.fromPath(
              "user_profile",
              image.toString(),
              contentType: MediaType(
                'image',
                'png',
              ),
            ));
print("kjjjjd");
      http.StreamedResponse response1 = await request.send();
      print(response1.statusCode);
      var responseString = await response1.stream.bytesToString();
      var jsonResponse = json.decode(responseString.toString());
      if (response1.statusCode == 200) {
        print('oo;oi$jsonResponse');
        if (jsonResponse['result'].toString() == "true".toString()) {
          Utils().sendMassage("Signup Successfully");
          isloading.value = false;
          update();
          isloading.value = false;
          controller.imagePath.value = "";
          update();
          print("signup$responseString");
          Get.to(Verify_Login(
            countrycode: countrycode,
            otp: jsonResponse["data"]["otp"],
            email: jsonResponse["data"]["email"],
            mobile: jsonResponse["data"]["mobile_number"],
          ));
        }
      } else {
        isloading.value = false;
        Utils().sendMassage("${jsonResponse["message"]}");
        // Utils().alertbox(
        //     '${jsonResponse['msg'].toString()} Please fill all field & all photo');
        print(response1.toString());
      }
    } catch (e) {
      isloading.value = false;
      print("dd$e");}
  }

  Future<List<int>> readAssetImage() async {
    // print("asssst $assetPath");

    ByteData data = await rootBundle.load("assets/images/th-_1_.jpg");
    print("oooo");
    List<int> bytes = data.buffer.asUint8List();
    print("kklkl");
    return bytes;
  }
}
