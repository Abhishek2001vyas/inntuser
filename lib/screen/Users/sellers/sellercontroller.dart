import 'package:get/get.dart';

class Seller extends GetxController {
  RxInt changeview = 0.obs;

  void change(val) {
    changeview.value = val;
    update();
  }
}
