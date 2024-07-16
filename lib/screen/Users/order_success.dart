import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'Navgationbar.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    setState(() {
      currentTab=0;
    });

    Navigator.pushReplacement(
        context,
        PageTransition(
            child: const DashBoardScreen(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 1000)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/successfully.gif",
              //color: logocolo,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Order placed successfully",
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.green.shade500,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
