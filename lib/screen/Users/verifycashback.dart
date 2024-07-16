import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:pinput/pinput.dart';

import '../../../Controller/button.dart';
import '../../../Controller/text2.dart';
import '../../Api/loyaltypoints.dart';



class Verify_cashback extends StatefulWidget {
  final otp;
  final mobile;


  const Verify_cashback({
    super.key,
    this.otp,
    this.mobile,

  });

  @override
  State<Verify_cashback> createState() => _Verify_cashbackState();
}

class _Verify_cashbackState extends State<Verify_cashback> {
  final Verifyapi2 = Get.put(loyaltypointsapi());
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
                child: Text('228 - ${widget.mobile}',
                    style: A_style_mid),
              ),
              SizedBox(
                height: h / 28,
              ),
              Center(
                child: Text('OTP : ${widget.otp}', style: A_style_mid),
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
                      showCursor: true,
                      onCompleted: (pin) {
                        setState(() {
                          otp = pin;
                        });
                      }),
                ),
              ),
              SizedBox(height: h / 20),

              //

              // Obx(
              //       () => Verifyapi.isloading.value == true
              //       ? Center(
              //     child: CircularProgressIndicator(color: Colors.blue),
              //   )
              //       :
              ElevatedButton(
                  style: buttonPrimary,
                  onPressed: _isVerifyButtonEnabled
                      ? () async{

                    Verifyapi2.verifycashback(_otpController.text.toString());
                  }
                      : null,
                  child:
                  Text("Verify", style: A_style_text_inside_button)),
              // )
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
