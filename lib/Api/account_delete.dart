import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/ulits/constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/credential/Login/login.dart';
import '../ulits/utils.dart';


class account_deletee extends GetxController{


  Future account_delettee(text,reason,context) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");

    try{
      final response = await http.post(Uri.parse("${base_url}deleteUser"),
          body: {
            "userId":userId.toString(),
        if(reason =="other") "text":text.toString(),
            "reason":reason.toString()
          }

      );
      var resData =jsonDecode(response.body);
      if (response.statusCode == 200 && resData["result"].toString() == "true".toString() ) {
        deleteMyAccountDialog(context);
        var sharedPreferences = await SharedPreferences.getInstance();
        Future.delayed(Duration(seconds:  10),() {


          sharedPreferences.remove("user_id");
          Get.offAll(() => const Login_email());});

      } else {
         Utils().sendMassage(resData['message'].toString());
      }
    }catch(e){

    }
  }

  deleteMyAccountDialog(context) async {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return

      Get.dialog(
        barrierDismissible: false,
          Dialog(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(width: w/1,height: h/5,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Your account has been deleted",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w400,
                          fontSize: 20
                      ),
                    ),
                    Text("We hope to see you soon !",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w400,
                          fontSize: 20
                      ),
                    ),
                    Icon(Icons.check_circle_outline,size: 70,color: logocolo,)

                  ],
                ),
              ),
            ),
          )
      );


  }
}
