import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/MyQR.dart';
import 'package:inntuser/screen/Users/Navgationbar.dart';
import 'package:inntuser/screen/Users/profile_information.dart';

import '../../Api/getuserprofile.dart';
import '../../Controller/button.dart';
import '../../Controller/controller.dart';
import '../../Controller/text2.dart';
import '../../main.dart';
import '../../ulits/constant.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  GetxControllers controller = Get.put(GetxControllers());
  final getprofile = Get.put(Getuserprofile_api());
  TextEditingController userNameController =
      TextEditingController(text: "kklhh");
  TextEditingController firstNameController =
      TextEditingController(text: "kkl");
  TextEditingController lastNameController = TextEditingController(text: "");
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool passwordObscured = true;
  bool confirmPasswordObscured = true;
  final bool _isLoading = false;
  final bool _isVerifyEnabled = false;
  var gender ;
  var genderlist=[
    "male",
    'female'
  ];
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:   darkomdee.darkomde==true?
      Colors.black:Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            currentTab=4;
            Get.offAll(const DashBoardScreen());
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Row(
          children: [
            const Spacer(),
            const Text(
              "Profile information",
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Get.to(() => const MyQr());
                },
                icon: const Icon(
                  Icons.qr_code_2_outlined,
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: FutureBuilder(
          future: getprofile.userprofile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            } else {
              return getprofile.profiledata.isNotEmpty
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: h / 60,
                          ),
                          Container(
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
                                //   imageUrl: "$image_url${getprofile.profiledata[0][0]["user_profile"]}",
                                //   fit: BoxFit.fill,
                                //   placeholder: (context, url) => Image.asset("assets/images/th-_1_.jpg",scale: 2),
                                //   errorWidget: (context, url, error) => Icon(Icons.error),
                                // ),
                                ),
                          ),
                          SizedBox(
                            height: h / 60,
                          ),
                          Text("profile picture", style: A_style_mid),
                          SizedBox(
                            height: h / 60,
                          ),
                          TextFormField(
                            // enabled: false,

                            initialValue: getprofile.profiledata[0][0]
                            ["userName"] ??
                                "",
                            readOnly: true,style: TextStyle(color:   darkomdee.darkomde==true?
                          Colors.white:Colors.black),
                            // controller: firstNameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor:   darkomdee.darkomde==true?
                                Colors.black:Colors.white,
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
                                hintText: "Username",
                                labelText: "Username",

                                labelStyle:
                                 TextStyle(color:   darkomdee.darkomde==true?
                                Colors.white:Colors.black)),
                          ),
                          SizedBox(
                            height: h / 40,
                          ),
                          TextFormField(
                            // enabled: false,

                            initialValue: getprofile.profiledata[0][0]
                                    ["first_name"] ??
                                "",
                            readOnly: true,style: TextStyle(color:   darkomdee.darkomde==true?
                          Colors.white:Colors.black),
                            // controller: firstNameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor: darkomdee.darkomde==true?
                                Colors.black:Colors.white,
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
                                hintText: "First Name",
                                labelText: "First Name",
                                labelStyle:
                                     TextStyle(color:   darkomdee.darkomde==true?
                                    Colors.white:Colors.black)),
                          ),
                          SizedBox(
                            height: h / 40,
                          ),
                          TextFormField(
                            initialValue:
                                getprofile.profiledata[0][0]["last_name"] ?? "",
                            readOnly: true,style: TextStyle(color:   darkomdee.darkomde==true?
                          Colors.white:Colors.black),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor: darkomdee.darkomde==true?
                                Colors.black:Colors.white,
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
                                hintText: "Last Name",
                                labelText: "Last Name",
                                labelStyle:
                                     TextStyle(color:  darkomdee.darkomde==true?
                                    Colors.white: Colors.black)),
                          ),
                          SizedBox(
                            height: h / 40,
                          ),
                          TextFormField(
                            readOnly: true,style: TextStyle(color:   darkomdee.darkomde==true?
                          Colors.white:Colors.black),
                            initialValue: getprofile.profiledata[0][0]
                                    ["mobile_number"] ??
                                "",
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor: darkomdee.darkomde==true?
                                Colors.black:Colors.white,
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
                                hintText: "Mobile Number",
                                labelText: "Mobile Number",
                                labelStyle:
                                     TextStyle(color:   darkomdee.darkomde==true?
                                    Colors.white:Colors.black)),
                          ),
                          SizedBox(
                            height: h / 40,
                          ),
                          TextFormField(
                            readOnly: true,style: TextStyle(color:   darkomdee.darkomde==true?
                          Colors.white:Colors.black),
                            initialValue:
                                getprofile.profiledata[0][0]["email"] ?? "",
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor: darkomdee.darkomde==true?
                                Colors.black:Colors.white,
                                suffixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.grey.shade400,
                                ),
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
                                hintText: "Email",
                                labelText: "Email",
                                labelStyle:
                                     TextStyle(color:  darkomdee.darkomde==true?
                                    Colors.white: Colors.black)),
                          ),
                          SizedBox(
                            height: h / 40,
                          ),
                          TextFormField(
                            readOnly: true,style: TextStyle(color:   darkomdee.darkomde==true?
                          Colors.white:Colors.black),
                            initialValue:
                                getprofile.profiledata[0][0]["dob"] ?? "",
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor: darkomdee.darkomde==true?
                                Colors.black:Colors.white,
                                suffixIcon: Icon(
                                  Icons.calendar_month,
                                  color: Colors.grey.shade400,
                                ),
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
                                hintText: "DOB",
                                labelText: "DOB",
                                labelStyle:
                                     TextStyle(color:   darkomdee.darkomde==true?
                                    Colors.white:Colors.black)),
                          ),
                          SizedBox(
                            height: h / 40,
                          ),
                          TextFormField(
                            readOnly: true,style: TextStyle(color:   darkomdee.darkomde==true?
                          Colors.white:Colors.black),
                            initialValue:
                            getprofile.profiledata[0][0]["gender"] ?? "",
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor: darkomdee.darkomde==true?
                                Colors.black:Colors.white,
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.grey.shade400,
                                ),
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
                                hintText: "Select gender",
                                labelText: "gender",
                                labelStyle:
                                TextStyle(color:   darkomdee.darkomde==true?
                                Colors.white:Colors.black)),
                          ),
                         /* Container(
                            height: h / 18,width: w,
                            padding: const EdgeInsets.only(
                                left: 4),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                                border: Border.all(
                                    color:   darkomdee.darkomde==true?
                                    Colors.white:Colors.black,
                                    width: 1)),
                            child:

                            DropdownButton<String>(
                              iconEnabledColor:  darkomdee.darkomde==true?
                              Colors.white:Colors.black ,
                              dropdownColor: darkomdee.darkomde==true?
                              Colors.black:Colors.white,
                              underline: const SizedBox(),hint: Text("Select gender",style: TextStyle(
                                fontSize: 12,color:  darkomdee.darkomde==true?
                            Colors.white:Colors.grey )),
                              value: gender,style: TextStyle(color:   darkomdee.darkomde==true?
                            Colors.white:Colors.black),
                              isExpanded: true,
                              items:genderlist
                                  .map(( item) {
                                return DropdownMenuItem(
                                  value: item.toString(),
                                  child: Text(item.toString(),
                                      style: TextStyle(
                                          fontSize: 12,color:  darkomdee.darkomde==true?
                                      Colors.white:Colors.black )),
                                );
                              }).toList(),
                              onChanged:
                                  ( newValue) {
                                setState(() {

                                });
                              },
                            ),
                          ),*/
                          SizedBox(
                            height: h / 40,
                          ),
                          ElevatedButton(
                              style: buttonPrimary,
                              onPressed: () {
                                Get.to(const ProfileInfo());
                              },
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text("Modify",
                                      style: A_style_text_inside_button)),
                        ],
                      ),
                    )
                  : const Text("No Data");
            }
          },
        ),
      ),
    );
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
            'Successful',
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
                const Icon(
                  Icons.check_circle_outline,
                  color: logocolo,
                  size: 50,
                ),
                GestureDetector(
                  onTap: () {
                    //Get.offAll(() => const HomeScreen());
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


