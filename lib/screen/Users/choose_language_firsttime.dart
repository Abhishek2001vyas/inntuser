import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart%20';
import '../../language_constant.dart';
import '../../main.dart';
import '../credential/Login/login.dart';

class Chooselanguagefirsttime extends StatefulWidget {
  const Chooselanguagefirsttime({super.key});

  @override
  State<Chooselanguagefirsttime> createState() => _ChooselanguagefirsttimeState();
}

class _ChooselanguagefirsttimeState extends State<Chooselanguagefirsttime> {

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
      body: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: h/5),
              SizedBox(width: w,
                child:
                Center(
                  child: AnimatedTextKit(
                    totalRepeatCount: 100,
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      TyperAnimatedText(
                        'Choisir la langue',
                        textStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                        speed: Duration(milliseconds: 50),
                      ),
                      TyperAnimatedText(
                        'Choose language',
                        textStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                        speed: Duration(milliseconds: 50),
                      ),

                    ],

                  ),
                ),
              ),
              SizedBox(height: h/50),
          SizedBox(width: w/2,
            child: CheckboxListTile(value: languageCode=="fr"?true:false,
              controlAffinity: ListTileControlAffinity.leading,
              shape: CircleBorder(),
              activeColor: logocolo,
              title:  Text("Français",style: TextStyle(fontSize: 22),),
              onChanged: (value) async{

                  Locale locale = await setLocale("fr");
                  MyApp.setLocale(context, locale);
                  getLocale();
                  setState(() {

                  });

              },),
          ),
              SizedBox(height: h/50),

       SizedBox(width: w/2,
                child: CheckboxListTile(value: languageCode=="en"?true:false,
                  controlAffinity: ListTileControlAffinity.leading,
                  shape: CircleBorder(),
                  activeColor: logocolo,
                  title:  Text("English",style: TextStyle(fontSize: 22),),
                  onChanged: (value) async{
                  print("kjgsk $value");

                      Locale locale = await setLocale("en");
                      MyApp.setLocale(context, locale);
                      getLocale();
                  setState(() {

                  });

                  },),
              ),
//              Row(
//                children: [
//                  Column(children: [
//   Checkbox(
//     value: true,shape: CircleBorder(),
//     activeColor: logocolo,
//
//     onChanged: (value) {
//
//     },),
//                    Checkbox(
//                      value: true,shape: CircleBorder(),
//                      activeColor: logocolo,
//
//                      onChanged: (value) {
//
//                      },),
// ],),
//                  Column(children: [
//                    Text("Français",style: TextStyle(fontSize: 22),),
//                    Text("English",style: TextStyle(fontSize: 22),)
//                  ],),
//
//                ],
//              )


              SizedBox(height: h /40),
              Container(width: w/2,height: h/18,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))
                        ,backgroundColor: MaterialStatePropertyAll(logocolo)),
                    onPressed: ()async{
                      var sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.setString(
                          "languagechoose", '1'.toString());
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: const Login_email(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 1000)));
                    },
                    child:   Center(
                      child: AnimatedTextKit(
                        totalRepeatCount: 100,
                        isRepeatingAnimation: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            'Continuer',
                            textStyle: TextStyle( fontWeight: FontWeight.bold,
                            color: Colors.white
                            ),
                            speed: Duration(milliseconds: 50),
                          ),
                          TyperAnimatedText(
                            'Continue',
                            textStyle: TextStyle( fontWeight: FontWeight.bold,color: Colors.white),
                            speed: Duration(milliseconds: 50),
                          ),

                        ],

                      ),
                    )),
              )
            ],
          ),
        )
      ),

    );
  }
}

