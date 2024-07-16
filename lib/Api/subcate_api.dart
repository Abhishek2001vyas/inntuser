import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../ulits/constant.dart';

class fetchInntsubCategoryList extends GetxController {
  List inntsubCategory = [];
  var inntsubsubCategory = [].obs;

  Future subcategoryList(id) async {
    final response = await http.post(Uri.parse('${base_url}subCategory_list'),
        body: {"categoryId": id.toString()});
    var decodedData = json.decode(response.body);
    List privacypolicy = decodedData['data'];
    if (response.statusCode == 200) {
      inntsubCategory.clear();

      inntsubCategory.add(privacypolicy);

      print("qwert$inntsubCategory");
      return inntsubCategory;

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load innt category list');
    }
  }

  Future subsubcategoryList(subid) async {
    inntsubsubCategory.clear();
    final response = await http.post(
        Uri.parse('${base_url}subSubcategory_list'),
        body: {"subcategoryId": subid.toString()});
    var decodedData = json.decode(response.body);
    List privacypolicy = decodedData['data'];
    if (response.statusCode == 200) {
      inntsubsubCategory.add(privacypolicy);

      print("qwert$inntsubsubCategory");
      return inntsubsubCategory;

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load innt category list');
    }
  }
}
