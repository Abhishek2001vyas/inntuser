import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ulits/constant.dart';
import '../ulits/utils.dart';

class Gift_api extends GetxController {

  RxList sentgiftlistt =[].obs;
  RxList recivedgiftlistt =[].obs;

  Future sendgift(message,selectOne,name,contactMedium,amount) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    try {
      final response =
      await http.post(Uri.parse('${base_url}sendGift'),
          body: {
            "sender_userId": userid.toString(),
            "message": message.toString(),
            "selectOne": selectOne.toString(),
          if(selectOne==2) "name": name.toString(),
            "contact_medium": contactMedium.toString(),
            "amount": amount.toString(),



          });
      var decodedData = json.decode(response.body);
      if (response.statusCode == 200 &&
          decodedData["result"].toString() == "true".toString()) {
        Utils().sendMassage(decodedData['message'].toString());
      } else {
        Utils().sendMassage(decodedData['message'].toString());
        print("jjj $decodedData");

      }
    }catch(e){
      print("error $e");
    }
  }

  Future sentgiftlist() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print("useid$userid");
    try {
      final response =
      await http.post(Uri.parse('${base_url}sentGigt_list'),
          body: {
            "sender_userId": userid,
          });
      var decodedData = json.decode(response.body);
      sentgiftlistt.clear();
      if (response.statusCode == 200 &&
          decodedData["result"].toString() == "true".toString()) {
        sentgiftlistt.add(decodedData);
        print("${sentgiftlistt[0]["data"]![0]}");
        //  Utils().sendMassage('${decodedData['message'].toString()}');
        return sentgiftlistt;
      } else {
       // Utils().sendMassage('${decodedData['message'].toString()}');
        throw Exception('Failed to load innt category list');
      }
    }catch(e){
      print("error $e");
    }
  }

  Future recivedgiftlist() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    print("useid$userid");
    try {
      final response =
      await http.post(Uri.parse('${base_url}getGift_list'),
          body: {
            "userId": userid,
          });
      var decodedData = json.decode(response.body);
      recivedgiftlistt.clear();
      if (response.statusCode == 200 &&
          decodedData["result"].toString() == "true".toString()) {
        recivedgiftlistt.add(decodedData);
        print("${recivedgiftlistt[0]["data"]![0]}");
        //  Utils().sendMassage('${decodedData['message'].toString()}');
        return recivedgiftlistt;
      } else {
        // Utils().sendMassage('${decodedData['message'].toString()}');
        throw Exception('Failed to load innt category list');
      }
    }catch(e){
      print("error $e");
    }
  }

}
