import 'package:flutter/material.dart';

import '../ulits/constant.dart';

class CustomIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const CustomIndicator(
      {super.key, required this.currentIndex, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          width: 7.0,
          height: 7.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? logocolo : Colors.grey,
          ),
        ),
      ),
    );
  }
}
