import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ulits/constant.dart';
import '../ulits/utils.dart';

class Inntoutaddcard extends GetxController {

  late RxList selectedarr=[].obs;


  Future Inntout_addcard(productid,size) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
print("useidtt$userid  $selectedarr");
    try {
      final response =
      await http.post(Uri.parse('${base_url}AddInntoutCart'),
          headers: {
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            "userId": userid,
            "productId": productid,
            "attributes":selectedarr,
            "qty": "1"
          }));
      var decodedData = json.decode(response.body);
      if (response.statusCode == 200 &&
          decodedData["result"].toString() == "true".toString()) {
        Utils().sendMassage(decodedData['message'].toString());
      } else {
        Utils().sendMassage(decodedData['message'].toString());
        throw Exception('Failed to load innt category list');
      }
    }catch(e){
      print("errortt $e");
    }
  }



}
