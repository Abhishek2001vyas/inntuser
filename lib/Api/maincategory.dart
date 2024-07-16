import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../ulits/constant.dart';

List maincate=[];
List maincate1=[];
class fetchmaintCategoryList extends GetxController {


@override
  void onInit() {
    // TODO: implement onInit
  maincategoryList();
  super.onInit();
  }

  Future   maincategoryList() async {
    final response = await http.get(Uri.parse('${base_url}InntOutCategory_list'),

    );
    var decodedData = json.decode(response.body);
    //List privacypolicy = decodedData['data'];
    if (response.statusCode == 200) {
      maincate.clear();
      maincate1.clear();
      for (var i=0; i< decodedData["data"].length ;i++){
        decodedData['data'][i]["maincategory_englishName"]=="Innt"?
            maincate.add(decodedData['data'][i]["_id"]): maincate1.add(decodedData['data'][i]["_id"]);
      }



      print(maincate.toString()+maincate1.toString());
      return maincate;

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load maincate category list');
    }
  }



}
