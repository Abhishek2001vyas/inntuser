import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chatlistt.dart';
import '../models/filtermessage.dart';
import '../ulits/constant.dart';
import '../ulits/utils.dart';

class meassage_api extends GetxController {
  final StreamController _streamController = StreamController();
  RxList<chatlistt> chatlistlist = <chatlistt>[].obs;
  RxList<chatlisttr> chatlistlistttt = <chatlisttr>[].obs;
  RxInt changee = 0.obs;
  RxList uservenderchatlist = [].obs;
  RxBool loading = false.obs;
  var imagePath = ''.obs;

  Future<RxList<chatlistt>?> chatlist() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    final response = await http.post(Uri.parse('${base_url}allChatList'),
        body: {"userId": userid.toString()});
    var decodedData = json.decode(response.body);
    chatlistlist.clear();
    if (response.statusCode == 200) {
      chatlistlist.add(chatlistt.fromJson(decodedData));
      return chatlistlist;
    } else {
      Utils().sendMassage(decodedData['message'].toString());
    }
    return null;
  }

  Future<RxList<chatlisttr>?> chatlistfriends() async {
    chatlistlistttt.clear();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    final response = await http.post(Uri.parse('${base_url}friendChatList'),
        body: {"userId": userid.toString()});
    var decodedData = json.decode(response.body);
    if (response.statusCode == 200) {
      chatlistlistttt.add(chatlisttr.fromJson(decodedData));
      return chatlistlistttt;
    } else {
      Utils().sendMassage(decodedData['message'].toString());
    }
    return null;
  }

  Future chatsendlist(venderId, text, status) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    final response = await http.post(Uri.parse('${base_url}userSend_message'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          if (status == 1) "venderId": venderId.toString(),
          if (status == 3) "friendId": venderId.toString(),
          "text": text,
          "send_status": status.toString(),
          "userId": userid
        }));

    var decodedData = json.decode(response.body);

    if (response.statusCode == 200 && decodedData["result"] == "true") {
      Utils().sendMassage(decodedData['message'].toString());
    } else {
      Utils().sendMassage(decodedData['message'].toString());
    }
  }

  chatimageapi(venderId, text, shopname, venderimage, status) async {
    loading.value = true;
    update();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    print("texx $text");
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("${base_url}userSend_message"));
      request.fields.addAll({
        if (status == 1) "venderId": venderId.toString(),
        if (status == 3) "friendId": venderId.toString(),
        "send_status": status.toString(),
        "userId": userid.toString()
      });

      request.files.add(await http.MultipartFile.fromPath(
        "text",
        text.toString(),
        contentType: MediaType(
          'image',
          'png',
        ),
      ));

      http.StreamedResponse response1 = await request.send();
      print("texxx2 ${response1.reasonPhrase}");
      var responseString = await response1.stream.bytesToString();
      var jsonResponse = json.decode(responseString.toString());
      if (response1.statusCode == 200) {
        if (jsonResponse['result'].toString() == "true".toString()) {
          loading.value = false;
          update();
          Get.back();
        }
      } else {
        loading.value = false;
        update();
        Utils().sendMassage("${jsonResponse["message"]}");
      }
    } catch (e) {
      loading.value = false;
      update();
    }
  }

  Future<List<dynamic>?> uservenderchat(venderId, status) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    final response =
        await http.post(Uri.parse('${base_url}userGet_message'), body: {
      if (status == 1) "venderId": venderId.toString(),
      if (status == 3) "friendId": venderId.toString(),
      "userId": userid.toString()
    });

    var decodedData = json.decode(response.body);

    uservenderchatlist.clear();
    if (response.statusCode == 200) {
      uservenderchatlist.add(decodedData);
      return uservenderchatlist;
    } else {}
    return null;
  }
}
