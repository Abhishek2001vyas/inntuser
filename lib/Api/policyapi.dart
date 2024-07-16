// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../../ulits/constant.dart';
//
//
//
// List aboutUs_list = [];
//
// class aboutUs_api extends GetxController {
//
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     aboutUs();
//     super.onInit();
//   }
//   aboutUs() async {
//     try {
//       var res = await http.get(
//         Uri.parse("${base_url}aboutUs_list"),
//       );
//       var resData = json.decode(res.body);
//       aboutUs_list.clear();
//       if (res.statusCode == 200 &&
//           resData["result"].toString() == "true".toString()) {
//         aboutUs_list.add(resData["data"]);
//
//       } else {
//       }
//     } catch (e) {}
//   }
//
// }
