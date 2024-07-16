import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api/contact_us_api.dart';
import '../../ulits/constant.dart';


class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  TextEditingController mobile= TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController first= TextEditingController();
  TextEditingController last =TextEditingController();
  TextEditingController message= TextEditingController();
  TextEditingController object =TextEditingController();

final contactus=Get.put(fetchContactUs());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        // forceMaterialTransparency: true,
        // automaticallyImplyLeading: false,
        backgroundColor: logocolo,
        title: const Text(
          "Contact us",
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

            Image.asset(
                "assets/images/contact-us-4832699-4025814-ezgif.com-video-to-gif-converter.gif"),
                SizedBox(
                  height: h / 45,
                ),
                const Center(
                  child: Text(
                    textAlign: TextAlign.start,
                    "Send us a message",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: "Hey"),
                  ),
                ),
                SizedBox(
                  height: h / 90,
                ),
                const Text(
                  textAlign: TextAlign.start,
                  "First ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: "Hey"),
                ),
                SizedBox(
                  height: h / 180,
                ),
                TextFormField(
                  controller: first,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Please entre first name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                      hintText: 'Enter your first name',
                      hintStyle: const TextStyle(color: Colors.grey)),
                ),
                SizedBox(
                  height: h / 45,
                ),
                const Text(
                  textAlign: TextAlign.start,
                  "Last ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: "Hey"),
                ),
                SizedBox(
                  height: h / 180,
                ),
                TextFormField(
                  controller: last, validator: (value) {
                  if(value!.isEmpty){
                    return "Please entre last name";
                  }
                  return null;
                },
                  decoration: InputDecoration(
                      enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                      hintText: 'Enter your Last name',
                      hintStyle: const TextStyle(color: Colors.grey)),
                ),
                SizedBox(
                  height: h / 45,
                ),
                const Text(
                  textAlign: TextAlign.start,
                  "Phone ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: "Hey"),
                ),
                SizedBox(
                  height: h / 180,
                ),
                TextFormField(
                  controller: mobile,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Please entre mobile";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                      hintText: 'Enter your Phone name',
                      hintStyle: const TextStyle(color: Colors.grey)),
                ),
                SizedBox(
                  height: h / 45,
                ),
                const Text(
                  textAlign: TextAlign.start,
                  "Email ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: "Hey"),
                ),
                SizedBox(
                  height: h / 180,
                ),
                TextFormField(
                  controller: email,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Please entre email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                      hintText: 'Enter your Email Address',
                          hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                SizedBox(
                  height: h / 45,
                ),
                const Text(
                  textAlign: TextAlign.start,
                  "Object ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: "Hey"),
                ),
                SizedBox(
                  height: h / 180,
                ),
               TextFormField(
                 controller: object,
                 validator: (value) {
                   if(value!.isEmpty){
                     return "Please entre object";
                   }
                   return null;
                 },
                 decoration: InputDecoration(
                     enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                     hintText: 'Enter the object of your message',
                          hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                SizedBox(
                  height: h / 45,
                ),
                const Text(
                  textAlign: TextAlign.start,
                  "Message ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: "Hey"),
                ),
                SizedBox(
                  height: h / 180,
                ),
               TextFormField(
                 validator: (value) {
                   if(value!.isEmpty){
                     return "Please entre meassage";
                   }
                   return null;
                 },
                 controller: message,maxLines: null,minLines: 5,
                 decoration: InputDecoration(
                     enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black)),
                     hintText: 'Enter message',
                            hintStyle: const TextStyle(color: Colors.grey)),
                      ),
                SizedBox(
                  height: h / 45,
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: FloatingActionButton(
                //     onPressed: () {},
                //     child: Image.asset(
                //       "assets/images/whatsapp.png",
                //       height: 40,
                //       width: 40,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: h / 45,
                // ),
                GestureDetector(
                  onTap: ()async{
                    if(formKey.currentState!.validate()){
                   await   contactus.contact_Us(first.text.toString(), last.text.toString(),
                       mobile.text.toString(), email.text.toString(), object.text.toString(), message.text.toString());
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
                SizedBox(
                  height: h / 45,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Image.asset(
          "assets/images/whatsapp.png",
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}




//
//
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:get/get.dart';
// import 'package:inntuser/Api/contact_us_api.dart';



//
// import '../../Controller/controller.dart';
// import '../../ulits/constant.dart';
//
// class ContactUs extends StatefulWidget {
//   const ContactUs({super.key});
//
//   @override
//   State<ContactUs> createState() => _ContactUsState();
// }
//
// class _ContactUsState extends State<ContactUs> {
//   GetxControllers controller = Get.put(GetxControllers());
//   final getContact_Us_api = Get.put(fetchContactUs());
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(centerTitle: true, title: const Text("Contact Us")),
//       body: Column(
//         children: [
//           Image.asset(
//               "assets/images/contact-us-4832699-4025814-ezgif.com-video-to-gif-converter.gif"),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: FutureBuilder(
//                 future: getContact_Us_api.contact_Us(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                         child: CircularProgressIndicator(
//                       color: logocolo,
//                     ));
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else {
//                     return ListView.builder(
//                       padding: EdgeInsets.all(8),
//                       shrinkWrap: true,
//                       itemCount: contactUs[0].length,
//                       itemBuilder: (context, index) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: h / 20),
//                             Row(
//                               children: [
//                                 Icon(Icons.person),
//                                 Text(
//                                     " client name             = " +
//                                         contactUs[0][index]["client_name"]
//                                             .toString(),
//                                     style: TextStyle(
//                                         //letterSpacing: 1.5,
//                                         color: Colors.black,
//                                         fontFamily: "Amazon_Bold",
//                                         fontSize: 16)),
//                               ],
//                             ),
//                             SizedBox(height: h / 50),
//                             Row(
//                               children: [
//                                 Icon(Icons.call),
//                                 RichText(
//                                     text: TextSpan(children: [
//                                   TextSpan(
//                                       style: TextStyle(
//                                           //letterSpacing: 1.5,
//                                           color: Colors.black,
//                                           fontFamily: "Amazon_Bold",
//                                           fontSize: 16),
//                                       text: " phone no                     = "),
//                                   TextSpan(
//                                       recognizer: TapGestureRecognizer()
//                                         ..onTap = () => _callNumber(),
//                                       style: TextStyle(
//                                           //letterSpacing: 1.5,
//                                           color: Colors.blue,
//                                           fontFamily: "Amazon_Bold",
//                                           fontSize: 16),
//                                       text: contactUs[0][index]["phone_no"]
//                                           .toString())
//                                 ]))
//                               ],
//                             ),
//                             SizedBox(height: h / 50),
//                             Row(
//                               children: [
//                                 Icon(Icons.email_outlined),
//                                 Text(
//                                     " email                        = " +
//                                         contactUs[0][index]["email"].toString(),
//                                     style: TextStyle(
//                                         //letterSpacing: 1.5,
//                                         color: Colors.black,
//                                         fontFamily: "Amazon_Bold",
//                                         fontSize: 16)),
//                               ],
//                             ),
//                             SizedBox(height: h / 50),
//                             Row(
//                               children: [
//                                 Icon(Icons.chat_rounded),
//                                 Text(
//                                     " whatsapp number  = " +
//                                         contactUs[0][index]["whatsapp_number"]
//                                             .toString(),
//                                     style: TextStyle(
//                                         //letterSpacing: 1.5,
//                                         color: Colors.black,
//                                         fontFamily: "Amazon_Bold",
//                                         fontSize: 16)),
//                               ],
//                             ),
//
//                             // Text(apiCaller.contactList[0][index]["phone_no"]),
//                           ],
//                         );
//                       },
//                     );
//                   }
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
//
//   _callNumber() async {
//     var number = '${contactUs[0][0]["phone_no"]}'; //set the number here
//     bool? res = await FlutterPhoneDirectCaller.callNumber(number);
//   }
//
// // _sendingMails() async {
// //   var url = Uri.parse("mailto:feedback@geeksforgeeks.org");
// //   if (await canLaunchUrl(url)) {
// //     await launchUrl(url);
// //   } else {
// //     throw 'Could not launch $url';
// //   }
// // }
// }
