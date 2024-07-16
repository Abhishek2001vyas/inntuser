 import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../ulits/constant.dart';


List bannerlist = [];
List inntfooterbannerlist = [];
List inntoutheaderbannerlist = [];
List inntoutfooterbannerlist = [];


class bannerlist_api extends GetxController {



  @override
  void onInit() {
    // TODO: implement onInit
    getbannerlist();
    getinntfooterbannerlist();
    getinntoutheaderbannerlist();
    getinntoutfooterbannerlist();
    super.onInit();
  }

  void getbannerlist() async {
    print("pppppppppppppppp+++++++++++++++++++");
    try {
      var res = await http.get(
        Uri.parse("${base_url}banner_list"),
      );
      // print("klidfkdk ${res.body}");
      var resData = json.decode(res.body);
      bannerlist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print("ihfdsihlif");
        bannerlist.add(resData["data"]);
        print("ihfdsihlif$bannerlist");
      } else {
        //Utils().sendMassage('${resData['msg'].toString()}');
        //print(resData["msg"].toString());
      }
    } catch (e) {}
  }

  void getinntfooterbannerlist() async {
    print("inntfooterbannerlist+++++++++++++++++++");
    try {
      var res = await http.get(
        Uri.parse("${base_url}inntFooterbanner_list"),
      );
      // print("klidfkdk ${res.body}");
      var resData = json.decode(res.body);
      inntfooterbannerlist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print("ihfdsihlif");
        inntfooterbannerlist.add(resData["data"]);
        print("ihfdsihlif$bannerlist");
      } else {
        //Utils().sendMassage('${resData['msg'].toString()}');
        //print(resData["msg"].toString());
      }
    } catch (e) {}
  }

  void getinntoutheaderbannerlist() async {
    print("inntoutheaderbannerlist+++++++++++++++++++");
    try {
      var res = await http.get(
        Uri.parse("${base_url}inntOutHeaderbanner_list"),
      );
      // print("klidfkdk ${res.body}");
      var resData = json.decode(res.body);
      inntoutheaderbannerlist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print("ihfdsihlif");
        inntoutheaderbannerlist.add(resData["data"]);
        print("ihfdsihlif$bannerlist");
      } else {
        //Utils().sendMassage('${resData['msg'].toString()}');
        //print(resData["msg"].toString());
      }
    } catch (e) {}
  }

  void getinntoutfooterbannerlist() async {
    print("inntoutfooterbannerlist+++++++++++++++++++");
    try {
      var res = await http.get(
        Uri.parse("${base_url}inntOutFooterbanner_list"),
      );
      // print("klidfkdk ${res.body}");
      var resData = json.decode(res.body);
      inntoutfooterbannerlist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print("ihfdsihlif");
        inntoutfooterbannerlist.add(resData["data"]);
        print("ihfdsihlif$bannerlist");
      } else {
        //Utils().sendMassage('${resData['msg'].toString()}');
        //print(resData["msg"].toString());
      }
    } catch (e) {}
  }


}
