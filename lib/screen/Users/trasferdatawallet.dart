import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/verifywallettrasfer.dart';

import '../../ulits/constant.dart';


class Trasferdatawallet extends StatefulWidget {
  final amount;
  final recid;
  final otp;
  final mobile;
  final name;
  const Trasferdatawallet({super.key, this.amount, this.recid, this.otp, this.mobile, this.name});

  @override
  State<Trasferdatawallet> createState() => _TrasferdatawalletState();
}

class _TrasferdatawalletState extends State<Trasferdatawallet> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Transfer",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: "Amazon_bold",
          fontSize: 20,
        ),),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: h/5,),
              Center(child: Text("Send ${widget.amount} CFA to ${widget.name} ?",
              style: const TextStyle(fontSize: 30,
              fontWeight: FontWeight.bold
              ),

              ),),
              SizedBox(height: h/10,),
              SizedBox(width: w,height: h/16,
                child: ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(logocolo)),
                  onPressed: ()async{
                    Get.to(Verify_wallettrasfer(
                      reid: widget.recid,amount: widget.amount,
                     mobile: widget.mobile,otp: widget.otp,

                    ));
                  },
                  child: const Text("Send",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),

                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
