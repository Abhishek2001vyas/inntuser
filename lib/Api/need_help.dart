import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/ulits/constant.dart';

class fetchNeedHelp extends GetxController {
  List needHelp = [];

  Future need_Help() async {
    final response = await http.get(Uri.parse("${base_url}faq_list"));
    needHelp.clear();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print(data["data"]);
      needHelp.add(data["data"]);
      // print("jjfifiiiii");
      // print(":jkdkhldkd..........."+termCondition[0][0]["title"].toString());
      // return bannerList[0];
    } else {
      throw Exception('Failed to load term and condition');
    }
  }
}
