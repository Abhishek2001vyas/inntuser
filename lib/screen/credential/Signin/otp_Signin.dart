import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/button.dart';
import '../../../Controller/text2.dart';
import '../../Users/home.dart';

var one;

class Verify_Signin extends StatefulWidget {
  const Verify_Signin({super.key});

  //final String otp;

  //Verify({required this.otp, required id});

  @override
  State<Verify_Signin> createState() => _Verify_SigninState();
}

class _Verify_SigninState extends State<Verify_Signin> {
  final TextEditingController _otpController = TextEditingController();
  bool _isVerifyButtonEnabled = false;
  bool isloading = false;
  String otp = '';
  String otpResendValue = '';
  String mobiles = '';
  bool showCenter = false;
  int _remainingTime = 5;
  bool _isTimerActive = false;
  Timer? _timerr;

  bool? isChecked = false;

  final bool _onEditing = true;
  String? _code;

  generateOTP() {
    setState(() {
      one = (1000 + Random().nextInt(9000)).toString();
    });
  }

  void startTimer() {
    setState(() {
      _isTimerActive = true;
    });

    _timerr = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        stopTimer();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  void stopTimer() {
    setState(() {
      _isTimerActive = false;
    });
    if (_timerr != null) {
      _timerr!.cancel();
    }
  }

  void resendOTP() {
    setState(() {
      _remainingTime = 5;
    });
    startTimer();
  }

  final int _secondsRemaining = 30;
  late Timer _timer;
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
    //otp = widget.otp;
  }

  void getMobileFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mobiles = prefs.getString('mobile') ?? '';
    });
  }



  String errorMessage = '';
  String existingOTP = "3284";

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
      margin: const EdgeInsets.only(right: 2),
      width: 65,
      height: 65,
      textStyle: const TextStyle(
          fontSize: 20, color: Color(0xff1455ac), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h / 20,
              ),
              Text("Verify Your Mobile Number", style: A_style_text_head2),
              SizedBox(
                height: h / 20,
              ),
              Text('Please enter the OPT, you received on your mobile phone',
                  style: A_style_mid),
              SizedBox(
                height: h / 50,
              ),
              Row(
                children: [
                  Text('+91 - 1234567890', style: A_style_mid),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Text('Edit number', style: A_style_text_button),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h / 28,
              ),


              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: h / 14.8,
                  width: w / 1.3,
                  child: Pinput(
                      controller: _otpController,
                      onChanged: (value) {
                        setState(() {
                          _isVerifyButtonEnabled = value.length == 4;
                        });
                      },
                      //controller: off,
                      separatorBuilder: (index) => const SizedBox(width: 22),
                      length: 4,
                      defaultPinTheme: defaultPinTheme,
                      // focusedPinTheme: focusedPinTheme,
                      // submittedPinTheme: submittedPinTheme,
                      showCursor: true,
                      onCompleted: (pin) {
                        setState(() {
                          otp = pin;
                        });
                      }),
                ),
              ),
              SizedBox(height: h / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !_isTimerActive
                      ? const Text(" ")
                      : Text("Resend in", style: A_style_mid),
                  // Text(" ", style: TextStyle(color: Colors.black, fontFamily: "Roboto_med", fontSize: 17),),
                  !_isTimerActive
                      ? Column(
                          children: [
                            Text("Resend OTP via ", style: A_style_mid),
                            SizedBox(
                              height: h / 40,
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.square(40), backgroundColor: Colors.white,
                                    maximumSize: const Size.square(150),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side:
                                          const BorderSide(color: Color(0xff1455ac)),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          "assets/images/email-svgrepo-com.png",
                                          color: const Color(0xff1455ac),
                                          scale: 45),
                                      SizedBox(
                                        width: w / 60,
                                      ),
                                      const Text("Email",
                                          textAlign: TextAlign.center,
                                          style: A_style_text_button),
                                    ],
                                  ),

                                ),
                                SizedBox(
                                  width: w / 25,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.square(40), backgroundColor: Colors.white,
                                    maximumSize: const Size.square(150),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side:
                                          const BorderSide(color: Color(0xff1455ac)),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          "assets/images/messaging-lines-svgrepo-com.png",
                                          color: const Color(0xff1455ac),
                                          scale: 45),
                                      //Image.asset("assets/messaging-lines-svgrepo-com.png", scale: 20, color: Colors.pink),
                                      SizedBox(
                                        width: w / 60,
                                      ),
                                      const Text("SMS",
                                          textAlign: TextAlign.center,
                                          style: A_style_text_button),
                                    ],
                                  ),

                                ),

                              ],
                            ),
                          ],
                        )
                      : Text(
                          '  $_remainingTime seconds',
                          style: A_style_mid,
                        ),
                ],
              ),
              SizedBox(
                height: h / 20,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: const Color(0xff1455ac),
                    onChanged: (newBool) {
                      setState(() {
                        isChecked = newBool;
                      });
                    },
                  ),
                  const Text(
                    "Send me course updates & remainders on WhatsApp",
                    style: TextStyle(fontFamily: "Amazon_med", fontSize: 13),
                  ),
                ],
              ),

              ElevatedButton(
                  style: buttonPrimary,
                  onPressed: _isVerifyButtonEnabled
                      ? () {
                          setState(() {
                            isloading = true;
                          });
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              isloading = false;
                              congr();
                              Future.delayed(
                                  const Duration(seconds: 2),
                                  () =>
                                      /*  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home_Page()
                                    )
                                    ),*/
                                      Get.off(const Home_Page()));
                            });
                          });
                        }
                      : null,
                  child: isloading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text("Verify", style: A_style_text_inside_button)),
            ],
          ),
        ),
      ),
    );
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
}
