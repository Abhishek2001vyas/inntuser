import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:pinput/pinput.dart';

import '../../../Api/signup_verify_api.dart';
import '../../../Controller/button.dart';
import '../../../Controller/text2.dart';

var one;

class Verify_Login extends StatefulWidget {
  final otp;
  final mobile;
  final email;
  final countrycode;

  const Verify_Login({
    super.key,
    this.otp,
    this.mobile,
    this.countrycode,
    this.email,
  });

  @override
  State<Verify_Login> createState() => _Verify_LoginState();
}

class _Verify_LoginState extends State<Verify_Login> {
  final Verifyapi = Get.put(Verify_api());
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

  String errorMessage = '';

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
        backgroundColor: Colors.transparent,
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
              const Center(
                child: Text("Verify your mobile number or email",
                    style: Textcagehometitle),
              ),
              SizedBox(
                height: h / 20,
              ),
              Center(
                  child: Text('Please enter the code send to',
                      style: A_style_mid)),
              SizedBox(
                height: h / 50,
              ),
              Center(
                child: Text('${widget.countrycode} - ${widget.mobile}',
                    style: A_style_mid),
              ),
              SizedBox(
                height: h / 28,
              ),
              Obx(() => Verifyapi.newotp.value == ""
                  ? Center(
                      child: Text('OTP : ${widget.otp}', style: A_style_mid),
                    )
                  : Center(
                      child: Text('OTP : ${Verifyapi.newotp.value}',
                          style: A_style_mid),
                    )),

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
                                    foregroundColor: const Color(0xffffffff),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side:
                                          const BorderSide(color: Color(0xff1455ac)),
                                    ),
                                  ),
                                  onPressed: () async {
                                    resendOTP();
                                    await Verifyapi.resend_otpemail(
                                        widget.email);
                                  },
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: const BorderSide(
                                            color: Color(0xff1455ac)),
                                      ),
                                    ),
                                    onPressed: () async {
                                      resendOTP();
                                      await Verifyapi.resend_otpmobile(
                                          widget.mobile);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    )),
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
              //

              Obx(
                () => Verifyapi.isloading.value == true
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      )
                    : ElevatedButton(
                        style: buttonPrimary,
                        onPressed: _isVerifyButtonEnabled
                            ? () {
                                Map body = {
                                  'mobile_number': widget.mobile.toString(),
                                  "otp": _otpController.text.toString()
                                };
                                Verifyapi.verify(body);
                              }
                            : null,
                        child:
                            Text("Verify", style: A_style_text_inside_button)),
              )
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
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          content: const SizedBox(
              height: 200,
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Center(
                  //     child:
                  //     Image.asset("assets/images/Screenshot__30_-removebg-preview11.png",scale: 1.7)),
                  // SizedBox(
                  //     height: 15),
                  Center(
                    child: Text(
                      "Congratulations Amit",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      color: logocolo,
                      size: 50,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Your account has been created",
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 20),
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              )),
        );
      },
    );
  }
}
