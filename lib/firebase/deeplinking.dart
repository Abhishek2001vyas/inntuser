import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/credential/Login/login.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart%20';

import '../screen/Common/splash.dart';
import '../screen/Users/productdeatils.dart';
import '../screen/Users/sellers/sellerdeatils.dart';

class deepp {
  void deepppfunction() {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      print("deep linking ${dynamicLinkData.link}");
      final deepLink = dynamicLinkData.link.queryParametersAll.entries ?? '';
      print("kkkkkff ${deepLink}");
      handleDeepLink(dynamicLinkData);
    }).onError((error) {
      // Handle errors
      print(" deeppp error $error");
    });
  }

  void deeppfunction() {
    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) {
        // Set up the `onLink` event listener next as it may be received here
        print("kkkkkff ${pendingDynamicLinkData}");
        if (pendingDynamicLinkData != null) {
          print("deep linking1 ${pendingDynamicLinkData.link}");
          handleDeepLink(pendingDynamicLinkData);
        }
      },
    );
  }

  //https://inntuser.page.link/productdeatils?productId=$productId&shopId=$shopId
  Future<String> generateLink(url) async {
    try {
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://inntuser.page.link',
        link: Uri.parse("$url"),
        androidParameters: AndroidParameters(
          packageName: 'com.example.inntuser',
          minimumVersion: 0,
        ),
        iosParameters: IOSParameters(
          bundleId: "com.example.inntuser",
          minimumVersion: '0',
        ),
      );

      final ShortDynamicLink shortDynamicLink =
          await FirebaseDynamicLinks.instance.buildShortLink(
        parameters,
        shortLinkType: ShortDynamicLinkType.unguessable,
      );
      final Uri shortUrl = shortDynamicLink.shortUrl;

      print("Created link: ${shortUrl.toString()}");
      Share.shareUri(shortUrl);

      return shortUrl.toString();
    } catch (e) {
      print("Error creating dynamic link: $e");
      return "null";
    }
  }

  void handleDeepLink(PendingDynamicLinkData dynamicLinkDataa) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    //var choosecount = sharedPreferences.getString("choosecount");
    var faceelock = sharedPreferences.getBool("facelock");
    if (faceelock == true) {
      await Splash.globalKey.currentState?.authenticateUser();
      if (userId == null) {
        Get.to(Splash());
      } else if (dynamicLinkDataa.link.path.toString() == '/productdeatils') {
        Get.to(Product_deatils(
          sourceName: "0",
          shopid: dynamicLinkDataa.link.queryParameters["shopId"],
          subsubcateid: dynamicLinkDataa.link.queryParameters["productId"],
        ));
      } else if (dynamicLinkDataa.link.path.toString() == '/SellerDetails') {
        Get.to(SellerDetails(
          sourceName: "0",
          shopid: dynamicLinkDataa.link.queryParametersAll["shopId"]!.first,
          shopanme: dynamicLinkDataa.link.queryParametersAll["shopanme"]!.first,
        ));
      } else if (dynamicLinkDataa.link.path.toString() == '/referandearn') {
        Get.to(Login_email(
            refercode:
                dynamicLinkDataa.link.queryParametersAll["referid"]!.first));
      }
    } else {
      if (userId == null) {
        Get.to(Splash());
      } else if (dynamicLinkDataa.link.path.toString() == '/productdeatils') {
        Get.to(Product_deatils(
          sourceName: "0",
          shopid: dynamicLinkDataa.link.queryParametersAll["shopId"]!.first,
          subsubcateid:
              dynamicLinkDataa.link.queryParametersAll["productId"]!.first,
        ));
      } else if (dynamicLinkDataa.link.path.toString() == '/referandearn') {
        Get.to(Login_email(
            refercode:
                dynamicLinkDataa.link.queryParametersAll["referid"]!.first));
      } else if (dynamicLinkDataa.link.path.toString() == '/SellerDetails') {
        Get.to(SellerDetails(
          sourceName: "0",
          shopid: dynamicLinkDataa.link.queryParametersAll["shopId"]!.first,
          shopanme: dynamicLinkDataa.link.queryParametersAll["shopanme"]!.first,
        ));
      }
    }
  }
}
