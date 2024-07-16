import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api/getuserprofile.dart';
import '../../Api/updateprofile_api.dart';
import '../../Controller/button.dart';
import '../../Controller/controller.dart';
import '../../Controller/text2.dart';
import '../../main.dart';
import '../../ulits/constant.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  GetxControllers controller = Get.put(GetxControllers());
  final getprofile = Get.put(Getuserprofile_api());
  final updateprofile = Get.put(updateprofileapi());
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  bool passwordObscured = true;
  bool confirmPasswordObscured = true;
  late DateTime _selectedDate;
  String _displayDate = '';

  @override
  void initState() {
    // TODO: implement initState
    firstNameController.text = getprofile.profiledata[0][0]["first_name"] ?? "";
    lastNameController.text = getprofile.profiledata[0][0]["last_name"] ?? "";
    mobileController.text = getprofile.profiledata[0][0]["mobile_number"] ?? "";
    emailController.text = getprofile.profiledata[0][0]["email"] ?? "";
    dobController.text = getprofile.profiledata[0][0]["dob"] ?? "";
    super.initState();
  }

  var genderlist = ["male", 'female'];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: h / 60,
              ),
              GestureDetector(
                onTap: () {
                  controller.bottomshet()();
                },
                child: Obx(
                  () => controller.imagePath.isEmpty
                      ? Container(
                          width: w / 4,
                          height: h / 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            //color: Colors.red
                            // borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                "$image_url${getprofile.profiledata[0][0]["user_profile"]}",
                                fit: BoxFit.fill,
                              )

                              // CachedNetworkImage(
                              //   imageUrl: "http://103.104.74.215:3038/uploads/scaled_-6338922041981385194_120.jpg",
                              //   fit: BoxFit.fill,
                              //   placeholder: (context, url) => Image.asset("assets/images/personnew.png",scale: 12),
                              //   errorWidget: (context, url, error) => Icon(Icons.error),
                              // ),
                              ),
                        )
                      : Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage: FileImage(
                                  File(controller.imagePath.toString())))),
                ),
              ),
              SizedBox(
                height: h / 60,
              ),
              Text("Change profile picture", style: A_style_mid),
              SizedBox(
                height: h / 60,
              ),
              /*  TextFormField(
                // enabled: false,
readOnly: true,
                initialValue: getprofile.profiledata[0][0]["userName"] ?? "",
                style: TextStyle(
                    color: darkomdee.darkomde == true
                        ? Colors.white
                        : Colors.black),
                // controller: firstNameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    filled: true,
                    fillColor: darkomdee.darkomde == true
                        ? Colors.black
                        : Colors.white,
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
                    hintText: "Username",
                    labelText: "Username",
                    labelStyle: TextStyle(
                        color: darkomdee.darkomde == true
                            ? Colors.white
                            : Colors.black)),
              ),
              SizedBox(
                height: h / 60,
              ),*/
              TextFormField(
                style: TextStyle(
                    color: darkomdee.darkomde == true
                        ? Colors.white
                        : Colors.black),
                controller: firstNameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    filled: true,
                    fillColor: darkomdee.darkomde == true
                        ? Colors.black
                        : Colors.white,
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
                    hintText: "First Name",
                    labelText: "First Name",
                    labelStyle: TextStyle(
                        color: darkomdee.darkomde == true
                            ? Colors.white
                            : Colors.black)),
              ),
              SizedBox(
                height: h / 40,
              ),
              TextFormField(
                style: TextStyle(
                    color: darkomdee.darkomde == true
                        ? Colors.white
                        : Colors.black),
                controller: lastNameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    filled: true,
                    fillColor: darkomdee.darkomde == true
                        ? Colors.black
                        : Colors.white,
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
                    hintText: "Last Name",
                    labelText: "Last Name",
                    labelStyle: TextStyle(
                        color: darkomdee.darkomde == true
                            ? Colors.white
                            : Colors.black)),
              ),
              SizedBox(
                height: h / 40,
              ),
              TextFormField(
                style: TextStyle(
                    color: darkomdee.darkomde == true
                        ? Colors.white
                        : Colors.black),
                controller: mobileController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    filled: true,
                    fillColor: darkomdee.darkomde == true
                        ? Colors.black
                        : Colors.white,
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
                    hintText: "Mobile Number",
                    labelText: "Mobile Number",
                    labelStyle: TextStyle(
                        color: darkomdee.darkomde == true
                            ? Colors.white
                            : Colors.black)),
              ),
              SizedBox(
                height: h / 40,
              ),
              TextFormField(
                style: TextStyle(
                    color: darkomdee.darkomde == true
                        ? Colors.white
                        : Colors.black),
                controller: emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    filled: true,
                    fillColor: darkomdee.darkomde == true
                        ? Colors.black
                        : Colors.white,
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
                    hintText: "Email",
                    labelText: "Email",
                    labelStyle: TextStyle(
                        color: darkomdee.darkomde == true
                            ? Colors.white
                            : Colors.black)),
              ),
              SizedBox(
                height: h / 40,
              ),
              TextFormField(
                style: TextStyle(
                    color: darkomdee.darkomde == true
                        ? Colors.white
                        : Colors.black),
                onTap: () {
                  _showDatePicker();
                },
                readOnly: true,
                controller: dobController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    filled: true,
                    fillColor: darkomdee.darkomde == true
                        ? Colors.black
                        : Colors.white,
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
                    hintText: "Dob",
                    labelText: "Dob",
                    suffixIcon: Icon(Icons.calendar_month,
                        color: darkomdee.darkomde == true
                            ? Colors.white
                            : logocolo),
                    labelStyle: TextStyle(
                        color: darkomdee.darkomde == true
                            ? Colors.white
                            : Colors.black)),
              ),
              SizedBox(
                height: h / 40,
              ),
              Container(
                height: h / 18,
                width: w,
                padding: const EdgeInsets.only(left: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: darkomdee.darkomde == true
                            ? Colors.white
                            : Colors.black,
                        width: 1)),
                child: Obx(() => DropdownButton<String>(
                      iconEnabledColor: darkomdee.darkomde == true
                          ? Colors.white
                          : Colors.black,
                      dropdownColor: darkomdee.darkomde == true
                          ? Colors.black
                          : Colors.white,
                      underline: const SizedBox(),
                      hint: Text("Select gender",
                          style: TextStyle(
                              fontSize: 12,
                              color: darkomdee.darkomde == true
                                  ? Colors.white
                                  : Colors.grey)),
                      value: getprofile.gender.value,
                      style: TextStyle(
                          color: darkomdee.darkomde == true
                              ? Colors.white
                              : Colors.black),
                      isExpanded: true,
                      items: genderlist.map((item) {
                        return DropdownMenuItem(
                          value: item.toString(),
                          child: Text(item.toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: darkomdee.darkomde == true
                                      ? Colors.white
                                      : Colors.black)),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        getprofile.gender.value = newValue.toString();
                      },
                    )),
              ),
              SizedBox(
                height: h / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: h / 17,
                    width: w / 2.5,
                    child: ElevatedButton(
                        style: buttonPrimary,
                        onPressed: () {
                          // print("clicked");
                          updateprofile.updateprofile(
                              firstNameController.text.toString(),
                              lastNameController.text.toString(),
                              emailController.text.toString(),
                              mobileController.text.toString(),
                              controller.imagePath.value.toString(),
                              dobController.text.toString(),
                              getprofile.gender.toString());
                          //_showAlertDialog(context);
                        },
                        child: Text("Save change",
                            style: darkomdee.darkomde == true
                                ? const TextStyle(
                                    //letterSpacing: 2,
                                    color: Colors.white,
                                    fontFamily: "Amazon_med",
                                    fontSize: 18)
                                : A_style_text_inside_button)),
                  ),
                  SizedBox(
                    height: h / 17,
                    width: w / 2.5,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(400, 50),
                            backgroundColor: darkomdee.darkomde == true
                                ? Colors.white
                                : Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () {
                          Get.back();
                        },
                        child:
                            Text("Cancel", style: A_style_text_inside_button)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: const Text(
            "Sucessfully",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: logocolo),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: logocolo, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: logocolo, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _displayDate =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        dobController.text = _displayDate;
      });
    }
  }

  showMyDialog(BuildContext context) async {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Changes saved !',
            style: A_style_text_head2,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            SizedBox(
              height: h / 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() => updateprofile.isloading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GestureDetector(
                        onTap: () {
                          updateprofile.updateprofile(
                              firstNameController.text.toString(),
                              lastNameController.text.toString(),
                              emailController.text.toString(),
                              mobileController.text.toString(),
                              controller.imagePath.value.toString(),
                              dobController.text.toString(),
                              getprofile.gender.toString());
                        },
                        child: const Icon(
                          Icons.check_circle_outline,
                          color: logocolo,
                          size: 50,
                        ),
                      )),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: w / 5,
                    decoration: BoxDecoration(
                        color: const Color(0xff1455ac),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton(
                      style: flatButtonStyle,
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'Close',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Ember_Bold"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
