import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/screen/Users/Navgationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dayOftheDeals.dart';
import '../models/inntShop_list.dart';
import '../models/newArrivalProduct.dart';
import '../models/suggested_ProductList.dart';
import '../screen/Users/home.dart';
import '../ulits/constant.dart';
import '../ulits/utils.dart';
import 'addressList_api.dart';
import 'innt_categoryList_api.dart';

class Homepage_api extends GetxController {
  RxList<NewArrivalProduct> newarrivallist = <NewArrivalProduct>[].obs;
  RxList<NewArrivalProduct> topsaleiinntout = <NewArrivalProduct>[].obs;
  RxList<DayOftheDeals> dayOftheDeals_ProductList = <DayOftheDeals>[].obs;
  RxList<SuggestedProductList> suggested_ProductListList =
      <SuggestedProductList>[].obs;
  RxList trendingNowList = [].obs;
  RxList advertisementProduct_listList = [].obs;
  RxList advertisementProduct_listList1 = [].obs;
  RxList<inntShop_list> inntShop_listList = <inntShop_list>[].obs;
  RxList inntShop_detailsListlist = [].obs;
  RxList selectedwhishsize = [].obs;
  RxList inntShop_detailsprofilter = [].obs;
  RxList categorie = [].obs;
  RxList categoriee = [].obs;
  RxList inntprof = [].obs;
  RxList inntoutprof = [].obs;
  RxList homepageprofilter = [].obs;
  List ppptreding = [];

  var productWithHighestSalePrice1;
  var productWithLowestSalePrice1;
  RxBool loading = false.obs;

  var productWithHighestSalePrice2;
  var productWithLowestSalePrice2;

  var productWithHighestSalePrice3;
  var productWithLowestSalePrice3;

  var productWithHighestSalePrice4;
  var productWithLowestSalePrice4;

  size(ind, ele) {
    selectedwhishsize.value[ind] = ele;
    update();
  }

  final getInntCategory_api = Get.put(fetchInntCategoryList());
  final Addressapi = Get.put(Address_api());
  // RxString dropdownvalue="".obs;

