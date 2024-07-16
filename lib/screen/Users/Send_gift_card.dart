import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/gift_api.dart';
import '../../ulits/utils.dart';
import 'Navgationbar.dart';


class Sendgiftcard extends StatefulWidget {
  const Sendgiftcard({super.key});

  @override
  State<Sendgiftcard> createState() => _SendgiftcardState();
}

class _SendgiftcardState extends State<Sendgiftcard> {


  final gift =Get.put(Gift_api());
  var type;
TextEditingController anothername =TextEditingController();
  TextEditingController message =TextEditingController();
  TextEditingController mobile =TextEditingController();
  TextEditingController amount =TextEditingController();
  final valid = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              setState(() {
                currentTab = 4;
              });

              Get.offAll(const DashBoardScreen());
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: const Text(
          "Send Gift Cards",
        ),

      ),

      body: Form(
        key: valid,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text("Would you like the recipient to know who sent the voucher?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                SizedBox(height: h/100,),
                Row(
                  children: [

                    Checkbox(

                      value: type=="Yes, display my name" ? true :false,
                      onChanged: (value) {
                        value==true ?
                            setState(() {
                              type ="Yes, display my name";
                            }):null
                        ;
                      },shape: const CircleBorder(),activeColor: logocolo,),
                    const Text("Yes, display my name",),


                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: type=="Yes, display another name" ? true :false,
                      onChanged: (value) {
                       value==true ?
                            setState(() {
                              type ="Yes, display another name";
                            }):null
                        ;
                      },
                      shape: const CircleBorder(),activeColor: logocolo,),
                    const Text("Yes, display another name",),


                  ],
                ),

                type=="Yes, display another name" ?
                Padding(
                  padding:  EdgeInsets.only(left: w/8.0),
                  child: SizedBox(
                    width: w/1.5,
                    child: TextFormField(
                      controller: anothername,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
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
                        hintText: "name",
                      ),
                    ),
                  ),
                ):
                const SizedBox(),

                Row(
                  children: [
                    Checkbox(value: type=="No, send it anonymously" ? true :false,
                      onChanged: (value) {
                        value==true ?
                        setState(() {
                          type ="No, send it anonymously";
                        }):null
                        ;

                      },

                      shape: const CircleBorder(),activeColor: logocolo,),
                    const Text("No, send it anonymously",),


                  ],
                ),
                SizedBox(height: h/100,),
                const Text("Email or phone number of recipient",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                SizedBox(height: h/100,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter mobile number or email address";
                    } else {
                      return null;
                    }
                  },
                  cursorColor: Colors.black,
                  controller: mobile,
                  decoration: InputDecoration(enabled: true,
                      hintText: "Email or phone number",
                      focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(15,),borderSide: const BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15,),borderSide: const BorderSide(color: Colors.grey))),
                ),
                SizedBox(height: h/100,),
                const Text("Message",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                SizedBox(height: h/100,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter message";
                    } else {
                      return null;
                    }
                  },
                  controller: message,
                  cursorColor: Colors.black,maxLines: null,minLines: 5,keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(enabled: true,
                      hintText: "Message",
                      focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(15,),borderSide: const BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15,),borderSide: const BorderSide(color: Colors.grey))),
                ),
                SizedBox(height: h/100,),
                const Text("Amount (at least 500 CFA)",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                SizedBox(height: h/100,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter amount";
                    } else {
                      return null;
                    }
                  },
                  controller: amount,
                  cursorColor: Colors.black,keyboardType: TextInputType.number,
                  decoration: InputDecoration(enabled: true,
                      hintText: "Enter amount",
                      focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(15,),borderSide: const BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15,),borderSide: const BorderSide(color: Colors.grey))),
                ),
                SizedBox(height: h/100,),

                SizedBox(
                  height: h/10,width: w,
                  child:Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: ()async{
                        if(type == null){
                          Utils().sendMassage('please select name for diaplay');
                        }
                        if(type == "Yes, display another name"&& anothername.text.isEmpty){
                          Utils().sendMassage('please entre name for diaplay');
                        }

                        else if(valid.currentState!.validate()){
                          await gift.sendgift(
                              message.text.toString(),
                              type=="Yes, display my name"?
                              1:  type=="Yes, display another name"?
                              2:3,
                              anothername.text.toString(),
                              mobile.text.toString(),
                              amount.text.toString());

                          currentTab=4;
                          Get.offAll(const DashBoardScreen());
                        }

                      },
                      child: Container(decoration: BoxDecoration(color: logocolo,borderRadius: BorderRadius.circular(10)),
                        child: const Center(child: Text("Pay now",style: TextStyle(color: Colors.white,fontSize: 20),),),),
                    ),
                  ) ,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
