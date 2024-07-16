import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../main.dart';
import 'Navgationbar.dart';

class Socialfreinds extends StatefulWidget {
  const Socialfreinds({super.key});

  @override
  State<Socialfreinds> createState() => _SocialfreindsState();
}

class _SocialfreindsState extends State<Socialfreinds> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor:   darkomdee.darkomde==true?
    Colors.black:Colors.white,
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
          "Social Account",
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
    Column(
            children: [
    Container(

          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: Colors.grey),
             ),
          child:
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(decoration: BoxDecoration(color: logocolo,borderRadius: BorderRadius.circular(10)),
                      height:h/20,
                      width:w/ 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/imagess/facebook.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Flexible(flex: 20,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Facebook"),
                          Text("Connected",style: TextStyle(color: Colors.grey,fontSize: 15),),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Switch.adaptive(value: true,
                      onChanged: (value) {

                      },activeColor: logocolo,inactiveThumbColor: Colors.grey,

                    )
                  ],
                ),
              ),

              const Divider(color: Colors.grey),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10)),
                      height:h/20,
                      width:w/ 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/imagess/apple-logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Flexible(flex: 20,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Apple"),
                          Text("Connected",style: TextStyle(color: Colors.grey,fontSize: 15),),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Switch.adaptive(value: true,
                      onChanged: (value) {

                      },activeColor: logocolo,inactiveThumbColor: Colors.grey,

                    )
                  ],
                ),
              ),

              const Divider(color: Colors.grey,),



              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                      height:h/20,
                      width:w/ 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/imagess/search.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Flexible(flex: 20,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Google"),
                          Text("Connect",style: TextStyle(color: Colors.grey,fontSize: 15),),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Switch.adaptive(value: false,
                      onChanged: (value) {

                      },activeColor: logocolo,inactiveThumbColor: Colors.grey,

                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),


            /*  ListTile(shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey,width: 1.5)),
                leading:
                Container(decoration: BoxDecoration(color: logocolo,borderRadius: BorderRadius.circular(10)),
                  height:h/20,
                  width:w/ 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/imagess/facebook.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Facebook"),
                    Text("Connected",style: TextStyle(color: Colors.grey,fontSize: 15),),
                  ],
                ),
                trailing:
                Switch.adaptive(value: true,
                  onChanged: (value) {

                },activeColor: logocolo,inactiveThumbColor: Colors.grey,

                )


              ),*/
             /* ListTile(shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey,width: 1.5)),
                  leading:
                  Container(decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10)),
                    height:h/20,
                    width:w/ 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/imagess/apple-logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Apple"),
                      Text("Connected",style: TextStyle(color: Colors.grey,fontSize: 15),),
                    ],
                  ),
                  trailing: Switch.adaptive(value: true,
                    onChanged: (value) {

                    },activeColor: logocolo,inactiveThumbColor: Colors.grey,

                  )


              ),*/
             /* ListTile(shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.grey,width: 1.5,)),
                  leading:  Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                    height:h/20,
                    width:w/ 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/imagess/search.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Google"),
                      Text("Connect",style: TextStyle(color: Colors.grey,fontSize: 15),),
                    ],
                  ),
                  trailing: Switch.adaptive(value: false,
                    onChanged: (value) {

                    },activeColor: logocolo,inactiveThumbColor: Colors.grey,

                  )


              )*/
            ],
          ),
      )),

    );
  }
}
