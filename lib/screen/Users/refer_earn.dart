import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inntuser/firebase/deeplinking.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/getuserprofile.dart';
import '../../ulits/utils.dart';
import 'Referral_history.dart';

class ReferEarn extends StatefulWidget {
  const ReferEarn({super.key});

  @override
  State<ReferEarn> createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  final getprofile = Get.put(Getuserprofile_api());
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Refer & Earn",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue.shade100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: h / 50,
                  ),
                  const Text(
                    "Refer a friend a friend a earn 5% of their first order.",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Roboto_thin",
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                  Image.asset(
                      "assets/images/21Screenshot-removebg-preview.png"),
                  SizedBox(
                    height: h / 50,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: h / 50,
            ),
            const Text(
              "YOUR REFERRAL CODE",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Roboto_thin",
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(
              height: h / 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DottedBorder(
                    child: Container(
                  height: h / 20,
                  width: w / 4.5,
                  color: Colors.blue.shade100,
                  child: Center(
                    child: Text(
                      "${getprofile.profiledata[0][0]["user_referral_code"]}",
                      style: TextStyle(
                          fontFamily: "Roboto_thin",
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
                // IconButton(
                //     onPressed: () {
                //
                //     },
                //     icon: const Icon(Icons.copy))
              ],
            ),
            SizedBox(
              height: h / 80,
            ),
            TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                      text:
                          "${getprofile.profiledata[0][0]["user_referral_code"]}"));
                  Utils().sendMassage('Copy to Clipboard');
                },
                child: Text(
                  "Tap to copy",
                  style: TextStyle(color: Colors.blue),
                )),
            SizedBox(
              height: h / 40,
            ),
            SizedBox(
              height: h / 10,
              width: w,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    deepp().generateLink(
                        "https://inntuser.page.link/referandearn?referid=${getprofile.profiledata[0][0]["user_referral_code"]}");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: logocolo,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Refer a friend now",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h / 30,
            ),
            TextButton(
              onPressed: () {
                Get.to(const Referralhistory());
              },
              child: const Text(
                "Referral history",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blue,
                  fontFamily: "Roboto_thin",
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
