import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/walletapi.dart';
import '../../ulits/custom widget.dart';
import '../../ulits/utils.dart';

class Trasferwallet extends StatefulWidget {
  const Trasferwallet({super.key});

  @override
  State<Trasferwallet> createState() => _TrasferwalletState();
}

class _TrasferwalletState extends State<Trasferwallet> {
  TextEditingController mobile=TextEditingController();
  TextEditingController amount=TextEditingController();
  final trasfer =Get.put(wallet_api());
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
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter phone number or email",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Ember_Medium",
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: h/50,),
              textformfieldsignup(
                fullNameController: mobile,
                validator: (value) {
                  // if (value!.isEmpty) {
                  //   return "Enter phone number or email";
                  // } else {
                  //   return null;
                  // }
                },
                hindtext: "Enter phone number or email",
              ),
              SizedBox(height: h/40,),
              const Text(
                "Enter Amount",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Ember_Medium",
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: h/50,),
              Container(
                width: w,
                height: 50.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(width: 1,color: Colors.grey)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      const Text(
                        textAlign: TextAlign.start,
                        "CFA",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: "Hey"),
                      ),
                      SizedBox(
                        width: w/45,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: amount,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Please enter amount";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(

                              border: InputBorder.none,
                              hintText: 'Enter Amount',
                              hintStyle: TextStyle(
                                  color: Colors.grey
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: h/5,),
              SizedBox(width: w,height: h/16,
              child: ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(logocolo)),
                onPressed: ()async{
                if(amount.text.isEmpty || mobile.text.isEmpty){
                  Utils().sendMassage('Please entre all fields');
                }
                else{
                  trasfer.tranferMoney(amount.text.toString(),mobile.text.toString());
                }
                },
                child: const Text("Continue",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),

              ),
              )

            ],
          ),
        ),
      ),

    );
  }
}
