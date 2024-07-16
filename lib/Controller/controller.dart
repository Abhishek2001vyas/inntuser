import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GetxControllers extends GetxController {
  RxString imagePath = ''.obs;

  bottomshet() {
    Get.bottomSheet(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40))),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text(
                  'Take Image From',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                ),
                title: const Text('Camera',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500)),
                onTap: () {
                  cam();
                  Get.back();
                  // pickImage(ImageSource!.camera,);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.image,
                  // color: colors.primary,
                ),
                title: const Text('Gallary',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black)),
                onTap: () {
                  gall();
                  Get.back();
                  // pickImage(ImageSource!.gallery);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.cancel_outlined,
                ),
                title: const Text('Cancel',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black)),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        ));
  }

  Future cam() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80, );

    if (image != null) {
      imagePath.value = image.path.toString();
      update();
    }
  }

  Future gall() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      imagePath.value = image.path.toString();
      update();
    }
  }

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path.toString();
    }
  }
}
