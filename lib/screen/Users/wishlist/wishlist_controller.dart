import 'package:get/get.dart';

import '../../../Api/wishlist.dart';

class wishlist extends GetxController {
  RxInt changeview = 0.obs;
  RxList mutipledeletelist = [].obs;
  final wishh = Get.put(wishlist_api());

  void change(val) {
    changeview.value = val;
    update();
  }

  void mutipledelete(val,index) {



    mutipledeletelist.add(val);


    // wishh.wishlistlist.elementAt(index)["productId"]["product_variation"].map((attribute) {
    //   Map<String, dynamic> newAttribute = Map.from(attribute);
    //
    //
    //
    //   // cartlist.selectedarr
    //   //     .add({
    //   //   "name":newAttribute ["attribute_name"].toString(),
    //   //   "value": newAttribute["attribute_values"][0].toString(),
    //   // });
    //
    //
    // }).toList();
    update();
  }

}
