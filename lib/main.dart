import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:inntuser/firebase/deeplinking.dart';
import 'package:inntuser/screen/Common/splash.dart';
import 'package:inntuser/screen/credential/Login/login.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:inntuser/ulits/darkmode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import 'firebase/fcm.dart';
import 'firebase/notificationcode.dart';
import 'firebase_options.dart';
import 'language_constant.dart';

final darkomdee = Get.put(Darkmode());
late VideoPlayerController controllersplash;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: logocolo,
  ));
  // var notificationService = NotificationService;

  DartPluginRegistrant.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  if (initialLink != null) {
    deepp().handleDeepLink(initialLink);
  }

  // deepp().deeppfunction();
  deepp().deepppfunction();
  FirebaseApi().isDeviceTokenRefresh();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseApi().initNotification();
  // notification().firebaseinit();
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Get.to(Login_email());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  final darkomdee = Get.put(Darkmode());

  @override
  void initState() {
    yyy();
    controllersplash =
        VideoPlayerController.asset("assets/images/Starting_annimation.mov");
    super.initState();
  }

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  yyy() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var gggg = sharedPreferences.getBool("darkmode");
    darkomdee.darkomde.value = gggg ?? false;
  }

  @override
  Widget build(BuildContext context) {
    notification().firebaseinit(context as BuildContext);
    MaterialColor buildMaterialColor(Color color) {
      List strengths = <double>[.05];
      Map<int, Color> swatch = {};
      final int r = color.red, g = color.green, b = color.blue;

      for (int i = 1; i < 10; i++) {
        strengths.add(0.1 * i);
      }
      for (var strength in strengths) {
        final double ds = 0.5 - strength;
        swatch[(strength * 1000).round()] = Color.fromRGBO(
          r + ((ds < 0 ? r : (255 - r)) * ds).round(),
          g + ((ds < 0 ? g : (255 - g)) * ds).round(),
          b + ((ds < 0 ? b : (255 - b)) * ds).round(),
          1,
        );
      }
      return MaterialColor(color.value, swatch);
    }

// Main screen on theme data all appbar using
    return GetMaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      // themeMode: ThemeMode.dark,
      themeMode: ThemeMode.system,
      theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.black, selectionColor: Colors.blue.shade50),
          useMaterial3: false,
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              color: logocolo,
              foregroundColor: Colors.white,
              titleTextStyle: TextStyle(
                  //letterSpacing: 2,
                  color: Colors.white,
                  fontFamily: "Amazon_med",
                  fontSize: 18)),
          colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: buildMaterialColor(const Color(0xffffffff)))
              .copyWith(surface: Colors.white)),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
