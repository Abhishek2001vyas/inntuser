import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/qrsannerafter.dart';

class Add_Friends extends StatefulWidget {

  const Add_Friends({super.key});

  @override
  State<Add_Friends> createState() => _Add_FriendsState();
}

class _Add_FriendsState extends State<Add_Friends> {
  final friendsdata=Get.put(Getdatafromqr_api());
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Add Friends"),),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:h/10 ,),
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage:NetworkImage("$image_url${friendsdata.profiledata[0]["data"]["user_profile"].toString()}"),
              ),
            ),
            SizedBox(height:h/40 ,),
            Center(
              child: Text("${friendsdata.profiledata[0]["data"]["first_name"].toString()}  ${friendsdata.profiledata[0]["data"]["last_name"].toString()} ",style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 15) ,)
            ),
            SizedBox(height:h/30 ,),
            ElevatedButton(
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(logocolo)),
                onPressed: ()async{
                await  friendsdata.addfriends();

                }, child: const Text("Add friend",style: TextStyle(color: Colors.white),))


          ],
        ),
      ),
    );
  }
}
