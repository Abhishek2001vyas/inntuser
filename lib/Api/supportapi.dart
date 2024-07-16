import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../ulits/constant.dart';

List contactUslist = [];

class support_api extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    contactUs();
    super.onInit();
  }

  contactUs() async {
    print("iuhiohoihddddd");
    try {
      var res = await http.get(
        Uri.parse("${base_url}contactUs_list"),
      );
      var resData = json.decode(res.body);
      contactUslist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print("ihfdsihlifoooo");
        contactUslist.add(resData["data"][0]);
        return contactUslist;
      } else {}
    } catch (e) {}
  }
}
