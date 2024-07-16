import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/Api/maincategory.dart';

import '../models/inntOutCategoryListModel.dart';
import '../ulits/constant.dart';

class fetchInntOutCategoryList extends GetxController {
  List<InntOutCategoryListModel> inntOutCategory = [];

  Future<List<InntOutCategoryListModel>> inntOutCategoryList() async {
    final response =
        await http.post(Uri.parse('${base_url}InntCategory_list'),body: {
          "maincategoryId":maincate1[0].toString()
        });
    var decodedData = json.decode(response.body);
    List privacypolicy = decodedData['data'];
    if (response.statusCode == 200) {
      inntOutCategory.clear();

      for (var i in privacypolicy) {
        inntOutCategory.add(InntOutCategoryListModel.fromJson(i));
      }

      return inntOutCategory;

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load innt category list');
    }
  }
}
