import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api/suggestion.dart';
import '../../ulits/constant.dart';
import '../../ulits/utils.dart';
import 'Navgationbar.dart';

class Improvement extends StatefulWidget {
  const Improvement({super.key});

  @override
  State<Improvement> createState() => _ImprovementState();
}

class _ImprovementState extends State<Improvement> {

  final suugestionn=Get.put(suggestionapi());
  TextEditingController suggestions =TextEditingController();
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
          "Improvement suggestions",
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Text("Thank you for sharing your ideas with us!",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)),
              SizedBox(height: h/50,),
              Center(child: Image.asset("assets/images/improvement.png",scale: 3,)),
              SizedBox(height: h/50,),
              const Text("Please write you suggestions below",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
              SizedBox(height: h/50,),
              TextFormField(
                controller: suggestions,
                cursorColor: Colors.black,maxLines: null,minLines: 5,keyboardType: TextInputType.multiline,
                decoration: InputDecoration(enabled: true,
                    hintText: "Type here…",
                    focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(15,),borderSide: const BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15,),borderSide: const BorderSide(color: Colors.grey))),
              ),
              SizedBox(height: h/50,),

            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: h/8,width: w,
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: ()async{
              if(suggestions.text.isEmpty){
                Utils().sendMassage('Please entre suggestion');
              }
              else {
                await suugestionn.suggestion_api(suggestions.text.toString(),context);
              }
            },
            child: Container(decoration: BoxDecoration(color: logocolo,borderRadius: BorderRadius.circular(10)),
              child: const Center(child: Text("Send",style: TextStyle(color: Colors.white,fontSize: 20),),),),
          ),
        ) ,
      ),
    );
  }
}
