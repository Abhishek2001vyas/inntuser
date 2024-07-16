import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/account_delete.dart';
import '../../ulits/utils.dart';

class Accountdeletionquestion extends StatefulWidget {
  const Accountdeletionquestion({super.key});

  @override
  State<Accountdeletionquestion> createState() =>
      _AccountdeletionquestionState();
}

class _AccountdeletionquestionState extends State<Accountdeletionquestion> {
  final accounttdelete=Get.put(account_deletee());
  TextEditingController text =TextEditingController();
  var reason;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Account deletion"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              RichText(
                  maxLines: 2,
                  text: const TextSpan(children: [
                    TextSpan(
                      text:
                          "Please let us know the reasons you are deleting your account",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: " *",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    )
                  ])),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: title.length,
                itemBuilder: (context, index) {
                return
                  buildCheckboxListTile(
                    title[index],
                   index
                  );
              },),

              choose==6?
                  Padding(
                    padding:  EdgeInsets.only(left: w/20.0,bottom: h/50),
                    child: TextFormField(
                      maxLines: null,
                      controller: text,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(

                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),

                    ),
                  ):SizedBox(),


              Container(
                  width: w,
                  height: h / 15,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.red)),
                      onPressed: () async{
                        if(reason !=null) {
                          await accounttdelete.account_delettee(
                              text.text.toString(), reason, context);
                        }
                        else{
                          Utils().sendMassage("Please entre reason");
                        }

                        },
                      child: Text(
                        "Proceed and delete",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )))
            ],
          ),
        ),
      ),
    );
  }



  CheckboxListTile buildCheckboxListTile(title,index) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(title,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
      value: index==choose? true:false,
      activeColor: logocolo,
      onChanged: (value) {
        setState(() {
        choose=index;
        reason=title;
        });
      },
    );
  }

  List title=[
    "Privacy concerns",
    "Too many notifications",
    "Better prices elsewhere",
    "I do not use it quite often",
    "I found a better platform",
    "Personal reasons",
    "Other",
  ];

  var choose;
}




