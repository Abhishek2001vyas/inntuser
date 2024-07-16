import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inntuser/main.dart';
import 'package:inntuser/screen/Users/Navgationbar.dart';
import 'package:local_auth/local_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../Api/get_bannerlist_api.dart';
import '../../Api/maincategory.dart';
import '../../Api/signin_api.dart';
import '../Users/choose_language_firsttime.dart';
import '../credential/Login/login.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: globalKey);

  static final GlobalKey<_SplashState> globalKey = GlobalKey<_SplashState>();

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Longinapi = Get.put(signIn_api());
  final bannerapi = Get.put(bannerlist_api());
  final maincateapi = Get.put(fetchmaintCategoryList());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }

  final _localAuthentication = LocalAuthentication();
  bool _isUserAuthorized = false;
  bool _isUserAuthorized1 = false;
  var _isUserAuthorized2;

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    await _handle(Permission.notification);
    await _handle(Permission.camera);
    await _handle(Permission.unknown);
    await _handle(Permission.location);
    await _handle(Permission.storage);
    await _handle(Permission.manageExternalStorage);
    await _handle(Permission.photos);
    await _handle(Permission.audio);
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    //var choosecount = sharedPreferences.getString("choosecount");
    var faceelock = sharedPreferences.getBool("facelock");
    var choosecount = sharedPreferences.getString("languagechoose");

    if (faceelock == true) {
      await authenticateUser();

      choosecount != "1" || choosecount == null
          ? Get.offAll(Chooselanguagefirsttime())
          : userId != null
              ? Get.offAll(const DashBoardScreen())
              : Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: const Login_email(),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 1000)));
    } else {
      choosecount != "1" || choosecount == null
          ? Get.offAll(Chooselanguagefirsttime())
          : userId != null
              ? Get.offAll(const DashBoardScreen())
              : Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: const Login_email(),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 1000)));
    }
  }

  Future<void> authenticateUser() async {
    print("llll");
    bool isAuthorized = false;
    var isAuthorized11;
    try {
      print("dddd");
      _isUserAuthorized1 = await _localAuthentication.canCheckBiometrics;
      if (_isUserAuthorized1) {
        _isUserAuthorized2 ==
            await _localAuthentication.getAvailableBiometrics();
        if (_isUserAuthorized1) {
          isAuthorized = await _localAuthentication.authenticate(
            localizedReason: 'Scan your fingerprint to authenticate',
            options: const AuthenticationOptions(stickyAuth: true),
          );
        }
      }
    } on PlatformException catch (exception) {
      print("hhhkhk $exception");
      // if (exception.code == local_auth_error.notAvailable ||
      //     exception.code == local_auth_error.passcodeNotSet ||
      //     exception.code == local_auth_error.notEnrolled) {
      //   // Handle this exception here.
      //   print("jjjj $exception");
      // }
      if (isAuthorized) {
        print("klihjlihgvi");
      }
      print("llll $_isUserAuthorized1 $_isUserAuthorized2  $isAuthorized ");
    }

    if (!mounted) return;

    setState(() {
      _isUserAuthorized = isAuthorized;
    });
  }

  _handle(Permission permission) async {
    final sstatus = await permission.request();
    var status = await permission.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: Videospalyersplash());
  }
}

class Videospalyersplash extends StatefulWidget {
  const Videospalyersplash({
    super.key,
  });

  @override
  State<Videospalyersplash> createState() => _VideospalyersplashState();
}

class _VideospalyersplashState extends State<Videospalyersplash> {
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _initializeVideoPlayerFuture = controllersplash.initialize().then((value) {
      controllersplash.play();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controllersplash.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return VideoPlayer(controllersplash);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
