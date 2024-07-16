import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/ulits/constant.dart';

class fetchPrivacyPolicy extends GetxController {
  List privacyPolicyList = [];

  Future privacy_Policy() async {
    final response = await http.get(Uri.parse("${base_url}privacyPulicy_list"));
    privacyPolicyList.clear();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print(data["data"]);
      privacyPolicyList.add(data["data"]);
      // print("jjfifiiiii");
      // print(":jkdkhldkd..........."+termCondition[0][0]["title"].toString());
      // return bannerList[0];
    } else {
      throw Exception('Failed to load privacy policy');
    }
  }
}
