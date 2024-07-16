import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/models/inntCategoryListModel.dart';

import '../ulits/constant.dart';
import 'maincategory.dart';

class fetchInntCategoryList extends GetxController {
  List<InntCategoryListModel> inntCategory = [];



  Future<List<InntCategoryListModel>> categoryList() async {
    final response = await http.post(Uri.parse('${base_url}InntCategory_list'),
    body: {
      "maincategoryId":maincate[0].toString()
        }
    );
    var decodedData = json.decode(response.body);
    List privacypolicy = decodedData['data'];
    if (response.statusCode == 200) {
      inntCategory.clear();

      for (var i in privacypolicy) {
        inntCategory.add(InntCategoryListModel.fromJson(i));
      }
      return inntCategory;

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load innt category list');
    }
  }



}
