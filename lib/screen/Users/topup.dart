import 'package:flutter/material.dart';

import '../../Controller/button.dart';
import '../../Controller/text2.dart';

class Topup extends StatefulWidget {
  const Topup({super.key});

  @override
  State<Topup> createState() => _TopupState();
}

class _TopupState extends State<Topup> {
  TextEditingController amount = TextEditingController();
  var payTypes;
  var pay;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Top up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter amount",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Ember_Medium",
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: h / 50,
              ),
              TextFormField(
                style: TextStyle(
                    //letterSpacing: 1.5,
                    //color: Colors.white,
                    color: Colors.black,
                    fontFamily: "Amazon_med",
                    fontSize: 14),
                controller: amount,
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Enter amount",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Text(
                      "CFA",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 50, minHeight: 0),
                  prefixStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  hintStyle: A_style_mid,
                ),
              ),
              SizedBox(
                height: h / 30,
              ),
              const Text(
                "Choose payment type",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Ember_Medium",
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: h / 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    shape: const CircleBorder(),
                    value: pay == 2 ? true : false,
                    activeColor: const Color(0xff1455ac),
                    onChanged: (newBool) {
                      setState(() {
                        pay = 2;
                        payTypes = "Orange money";
                      });
                      print('kkkll${payTypes}');
                    },
                  ),
                  Text("Orange money", style: A_style_medium),
                  SizedBox(
                    width: w / 80,
                  ),
                  Image.asset(
                    "assets/images/orange_money.png",
                    height: 15,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    shape: const CircleBorder(),
                    value: pay == 3 ? true : false,
                    activeColor: const Color(0xff1455ac),
                    onChanged: (newBool) {
                      setState(() {
                        pay = 3;
                        payTypes = "Moov money";
                      });
                      print('kkkll${payTypes}');
                    },
                  ),
                  Text("Moov money", style: A_style_medium),
                  SizedBox(
                    width: w / 80,
                  ),
                  Image.asset(
                    "assets/images/Picture3.png",
                    scale: 1.5,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    shape: const CircleBorder(),
                    value: pay == 4 ? true : false,
                    activeColor: const Color(0xff1455ac),
                    onChanged: (newBool) {
                      setState(() {
                        pay = 4;
                        payTypes = "Coris money";
                      });
                      print('kkkll${payTypes}');
                    },
                  ),
                  Text("Coris money", style: A_style_medium),
                  SizedBox(
                    width: w / 80,
                  ),
                  Image.asset("assets/images/Picture2.png", scale: 7.5)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    shape: const CircleBorder(),
                    value: pay == 5 ? true : false,
                    activeColor: const Color(0xff1455ac),
                    onChanged: (newBool) {
                      setState(() {
                        pay = 5;
                        payTypes = "Credit card";
                      });
                      print('kkkll${payTypes}');
                    },
                  ),
                  Text("Credit card", style: A_style_medium),
                  Image.asset("assets/images/creadit.png", scale: 1.5),
                ],
              ),
              SizedBox(
                height: h / 10,
              ),
              ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () {},
                  child: Text("Continue", style: A_style_text_inside_button)),
            ],
          ),
        ),
      ),
    );
  }
}
