import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../Api/Signup_api.dart';
import '../../../Controller/button.dart';
import '../../../Controller/controller.dart';
import '../../../Controller/text2.dart';
import '../../../firebase/fcm.dart';
import '../../../ulits/custom widget.dart';
import '../../../ulits/utils.dart';

class Details extends StatefulWidget {
  final referalcode;
  const Details({super.key, this.referalcode});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final TextEditingController dateInput = TextEditingController();
  bool isDateSelected = false;
  final signupapi = Get.put(Signupapi());
  final bool _isVerifyButtonEnabled = false;
  bool isloading = false;
  RegExp validemail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  var ll = 8;
  GetxControllers controller = Get.put(GetxControllers());
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late TextEditingController referralController =
      TextEditingController(text: widget.referalcode);

  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool passwordObscured = true;
  bool passwordObscured1 = true;
  String? valueChoose;
  List<String> listitem = ["Male", "Female", "Other"];
  final formKey = GlobalKey<FormState>();

  var contrycode = "226";

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Center(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          controller.getImage();
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: controller.imagePath.isNotEmpty
                                  ? CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey.shade300,
                                      backgroundImage: FileImage(File(
                                          controller.imagePath.toString())))
                                  : CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey.shade300,
                                      backgroundImage: const NetworkImage(
                                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                          scale: 10),
                                    ),
                            ),
                            SizedBox(
                              height: h / 100,
                            ),
                            Text("Upload a profile picture", style: A_style_mid)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h / 40,
                    ),
                    const Text(
                      "First name",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Ember_Medium",
                          fontWeight: FontWeight.w500),
                    ),
                    textformfieldsignup(
                      fullNameController: fullNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter first name";
                        } else {
                          return null;
                        }
                      },
                      hindtext: "Entre your first name",
                    ),
                    SizedBox(
                      height: h / 80,
                    ),
                    const Text(
                      "Last name",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Ember_Medium",
                          fontWeight: FontWeight.w500),
                    ),
                    textformfieldsignup(
                      fullNameController: nickNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter last name";
                        } else {
                          return null;
                        }
                      },
                      hindtext: "Entre your last name",
                    ),
                    SizedBox(
                      height: h / 80,
                    ),
                    const Text(
                      "Mobile Number",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Ember_Medium",
                          fontWeight: FontWeight.w500),
                    ),
                    IntlPhoneField(
                      cursorColor: Colors.black,
                      dropdownDecoration:
                          const BoxDecoration(shape: BoxShape.circle),
                      initialCountryCode: "BF",
                      onCountryChanged: (value) {
                        setState(() {
                          ll = value.maxLength;
                          contrycode = value.dialCode;
                        });
                      },
                      controller: codeController,
                      validator: (value) {
                        if (value == null) {
                          return "please mobile";
                        }
                        return null;
                      },
                      pickerDialogStyle: PickerDialogStyle(
                        backgroundColor: const Color(0xffffffff),
                      ),
                      flagsButtonPadding: const EdgeInsets.all(5),
                      dropdownIconPosition: IconPosition.trailing,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(12),
                          filled: true,
                          counterText: "",
                          hintText: 'Mobile Number',
                          hintStyle: A_style_mid,
                          //labelStyle: TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black,
                                  //Color(0xff1455ac),
                                  width: 1),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Ember_Medium",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(
                          //letterSpacing: 1.5,
                          //color: Colors.white,
                          color: Colors.black,
                          fontFamily: "Amazon_med",
                          fontSize: 14),
                      controller: emailController,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)) {
                            return null;
                          } else {
                            return "Please entre email correct";
                          }
                          // if (value != validemail)
                          // return "Please enter correct email";
                        } else {
                          return null;
                        }
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
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
                        hintText: "Entre your email",
                        hintStyle: A_style_mid,
                      ),
                    ),
                    SizedBox(
                      height: h / 80,
                    ),
                    const Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Ember_Medium",
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value!.length < 6) {
                          return "Please enter password (at least 6 characters)";
                        } else if (value.isEmpty) {
                          return "please entrer password";
                        } else {
                          return null;
                        }
                      },
                      obscureText: passwordObscured,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordObscured = !passwordObscured;
                                });
                              },
                              icon: Icon(
                                passwordObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              )),
                          hintText: "Enter your password"),
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: h / 80,
                    ),
                    const Text(
                      "Confirm password",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Ember_Medium",
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 6) {
                          return "Please confirm password (at least 6 characters)";
                        } else if (value.isEmpty) {
                          return "please entre confirm password";
                        } else if (value != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      cursorColor: Colors.black,
                      obscureText: passwordObscured1,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordObscured1 = !passwordObscured1;
                                });
                              },
                              icon: Icon(
                                passwordObscured1
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              )),
                          hintText: "Confirm password"),
                      controller: confirmpasswordController,
                    ),
                    SizedBox(
                      height: h / 80,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Referral code?",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Ember_Medium",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Add referral code"),
                      controller: referralController,
                    ),
                    SizedBox(
                      height: h / 40,
                    ),
                    Obx(() => signupapi.isloading.value == true
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.blue),
                          )
                        : ElevatedButton(
                            style: buttonPrimary,
                            onPressed: () {
                              if (codeController.text.length != ll) {
                                Utils().sendMassage(
                                    ' Please entre mobile no upto $ll');
                              }
                              // else if(controller.imagePath.isEmpty){ Utils().alertbox(' Please upload image'); }
                              else if (formKey.currentState!.validate()) {
                                signupapi.signupApi(
                                    fullNameController.text.toString(),
                                    nickNameController.text.toString(),
                                    emailController.text.toString(),
                                    codeController.text.toString(),
                                    passwordController.text.toString(),
                                    confirmpasswordController.text.toString(),
                                    referralController.text.toString(),
                                    fCMToken.toString(),
                                    controller.imagePath.value.toString(),
                                    contrycode.toString());
                              } else {
                                return;
                              }
                            },
                            child: Text("Continue",
                                style: A_style_text_inside_button))),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void congr() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            content: SizedBox(
                height: 380,
                width: 280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Image.asset(
                            "assets/images/Screenshot__30_-removebg-preview.png",
                            scale: 1.7)),
                    const SizedBox(height: 15),
                    const Center(
                      child: Text(
                        "Congratulations",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Center(
                      child: Text(
                        "Your Account is ready to use. You will be \nredirected to the Home Page in a Few \nSeconds.",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  void _selectINDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.highContrastLight(
                primary: Colors.redAccent.shade700),
            dialogBackgroundColor: Colors.white,
            textTheme: TextTheme(bodyLarge: A_style_mid),
            //dialogTheme: DialogTheme(backgroundColor: Colors.black)
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        dateInput.text = formattedDate;
      });
    }
  }
}
