// import 'package:flutter/material.dart';
//
// class SignInScreen extends StatefulWidget {
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _allFieldsFilled = false;
//
//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your email';
//     }
//     // You can add more complex email validation logic here if needed
//     return null;
//   }
//
//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your password';
//     }
//     if (value.length < 8) {
//       return 'Password must be at least 8 characters long';
//     }
//     if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
//       return 'Password can only contain letters and numbers';
//     }
//     return null;
//   }
//
//   void _checkAllFieldsFilled() {
//     final emailValid = _validateEmail(_emailController.text) == null;
//     final passwordValid = _validatePassword(_passwordController.text) == null;
//
//     setState(() {
//       _allFieldsFilled = emailValid && passwordValid;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign In'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: _validateEmail,
//                 onChanged: (_) => _checkAllFieldsFilled(),
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: _validatePassword,
//                 onChanged: (_) => _checkAllFieldsFilled(),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _allFieldsFilled ? () {} : null,
//                 style: ElevatedButton.styleFrom(
//                   primary: _allFieldsFilled ? Colors.green : Colors.grey,
//                 ),
//                 child: Text('Sign In'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
