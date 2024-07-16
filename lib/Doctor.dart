/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ApexQuote/views/subCategoryPage/PromoGallery.dart';

import '../../navigation_bar.dart';
import '../../payment/Address.dart';
import '../../utilities/AppConstant.dart';
import '../../utilities/constant.dart';
import '../Notification_list.dart';
import '../subCategoryPage/SightSeen.dart';
import 'ConferenceCommunity.dart';
import 'HomeCare.dart';
import 'ConferenceInfo.dart';


class Doctor_Screen extends StatefulWidget {
  const Doctor_Screen({super.key});

  @override
  State<Doctor_Screen> createState() => _Doctor_ScreenState();
}

class _Doctor_ScreenState extends State<Doctor_Screen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return  Scaffold(
      backgroundColor: Colors.white,


      appBar: AppBar(
        automaticallyImplyLeading: true,

        surfaceTintColor: Colors.transparent,
        elevation: 2,
        toolbarHeight: 55,
        title: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Address()));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  children: [
                    // Icon(
                    //   Icons.location_on_rounded,
                    //   color: kPrimaryColor,
                    // ),
                    Text(
                      "Welcome",
                      style: TextStyle(
                          color: kgreysColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                      "Anju Aryan",
                      style: TextStyle(color: kgreysColor,
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),

      ),

      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 100 / 100,
        width: MediaQuery.of(context).size.width * 100 / 100,
        child: SingleChildScrollView(



          child: Column(
            children: [


              Container( decoration: BoxDecoration(
                  color: Color(0xffF9F9F9).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15)),

                child: Padding(
                  padding: const EdgeInsets.all(20.0),



                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,


                    children: [

                      Text(
                        "Participants Registration",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),


                      Container(
                        margin: EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100,
                                spreadRadius: 0,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 10,
                              ),
                            ],


                            borderRadius: BorderRadius.circular(20)),


                        child: TextFormField(


                          maxLength: 38,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Enter Your Name",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:kPrimaryColor), // Set border color here when focused
                              borderRadius: BorderRadius.circular(20),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey), // Set border color here
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      Container(
                        decoration: BoxDecoration(color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100,
                                spreadRadius: 0,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 10,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          maxLength: 38,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Select Your Club  ",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:kPrimaryColor), // Set border color here when focused
                              borderRadius: BorderRadius.circular(20),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey), // Set border color here
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      Container(
                        decoration: BoxDecoration(color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100,
                                spreadRadius: 0,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 10,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          maxLength: 38,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Your Phone No",

                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor), // Set border color here when focused
                              borderRadius: BorderRadius.circular(20),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey), // Set border color here
                              borderRadius: BorderRadius.circular(20),
                            ),
                            // border: OutlineInputBorder(
                            //
                            //   borderRadius: BorderRadius.circular(20),
                            // ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100,
                                spreadRadius: 0,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 10,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          maxLength: 38,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Your Email Id",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor), // Set border color here when focused
                              borderRadius: BorderRadius.circular(20),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey), // Set border color here
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      Container(
                        decoration: BoxDecoration(color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100,
                                spreadRadius: 0,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 10,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          maxLength: 38,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Aadhaar No. (Optional)",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor), // Set border color here when focused
                              borderRadius: BorderRadius.circular(20),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey), // Set border color here
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      InkWell(onTap: (){

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Navi()));
                      },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isPortrait ? 16 : 20,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ),


                      SizedBox(
                        height: 15,
                      ),






                    ],
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }

}
*/
