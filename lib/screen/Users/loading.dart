import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/qrsannerafter.dart';


class Loadingg extends StatefulWidget {
  final code;
  const Loadingg({super.key, this.code});

  @override
  State<Loadingg> createState() => _LoadinggState();
}

class _LoadinggState extends State<Loadingg> {
  final qrcodedata=Get.put(Getdatafromqr_api());

  @override
  void initState() {
    // TODO: implement initState

    ffff();
    Get.back();
    super.initState();
  }

  ffff()async{
 await   qrcodedata.qrscannerr(widget.code.toString());

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(color: logocolo,)),
    );
  }
}
