import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Api/signin_api.dart';
import '../../../Controller/button.dart';
import '../../../Controller/text2.dart';
import '../../../firebase/facebooksigin.dart';
import '../../../firebase/googlesigin.dart';
import '../../Users/home.dart';
import '../Signin/Signup.dart';
import 'forget_password.dart';

class Login_email extends StatefulWidget {
  final refercode;

  const Login_email({super.key, this.refercode});

  @override
  State<Login_email> createState() => _Login_emailState();
}

class _Login_emailState extends State<Login_email>
    with TickerProviderStateMixin {
  final Longinapi = Get.put(signIn_api());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with the desired number of tabs
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  final valid = GlobalKey<FormState>();
  RegExp pattern = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+");
  final int _currentIndex = 0;
  bool passwordObscured = true;
  bool isloading = false;
  bool? isChecked = false;

  final Uri _url = Uri.parse('http://157.66.191.24:88/termsandcondition');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: h / 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // color: Colors.transparent,
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        padding: const EdgeInsets.all(4),
                        dividerColor: Colors.transparent,
                        controller: _tabController,
                        // Set the controller
                        indicator: const BoxDecoration(
                          //  color: Colors.grey.shade100,
                          border: Border(
                            bottom: BorderSide(
                              color: logocolo,
                              width: 2.3,
                            ),
                          ),
                          // borderRadius: BorderRadius.circular(10),
                        ),
                        labelColor: Colors.black,
                        tabs: [
                          Tab(
                            child: Text(" Sign in ", style: A_style_heading),
                          ),
                          Tab(
                            child: Text(" Sign up ", style: A_style_heading),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h / 80,
                    ),
                    SizedBox(
                      height: h / 0.98,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController, // Set the controller
                        children: [
                          buildColumn(h, context),

                          Details(
                            referalcode: widget.refercode,
                          ),
                          // Add more TabBarView children if needed
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Form buildColumn(double h, BuildContext context) {
    return Form(
      key: valid,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Email or phone",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Ember_Medium",
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: h / 90,
          ),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter mobile number or email address";
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
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              hintText: "Example@gmail.com",
            ),
          ),
          SizedBox(
            height: h / 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Password",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Ember_Medium",
                    fontWeight: FontWeight.w500),
              ),
              InkWell(
                  onTap: () {
                    // Get.to(Verify_Login());
                    Get.to(const Forgot_Password());
                  },
                  child: const Text("Forgot Password ?",
                      style: A_style_text_button)),
            ],
          ),
          SizedBox(
            height: h / 90,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter password";
              } else {
                return null;
              }
            },
            obscureText: passwordObscured,
            keyboardType: TextInputType.name,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
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
                hintText: "Password"),
            controller: passwordController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Text("Remember me", style: A_style_mid),
                ],
              ),
              InkWell(
                  onTap: () {
                    Get.to(const Home_Page());
                  },
                  child: const Text(
                    "Sign in as a guest",
                    style: TextStyle(
                        //letterSpacing: 1,
                        color: Color(0xff1455ac),
                        fontFamily: "Amazon_med",
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  )),
            ],
          ),
          SizedBox(
            height: h / 40,
          ),
          Obx(() => Longinapi.isloading.value == true
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                )
              : ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () {
                    if (valid.currentState!.validate()) {
                      Longinapi.signIn(emailController.text.toString(),
                          passwordController.text.toString());
                    }
                  },
                  child: Text("Continue", style: A_style_text_inside_button))),
          SizedBox(
            height: h / 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Or",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Ember_Medium",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              buildElevatedButton(
                onPressed: () {
                  facebooklogin().loginWithFacebook();
                  // signInWithFacebook();
                  // Add your onPressed logic here
                },
                primaryColor: logocolo,
                imageAsset: "assets/imagess/facebook.png",
                buttonText: "Sign in with Facebook",
                textColor: Colors.white,
                buttonHeight: 50.0, // Set the desired button height here
              ),
              SizedBox(
                height: h / 100,
              ),
              buildElevatedButton(
                onPressed: () {
                  // Add your onPressed logic here
                },
                primaryColor: Colors.black,
                imageAsset: "assets/imagess/apple-logo.png",
                buttonText: "Sign in with Apple",
                textColor: Colors.white,
                buttonHeight: 50.0, // Set the desired button height here
              ),
              SizedBox(
                height: h / 100,
              ),
              buildElevatedButton(
                onPressed: () async {
                  await Fir().signInWithGoogle();
                  // signInWithGoogle();
                  // Add your onPressed logic here
                },
                primaryColor: Colors.white70,
                imageAsset: "assets/imagess/search.png",
                buttonText: "Sign in with Google",
                textColor: Colors.black,
                // Change the text color as per your design
                buttonHeight: 50.0, // Set the desired button height here
              ),
            ],
          ),
          SizedBox(
            height: h / 50,
          ),
          Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("By signing up, you agree to innt's",
                    maxLines: 2, style: A_style_foot),
                GestureDetector(
                  onTap: _launchUrl,
                  child: const Text("Terms & Condition ",
                      maxLines: 2,
                      style: TextStyle(
                          //letterSpacing: 1.5,
                          color: Color(0xff1455ac),
                          fontFamily: "Amazon_med",
                          fontSize: 9)),
                ),
                Text("and ", style: A_style_foot),
                GestureDetector(
                  onTap: _launchUrl,
                  child: const Text("Privacy Policy",
                      maxLines: 2,
                      style: TextStyle(
                          //letterSpacing: 1.5,
                          color: Color(0xff1455ac),
                          fontFamily: "Amazon_med",
                          fontSize: 9)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: h / 50,
          ),
        ],
      ),
    );
  }

  Widget buildElevatedButton({
    required VoidCallback onPressed,
    required Color primaryColor,
    required String imageAsset,
    required String buttonText,
    required Color textColor,
    required double buttonHeight,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Colors.black),
          ),
        ),
        child: SizedBox(
          height: buttonHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align image to start
            children: [
              SizedBox(
                height: buttonHeight,
                width: buttonHeight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Container(
                height: buttonHeight,
                alignment: Alignment.center, // Center text vertically
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Ember_Medium",
                    fontWeight: FontWeight.w500,
                    color: textColor,
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
