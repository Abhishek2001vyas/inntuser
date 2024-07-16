import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ulits/constant.dart';



class Getuserprofile_api extends GetxController {
  RxBool isloading = false.obs;
  RxList profiledata = [].obs;
  RxList friendslist=[].obs;
  RxList myfriendsearchlisttt=[].obs;
late RxString gender=  "male".obs ;

  void loader() {
    isloading.value = true;
    update();
  }

  Future userprofile() async {
    loader();
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    var token = sharedPreferences.get("token");
    print("ddd$token $userid");
    try {
      var res =
          await http.post(Uri.parse("${base_url}getUser_profile"),
      //         headers: {
      //   "token": token.toString()
      // },
              body: {
        'userId': userid.toString(),
      });
      var resData = json.decode(res.body);
      print("iuy$resData");
      profiledata.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        profiledata.add(resData["data"]);
        print("genderrr ${profiledata[0][0]["gender"]}");
        if(profiledata[0][0]["gender"] !=" "){
          gender.value=  "${profiledata[0][0]["gender"]}";
        }
        // Utils().sendMassage('${resData['message'].toString()}');
        update();
        print("ffff" + resData["data"]);
        isloading.value = false;

        return profiledata;
      } else {
        print("ppppppppioi");
        // Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {}
  }

  Future myfriends() async {

    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    try {
      var res =
      await http.post(Uri.parse("${base_url}friendList"),
          body: {
            "userId":userid.toString(),

          });
      var resData = json.decode(res.body);
      print("iuy$resData");
       friendslist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        friendslist.add(resData);

        update();


        return friendslist;
      } else {
        print("ppppppppioi");
        //Utils().sendMassage('${resData['message'].toString()}');

      }
    } catch (e) {
      print("errorrrfriends $e");
    }
  }

  searchmyfriends(String searchTerm) {
    // Convert the search term to lowercase for case-insensitive search

    String searchTermLower = searchTerm.toLowerCase();
    myfriendsearchlisttt.clear();
print("ggggddd");
    for (var myfriendss in friendslist[0]["data"]) {
      print("ggggddd $myfriendss");
      List<int> indices = [];
      if (myfriendss["friendId"]["first_name"]
          .toLowerCase()
          .contains(searchTermLower) || myfriendss["friendId"]["last_name"]
          .toLowerCase()
          .contains(searchTermLower)) {
        myfriendsearchlisttt.add(myfriendss);
        print('kkkkkkkddd1 ${myfriendsearchlisttt.length}');
        print('kkkkkkkddd $myfriendsearchlisttt');
      }

    }

    return myfriendsearchlisttt;
  }
}
