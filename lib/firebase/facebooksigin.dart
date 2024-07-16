import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class facebooklogin {
  final facebookLogin = FacebookLogin();

  Future<void> loginWithFacebook() async {
    final result = await facebookLogin.logIn();
    switch (result.status) {
      case FacebookLoginStatus.success:
        // You're logged in with Facebook, use result.accessToken to make API calls.
        break;
      case FacebookLoginStatus.cancel:
        // User cancelled the login.
        break;
      case FacebookLoginStatus.error:
        // There was an error during login.
        break;
    }
  }
}
