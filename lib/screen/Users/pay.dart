
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api/getuserprofile.dart';
import '../../Api/qrsannerafter.dart';
import '../../ulits/constant.dart';
import '../../ulits/utils.dart';


class Pay extends StatefulWidget {
  final qrcode;
  const Pay({super.key,required this.qrcode});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  final formKey = GlobalKey<FormState>();
  final friendsdata=Get.put(Getdatafromqr_api());
  final userqr =Get.put(Getuserprofile_api());

  TextEditingController amount =TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true,
        // forceMaterialTransparency: true,
        // automaticallyImplyLeading: false,
          backgroundColor: logocolo,
          title: const Text(
            "Pay",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Ember"),
            textAlign: TextAlign.center,
          ),
      ),

      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h/45,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:NetworkImage("$image_url${friendsdata.profiledata[0]["data"]["user_profile"].toString()}"),
                    ),
                    SizedBox(
                      width: w/20,
                    ),
                    Text(
                      textAlign: TextAlign.start,
                      "${friendsdata.profiledata[0]["data"]["first_name"].toString()}  ${friendsdata.profiledata[0]["data"]["last_name"].toString()} ",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: "Hey"),
                    ),
                  ],
                ),

                SizedBox(
                  height: h/50,
                ),
                Container(
                  width: w,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(width: 1,color: Colors.black)
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter amount";
                              } else {
                                return null;
                              }
                            },
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
                SizedBox(
                  height: h/45,
                ),
                const Text(
                  textAlign: TextAlign.start,
                  "My balance",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: "Hey"),
                ),
                SizedBox(
                  height: h/90,
                ),



                Theme(
                  data: Theme.of(context)
                      .copyWith(primaryColor: Colors.black,),
                  child:
                  Obx(() =>

                  TextFormField(autofocus: true,
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (amount.text.isNotEmpty && value!.isNotEmpty ) {
                        int.parse(amount.text.toString()) > double.parse(value.toString()) ?
                      friendsdata.erorr.value =true:null;
                        return null;
                      } else {
                        return null;
                      }
                    },
                    initialValue: friendsdata.profiledata1[0]["data"][0]['wallet'].toString() ??"00",
                    style: TextStyle(
                      color: friendsdata.erorr==true?Colors.red  :Colors.black
                    ),

                    cursorColor: Colors.black,readOnly: true,
                    obscureText: friendsdata.passwordObscured.value,obscuringCharacter:'*',
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(12),
                        filled: true,

                        fillColor: Colors.white,
                        // prefixStyle:
                        // prefixText: "CFA",
                        prefix: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text("CFA",style:  TextStyle(
                              color:  MaterialStateColor.resolveWith((states) =>
                              states.contains(MaterialState.focused)
                                  ? Colors.black
                                  : Colors.black),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              fontFamily: "Hey"),),
                        ),


                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color:  Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color:  friendsdata.erorr==true?Colors.red:Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              friendsdata.passwordObscured.value =   !friendsdata.passwordObscured.value;
                              // setState(() {
                              //   passwordObscured = !passwordObscured;
                              // });
                            },
                            icon: Icon(
                              friendsdata.passwordObscured.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            )),
                        hintText: "  Enter Amount"),
                  ),
                )),

                SizedBox(
                  height: h/30,
                ),
                Center(
                  child: Obx(() =>
                  friendsdata.erorr==true?
                  const Text("Your balance is insufficient",style: TextStyle(color: Colors.red),):const SizedBox(),
                  ),
                ),
                
                SizedBox(
                  height: h/5,
                ),
                

                InkWell(
                  onTap: ()async{
                    print("fffffff");
                    if(amount.text.isEmpty){
                      Utils().sendMassage('Please entre amount');
                    }

                    if(formKey.currentState!.validate()){
                     await friendsdata.sendMoney_request(amount.text,widget.qrcode);
                      print("ff");
                    }else{

                    }
                  },
                  child: Container(
                    width: w,
                    height: 50.0,
                    decoration: BoxDecoration(
                        color: amount.text.isNotEmpty? logocolo:Colors.grey,
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  
                    ),
                    child:
                    
                    const Center(
                      child: Text(
                        "Pay",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            fontFamily: "Hey"),
                      ),
                    ),
                  ),
                ),

            ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    friendsdata.erorr.value=false;
    // TODO: implement dispose
    super.dispose();
  }
}