  Future<RxList<NewArrivalProduct>?> newarrival() async {
    final response = await http.get(
      Uri.parse('${base_url}newArrival_Product_list'),
    );
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200) {
      newarrivallist.clear();
      newarrivallist.add(NewArrivalProduct.fromJson(decodedData));
      productWithHighestSalePrice2 = decodedData["data"]
          .reduce((a, b) => a["sale_price"]! > b["sale_price"]! ? a : b);

      // Find the product with the lowest sale price
      productWithLowestSalePrice2 = decodedData["data"]
          .reduce((a, b) => a["sale_price"]! < b["sale_price"]! ? a : b);

      return newarrivallist;
    } else {}
    return null;
  }

  Future<RxList<NewArrivalProduct>?> topsaleinnout() async {
    final response = await http.get(
      Uri.parse('${base_url}topSale_inntoutPorduct_list'),
    );
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200) {
      topsaleiinntout.clear();
      topsaleiinntout.add(NewArrivalProduct.fromJson(decodedData));
      return newarrivallist;
    } else {}
    return null;
  }

  Future<RxList<DayOftheDeals>?> dayOftheDeals_List() async {
    final response = await http.get(
      Uri.parse('${base_url}dayOftheDeals_ProductList'),
    );
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200) {
      dayOftheDeals_ProductList.clear();
      dayOftheDeals_ProductList.add(DayOftheDeals.fromJson(decodedData));
      productWithHighestSalePrice1 = decodedData["data"]
          .reduce((a, b) => a["sale_price"]! > b["sale_price"]! ? a : b);

      // Find the product with the lowest sale price
      productWithLowestSalePrice1 = decodedData["data"]
          .reduce((a, b) => a["sale_price"]! < b["sale_price"]! ? a : b);
      return dayOftheDeals_ProductList;
    } else {}
    return null;
  }

  Future<RxList<SuggestedProductList>?> suggested_ProductList_List() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    final response = await http.post(
        Uri.parse('${base_url}suggested_ProductList'),
        body: {"userId": userid.toString()});
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200) {
      suggested_ProductListList.clear();
      suggested_ProductListList.add(SuggestedProductList.fromJson(decodedData));
      productWithHighestSalePrice3 = decodedData["data"]
          .reduce((a, b) => a["sale_price"]! > b["sale_price"]! ? a : b);

      // Find the product with the lowest sale price
      productWithLowestSalePrice3 = decodedData["data"]
          .reduce((a, b) => a["sale_price"]! < b["sale_price"]! ? a : b);
      return suggested_ProductListList;
    } else {}
    return null;
  }

  Future trendingNow_List() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    final response = await http.get(
      Uri.parse('${base_url}trendingNow'),
    );
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200) {
      trendingNowList.clear();
      trendingNowList.add(decodedData);
      ppptreding.clear();
      for (int i = 0; i < trendingNowList[0]["data"].length; i++) {
        ppptreding
            .add("${trendingNowList[0]["data"][i]['productId']}".toString());
      }
      productWithHighestSalePrice3 = decodedData["data"]
          .reduce((a, b) => a["sale_price"]! > b["sale_price"]! ? a : b);

      // Find the product with the lowest sale price
      productWithLowestSalePrice3 = decodedData["data"]
          .reduce((a, b) => a["sale_price"]! < b["sale_price"]! ? a : b);

      return trendingNowList;
    } else {}
  }

  Future advertisementProduct_list_List() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");

    final response = await http.post(
        Uri.parse('${base_url}advertisementProduct_list'),
        body: {"status": "1"});
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200) {
      advertisementProduct_listList.clear();
      advertisementProduct_listList.add(decodedData);
      // print(
      //     "advertisementProduct_listList${advertisementProduct_listList[0]["data"][0]["image1"]}");
      return advertisementProduct_listList;
    } else {}
  }

  Future advertisementProduct_list_List1() async {
    final response = await http.post(
        Uri.parse('${base_url}advertisementProduct_list'),
        body: {"status": "2"});
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200) {
      advertisementProduct_listList1.clear();
      advertisementProduct_listList1.add(decodedData);

      return advertisementProduct_listList1;
    } else {}
  }

  var shopdistancemax;
  var shopdistancemin;

  Future<RxList<inntShop_list>?> inntShop_list_List() async {
    await Addressapi.getAddressListApi();
    try {
      final response =
          await http.post(Uri.parse('${base_url}inntShop_list'), body: {
        "lat": currentLocation.latitude.toString(),
        "lon": currentLocation.longitude.toString()
      });
      var decodedData = json.decode(response.body);

      if (response.statusCode == 200) {
        inntShop_listList.clear();
        inntShop_listList.add(inntShop_list.fromJson(decodedData));
        shopdistancemax = decodedData["data"].reduce((a, b) =>
            double.parse(a["distances"]!) > double.parse(b["distances"]!)
                ? a
                : b);

        // Find the product with the lowest sale price
        shopdistancemin = decodedData["data"].reduce((a, b) =>
            double.parse(a["distances"]!) < double.parse(b["distances"]!)
                ? a
                : b);
        print(" max ${shopdistancemax} ");

        print("min ${shopdistancemin}");
        return inntShop_listList;
      } else {
        print("else error inntShop_list_List $decodedData");
      }
    } catch (e) {
      print("try error inntShop_list_List $e");
    }
    return null;
  }

  Future inntShop_details_List(shopid) async {
    try {
      final response = await http.post(Uri.parse('${base_url}inntShop_details'),
          body: {"shopId": shopid.toString()});

      var decodedData = json.decode(response.body);

      inntShop_detailsListlist.clear();
      if (response.statusCode == 200 &&
          decodedData["result"].toString() == "true".toString()) {
        // print("lklkk $decodedData");
        inntShop_detailsListlist.add(decodedData);
        categorie.clear();
        categorie.add(
            {"cate_name": "All categories", "cate_value": "All categories"});
        for (var element in getInntCategory_api.inntCategory) {
          categorie.add({
            "cate_name": element.categoryEnglishName.toString(),
            "cate_value": element.sId.toString()
          });
        }

        productWithHighestSalePrice1 = decodedData["data"]["productlist"]
            .reduce((a, b) => a["sale_price"]! > b["sale_price"]! ? a : b);

        // Find the product with the lowest sale price
        productWithLowestSalePrice1 = decodedData["data"]["productlist"]
            .reduce((a, b) => a["sale_price"]! < b["sale_price"]! ? a : b);
        return inntShop_detailsListlist;
      } else {
        print("ggg $decodedData");
      }
    } catch (e) {
      print("hhgfgh3344 $e");
    }
  }

  Future inntShop_details_prodfilter(shopid, cat) async {
    inntShop_detailsprofilter.clear();
    final response = await http.post(
        Uri.parse('${base_url}inntCategoryProduct_list'),
        body: {"shopId": shopid.toString(), "categoryId": cat.toString()});
    var decodedData = json.decode(response.body);
    print(decodedData);
    if (response.statusCode == 200 && decodedData["result"] == "true") {
      inntShop_detailsprofilter.add(decodedData);
      return inntShop_detailsprofilter;
    } else {}
  }

  Future innt_prodfilter(key) async {
    inntprof.clear();
    loading.value = true;
    final response =
        await http.post(Uri.parse('${base_url}searchProduct'), body: {
      "key": key.toString(),
    });
    var decodedData = json.decode(response.body);
    print(decodedData);
    if (response.statusCode == 200 && decodedData["result"] == "true") {
      inntprof.add(decodedData);

      loading.value = false;
      return inntprof;
    } else {
      loading.value = false;
    }
  }

  Future inntout_prodfilter(key) async {
    inntoutprof.clear();
    loading.value = true;
    final response =
        await http.post(Uri.parse('${base_url}searchInntoutProduct'), body: {
      "key": key.toString(),
    });
    var decodedData = json.decode(response.body);
    print(decodedData);
    if (response.statusCode == 200 && decodedData["result"] == "true") {
      inntoutprof.add(decodedData);

      loading.value = false;
      return inntoutprof;
    } else {
      loading.value = false;
    }
  }

  Future homepage_prodfilter(
      {categoryId, price1, price, discount, rating, status}) async {
    homepageprofilter.clear();

    final response =
        await http.post(Uri.parse('${base_url}dayOfthedealsProducts_filter'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              if (categoryId != "0") "categoryId": categoryId.toString(),
              "price": price,
              if (rating != null) "rating": rating,
              if (discount != null) "discount": discount,
              "price1": price1,
              "status": status
            }));
    var decodedData = json.decode(response.body);
    print(decodedData);
    if (response.statusCode == 200 && decodedData["result"] == "true") {
      homepageprofilter.add(decodedData);

      return homepageprofilter;
    } else {
      homepageprofilter.add(decodedData);
    }
  }

  Future homepage_prodfilter1({
    categoryId,
    price1,
    price,
    discount,
    rating,
  }) async {
    homepageprofilter.clear();

    final response =
        await http.post(Uri.parse('${base_url}tradingNowfilterproducts'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              if (categoryId != "0") "categoryId": categoryId.toString(),
              "price": price,
              if (rating != null) "rating": rating,
              if (discount != null) "discount": discount,
              "price1": price1,
              "productIds": ppptreding
            }));
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200 && decodedData["result"] == "true") {
      homepageprofilter.add(decodedData);

      return homepageprofilter;
    } else {
      homepageprofilter.add(decodedData);
    }
  }

  RxList todayofferlist = [].obs;
  Future dayoffer() async {
    final response = await http.get(
      Uri.parse('${base_url}inntoutToday_offerProduct_list'),
    );
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200) {
      todayofferlist.clear();
      todayofferlist.add(decodedData);

      return todayofferlist;
    } else {}
  }

  RxList sellerdeatils_prodfilterlist = [].obs;
  Future sellerdeatils_prodfilter({
    shopid,
    price1,
    price,
    discount,
    rating,
  }) async {
    sellerdeatils_prodfilterlist.clear();

    final response = await http.post(Uri.parse('${base_url}filterShopProduct'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          // if(categoryId !="0") "categoryId": categoryId.toString(),
          "price": price,
          if (rating != null) "rating": rating,
          if (discount != null) "discount": discount,
          "price1": price1,
          "shopId": shopid
        }));
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200 && decodedData["result"] == "true") {
      sellerdeatils_prodfilterlist.add(decodedData);

      return sellerdeatils_prodfilterlist;
    } else {
      sellerdeatils_prodfilterlist.add(decodedData);
    }
  }

  RxList allsellerfilterlist = [].obs;
  Future allsellerfilter({rating, distances2, distances1}) async {
    allsellerfilterlist.clear();

    print(
        "ggddd ${currentLocation.latitude}, ${currentLocation.longitude} , $rating,$distances1,$distances2");
    final response = await http.post(Uri.parse('${base_url}filterShop'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "distances1": distances1.toString(),
          "distances2": distances2.toString(),
          "currentlat": currentLocation.latitude.toString(),
          "currentlon": currentLocation.longitude.toString(),
          "rating": rating.toString()
        }));
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200 && decodedData["result"] == "true") {
      print("kkkkfilterShop ${decodedData}");
      allsellerfilterlist.add(decodedData);
      print("llkdkd $allsellerfilterlist");
      return allsellerfilterlist;
    } else {
      allsellerfilterlist.add(decodedData);
    }
  }

  Future shopReportapi({shopId, title, message, status}) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("user_id");
    //currentlat,currentlon ,rating,distances1,distances2"
    final response = await http.post(Uri.parse('${base_url}addReportOf_shop'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "userId": userid.toString(),
          "shopId": shopId.toString(),
          "title": title.toString(),
          "message": message.toString(),
          "status": status.toString()
        }));
    var decodedData = json.decode(response.body);

    if (response.statusCode == 200 && decodedData["result"] == "true") {
      Utils().sendMassage(decodedData['message'].toString());
      currentTab = 0;
      Get.offAll(DashBoardScreen());
    } else {
      Utils().sendMassage(decodedData['message'].toString());
    }
  }
}
