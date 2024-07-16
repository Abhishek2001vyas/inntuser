import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../ulits/constant.dart';

List faqlist = [];

class faq_api extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    faq();
    super.onInit();
  }

  faq() async {
    print("iuhiohoihddddd");
    try {
      var res = await http.get(
        Uri.parse("${base_url}faq_list"),
      );
      var resData = json.decode(res.body);
      faqlist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print("ihfdsihlifoooo");
        faqlist.add(resData["data"]);
        print(faqlist);
        return faqlist;
      } else {}
    } catch (e) {}
  }
}
