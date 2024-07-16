import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/privacy_policy.dart';
import 'package:inntuser/screen/Users/term_condition.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Controller/text2.dart';
import '../../language_constant.dart';
import '../../main.dart';
import 'account_deletion.dart';
import 'changelanguage.dart';



class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
 late bool facelock = false;



@override
void initState() {
 yyy();lll();
  super.initState();


}
 RxString  languagee="en".obs;


 lll()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   languagee.value= prefs.get(LAGUAGE_CODE).toString();

 }
yyy()async{
  var sharedPreferences = await SharedPreferences.getInstance();
  var gggg= sharedPreferences.getBool(
      "darkmode");
  var faceelock = sharedPreferences.getBool("facelock");
  setState(() {
    facelock=faceelock ?? false;
  });

  darkomdee.darkomde.value=gggg ?? false;
}

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return
    Obx(() =>
         Scaffold(
          backgroundColor:
          darkomdee.darkomde==true?
          Colors.black:
          Colors.white,
          appBar: AppBar(centerTitle: true, title:  Text(AppLocalizations.of(context)!.setting)

          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [

                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade50,
                          blurRadius: 1,
                        ),
                      ]),
                  child:
                  InkWell(
                    onTap: () {

                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.face,
                          size: 20,
                          color: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Obx(() =>
                            Text(
                              AppLocalizations.of(context)!.face,
                              style: TextStyle(
                                  color: Colors.grey.shade800,

                                  fontSize:  languagee=="en"?16:12,
                                  fontFamily: "Amazon_med"),
                            )),
                        const Spacer(),
                        Switch.adaptive(value: facelock, onChanged: (value) async{
                          setState(() {
                            facelock=value;
                          });
                          var sharedPreferences = await SharedPreferences.getInstance();
                          sharedPreferences.setBool(
                              "facelock",value );
                        },activeColor: logocolo,)
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade50,
                          blurRadius: 1,
                        ),
                      ]),
                  child: Column(
                    children: [

                      GestureDetector(
                        onTap: () {
                          Get.to(const Changelanguage());
                        },
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.globe,
                              size: 20,
                              color: Colors.grey.shade800,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.change_language,
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontFamily: "Amazon_med"),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 15,
                              color: Colors.grey.shade800,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(color: Colors.grey.shade200),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const PrivacyPolicy());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.plagiarism,
                              size: 20,
                              color: Colors.grey.shade800,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.privacy_policy,
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontFamily: "Amazon_med"),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 15,
                              color: Colors.grey.shade800,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(color: Colors.grey.shade200),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const TermCondition());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.plagiarism,
                              size: 20,
                              color: Colors.grey.shade800,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.terms_condition,
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontFamily: "Amazon_med"),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 15,
                              color: Colors.grey.shade800,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade50,
                          blurRadius: 1,
                        ),
                      ]),
                  child: Column(
                    children: [

                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          deleteMyAccountDialog();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.delete_account,
                              style: TextStyle(
                                  color: Colors.red.shade800,
                                  fontSize: 16,
                                  fontFamily: "Amazon_med"),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        )
      )

    ;
  }


 deleteMyAccountDialog() async {
   final h = MediaQuery.of(context).size.height;
   final w = MediaQuery.of(context).size.width;
   return


       Get.dialog(
         Dialog(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
           child: Padding(
             padding: const EdgeInsets.all(12.0),
             child: Container(width: w/1,height: h/4,
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
               color: Colors.white
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Text("Are you sure you want to delete your account?",
                   textAlign: TextAlign.center,
                   style: TextStyle(fontWeight: FontWeight.w500,
                     fontSize: 20
                   ),
                   ),
                   Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       GestureDetector(
                         onTap: (){
                           Get.back();
                         },
                         child: Container(
                             width: w/4,height: h/20,
                             decoration: BoxDecoration(
                               color: logocolo,
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Center(child: Text("No",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w500),)),
                             )),
                       ),
                       GestureDetector(
                         onTap: (){
                           Get.to( Accountdeletionquestion());
                         },
                         child: Container(
                             width: w/4,height: h/20,
                             decoration: BoxDecoration(
                               color: Colors.red,
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Center(child: Text("Yes",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w500),)),
                             )),
                       ),

                     ],
                   ),

                 ],
               ),
             ),
           ),
         )
       );


 }
}
