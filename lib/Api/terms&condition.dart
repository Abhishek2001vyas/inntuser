// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../../ulits/constant.dart';
//
//
//
// List termscondition = [];
// List privacy = [];
// class terms_api extends GetxController {
//
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     condition();
//     super.onInit();
//   }
//   condition() async {
//     print("iuhiohoih");
//     try {
//       var res = await http.get(
//         Uri.parse("${base_url}termAndCondiction"),
//       );
//       var resData = json.decode(res.body);
//       termscondition.clear();
//       if (res.statusCode == 200 &&
//           resData["result"].toString() == "true".toString()) {
//         print("ihfdsihlif");
//         termscondition.add(resData["data"]);
//         return termscondition;
//       } else {
//       }
//     } catch (e) {}
//   }
//
//
//   policy() async {
//     print("iuhiohoih");
//     try {
//       var res = await http.get(
//         Uri.parse("${base_url}privacyPulicy_list"),
//       );
//       var resData = json.decode(res.body);
//       privacy.clear();
//       if (res.statusCode == 200 &&
//           resData["result"].toString() == "true".toString()) {
//         print("ihfdsihlif");
//         privacy.add(resData["data"]);
//         return termscondition;
//       } else {
//       }
//     } catch (e) {}
//   }
// }
