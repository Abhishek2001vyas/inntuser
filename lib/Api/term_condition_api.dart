import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/ulits/constant.dart';

class fetchTermCondition extends GetxController {
  List termCondition = [];

  Future term_Condition() async {
    final response = await http.get(Uri.parse("${base_url}termAndCondiction"));
    termCondition.clear();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      termCondition.add(data["data"]);
    } else {
      throw Exception('Failed to load term and condition');
    }
  }
}
