// import 'package:flutter/material.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:local_auth/error_codes.dart' as local_auth_error;
//
// class BiometricAuthentication extends StatefulWidget {
//   const BiometricAuthentication({Key? key, required this.appBarTitle})
//       : super(key: key);
//
//   final String appBarTitle;
//
//   @override
//   State<BiometricAuthentication> createState() =>
//       _BiometricAuthenticationState();
// }
//
// class _BiometricAuthenticationState extends State<BiometricAuthentication> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.appBarTitle),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _isUserAuthorized
//                 ? (const Text("Authentication successful!!!"))
//                 : (TextButton(
//               onPressed: authenticateUser,
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                     Colors.lightBlueAccent),
//               ),
//               child: const Text(
//                 "Authorize now",
//                 style: TextStyle(color: Colors.white),
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }