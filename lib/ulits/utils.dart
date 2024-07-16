import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utils {
  void sendMassage(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.black87,
    );
  }

  void alertbox(String msg) {
    Get.defaultDialog(
        //title: "Error",
        middleText: msg,
        confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("OK")),
        titleStyle: const TextStyle(fontWeight: FontWeight.bold));
  }
}
