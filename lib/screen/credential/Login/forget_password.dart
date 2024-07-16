import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Api/forgotapi.dart';
import '../../../Controller/button.dart';
import '../../../Controller/text2.dart';

String? off = "3";

class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
  bool isloading = false;
  final fogotapi = Get.put(forgotforotp_api());
  final emailControllerrr = TextEditingController();
  final valid = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Forgot password", style: TextStyle(color: Colors.black)),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Form(
            key: valid,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Email or phone",
                    style: A_style_mid,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please email Or phone number";
                        } else {
                          return null;
                        }
                      },
                      controller: emailControllerrr,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(12),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        // hintText: "Example@gmail.com",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                        "We'll send a verification code to this email or phone number if it matches an existing inntaccount",
                        style: TextStyle(
                            //letterSpacing: 1.5,
                            //color: Colors.white,
                            color: Colors.grey.shade700,
                            fontFamily: "Amazon_med",
                            fontStyle: FontStyle.italic,
                            fontSize: 14)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Obx(
                        () => fogotapi.isloading == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.blue),
                              )
                            : ElevatedButton(
                                style: buttonPrimary,
                                onPressed: () async {
                                  if (valid.currentState!.validate()) {
                                    await fogotapi.forgot(
                                        emailControllerrr.text.toString());
                                  }
                                  // setState(() {
                                  //   isloading = true;
                                  // });
                                  // Future.delayed(Duration(seconds: 2), () {
                                  //   setState(() {
                                  //     isloading = false;
                                  //     //Get.to(Verify_Login());
                                  //     Get.to(forgototpp());
                                  //   });
                                  // });
                                },
                                child:
                                    // isloading
                                    //     ? CircularProgressIndicator(color: Colors.white)
                                    //     :
                                    Text("Continue",
                                        style: A_style_text_inside_button)),
                      )),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
