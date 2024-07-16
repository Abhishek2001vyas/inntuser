import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/privacy_policy_api.dart';
import '../../Controller/controller.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  GetxControllers controller = Get.put(GetxControllers());
  final getprivacyPolicy = Get.put(fetchPrivacyPolicy());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true, title: const Text("Privacy Policy")),
      body: FutureBuilder(
          future: getprivacyPolicy.privacy_Policy(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: logocolo,
              ));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount:
                    getprivacyPolicy.privacyPolicyList.elementAt(0).length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Html(
                          data:
                          '${ getprivacyPolicy.privacyPolicyList[0][index]["title"]}',
                          style: {
                            "h1": Style(
                              border: const Border(
                                  bottom: BorderSide(color: Colors.grey)),
                            ),
                          }),
                      SizedBox(
                        height: h / 50,
                      ),
                      Html(
                          data:
                          "${getprivacyPolicy.privacyPolicyList[0][index]["text"]}",
                          style: {
                            "h1": Style(
                              border: const Border(
                                  bottom: BorderSide(color: Colors.grey)),
                            ),
                          }),

                    ],
                  );
                },
              );
            }
          }),
    );
  }
}
