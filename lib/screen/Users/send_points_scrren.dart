import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../Api/loyaltypoints.dart';
import '../../ulits/constant.dart';

class SendPointsScrren extends StatefulWidget {
  const SendPointsScrren({super.key});

  @override
  State<SendPointsScrren> createState() => _SendPointsScrrenState();
}

class _SendPointsScrrenState extends State<SendPointsScrren> {
  final loyatly = Get.put(loyaltypointsapi());

  final formKey = GlobalKey<FormState>();
  TextEditingController mobile = TextEditingController();
  TextEditingController points = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // forceMaterialTransparency: true,
        // automaticallyImplyLeading: false,
        backgroundColor: logocolo,
        title: Text(
          AppLocalizations.of(context)!.sendpoints,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "Ember"),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h / 45,
                ),
                const Text(
                  textAlign: TextAlign.start,
                  "How many points do you want to send?",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: "Hey"),
                ),
                SizedBox(
                  height: h / 90,
                ),
                TextFormField(
                  controller: points,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please entre points";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black)),
                      hintText: 'Enter number of points',
                      hintStyle: const TextStyle(color: Colors.grey)),
                ),
                SizedBox(
                  height: h / 45,
                ),
                const Text(
                  textAlign: TextAlign.start,
                  "Send to (must be friends)",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: "Hey"),
                ),
                SizedBox(
                  height: h / 90,
                ),
                TextFormField(
                  controller: mobile,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please entre friends email or phone nmber";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black)),
                      hintText: 'Enter email or phone number',
                      hintStyle: const TextStyle(color: Colors.grey)),
                ),
                SizedBox(
                  height: h / 5,
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      loyatly.sendloyatlypoints(
                          points.text.toString(), mobile.text.toString());
                    }
                  },
                  child: Container(
                    width: w,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      color: logocolo,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: const Center(
                      child: Text(
                        "Send",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            fontFamily: "Hey"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
