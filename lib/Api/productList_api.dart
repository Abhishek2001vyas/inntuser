import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../models/productListModel.dart';
import '../ulits/constant.dart';

class fetchProductList extends GetxController {
  List<ProductListModel> productCategoryList = [];

  Future<List<ProductListModel>> productList(String categoryId) async {
    final response = await http.post(
      Uri.parse('${base_url}categoryBase_productList'),
      body: {
        'categoryId': categoryId.toString()
      }, // Add categoryId to the request body
    );
    var decodedData = json.decode(response.body);
    List proList = decodedData['data'];
    print("jjjjx$decodedData");
    productCategoryList.clear();
    if (response.statusCode == 200) {
      for (var i in proList) {
        productCategoryList.add(ProductListModel.fromJson(i));
      }
      print(productCategoryList.toString());
      return productCategoryList;
    } else {
      throw Exception('Failed to load innt product list');
    }
  }
}
