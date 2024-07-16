import 'package:flutter/material.dart';

import '../Controller/text2.dart';

class textformfieldsignup extends StatelessWidget {
  const textformfieldsignup({
    super.key,
    required this.fullNameController,
    required this.hindtext,
    required this.validator,
  });

  final TextEditingController fullNameController;
  final String hindtext;
  final validator;

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
      style: TextStyle(
        //letterSpacing: 1.5,
        //color: Colors.white,
          color: Colors.black,
          fontFamily: "Amazon_med",
          fontSize: 14),
      controller: fullNameController,
      validator: validator,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
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
        hintText: hindtext,
        hintStyle: A_style_mid,
      ),
    );
  }
}
