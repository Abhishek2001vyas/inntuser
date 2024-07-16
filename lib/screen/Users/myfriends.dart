import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api/getuserprofile.dart';
import '../../main.dart';
import '../../ulits/constant.dart';
import 'Navgationbar.dart';
import 'chatting.dart';

class My_friends extends StatefulWidget {
  const My_friends({super.key});

  @override
  State<My_friends> createState() => _My_friendsState();
}

class _My_friendsState extends State<My_friends> {

  final myfriendslist=Get.put(Getuserprofile_api());
  TextEditingController myfriendss= TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:   darkomdee.darkomde==true?
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
          "My Friends",
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: h / 20,
                width: w,
                child: TextFormField(controller:myfriendss ,
                  onChanged: (value) {
                    myfriendslist.searchmyfriends(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    hintText: "Search Friends",
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    fillColor: const Color(0xffeef1f5),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h / 90),

              Obx(() {
print("myfriendslist.myfriendsearchlisttt. ${myfriendslist.myfriendsearchlisttt.length}");
                return
                myfriendslist.myfriendsearchlisttt.isEmpty &&
                    myfriendss.text.isNotEmpty ?
                const Text("No Friends") :
                myfriendslist.myfriendsearchlisttt.isNotEmpty &&
                    myfriendss.text.isNotEmpty ?
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: myfriendslist.myfriendsearchlisttt.length,
                  itemBuilder: (context, index) {
                    var dataa = myfriendslist.myfriendsearchlisttt[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        children: [
                          ListTile(tileColor: darkomdee.darkomde==true?Colors.black:
                          Colors.white,
                            leading:
                            CircleAvatar(backgroundImage: NetworkImage(
                                "$image_url${dataa["friendId"]["user_profile"]}"),)
                            //Icon(CupertinoIcons.profile_circled,color: Colors.black,size: 30,),
                            ,
                            trailing: GestureDetector(
                              onTap: () {
                                Get.to(UserChat(
                                  status: 3,
                                  venderimage: dataa["friendId"]["user_profile"]
                                      .toString(),
                                  venderid: dataa["friendId"]["_id"].toString(),
                                  shopname: "${dataa["friendId"]["first_name"]} ${dataa["friendId"]["last_name"]}",
                                ));
                              },
                              child: Icon(
                                Icons.message_outlined,
                                color:  darkomdee.darkomde==true?Colors.white:
                                Colors.black,
                                size: 25,
                              ),
                            ),
                            title: Text("${dataa["friendId"]["first_name"]
                                .toString()} ${dataa["friendId"]["last_name"]
                                .toString()}"
                              ,style: TextStyle(color:  darkomdee.darkomde==true?Colors.white:Colors.black ),

                            ),
                          ),
                          Divider(color:    darkomdee.darkomde==true?
                          Colors.white: Colors.grey,)
                        ],
                      ),
                    );
                  },)
                    :
                myfriendss.text.isEmpty ?
                FutureBuilder(future: myfriendslist.myfriends(),
                  builder: (context, snapshot) {
                    return
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                        child: CircularProgressIndicator(
                            backgroundColor: logocolo),
                      )
                          :
                      snapshot.hasError == 'true'
                          ? const Center(
                        child: CircularProgressIndicator(
                            backgroundColor: logocolo),
                      )
                          :
                      Obx(() =>
                      myfriendslist.friendslist.isNotEmpty ?
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: myfriendslist.friendslist[0]["data"].length,
                        itemBuilder: (context, index) {
                          var dataa = myfriendslist
                              .friendslist[0]["data"][index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              children: [
                                ListTile(tileColor: darkomdee.darkomde==true?Colors.black:
                           Colors.white,
                                  leading:
                                  CircleAvatar(backgroundImage: NetworkImage(
                                      "$image_url${dataa["friendId"]["user_profile"]}"),)
                                  //Icon(CupertinoIcons.profile_circled,color: Colors.black,size: 30,),
                                  ,
                                  trailing: GestureDetector(
                                    onTap: () {
                                      Get.to(UserChat(
                                        status: 3,
                                        venderimage: dataa["friendId"]["user_profile"]
                                            .toString(),
                                        venderid: dataa["friendId"]["_id"]
                                            .toString(),
                                        shopname: "${dataa["friendId"]["first_name"]} ${dataa["friendId"]["last_name"]}",
                                      ));
                                    },
                                    child: Icon(
                                      Icons.message_outlined,
                                      color:
                                      darkomdee.darkomde==true?Colors.white:
                                      Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                  title: Text("${dataa["friendId"]["first_name"]
                                      .toString()} ${dataa["friendId"]["last_name"]
                                      .toString()}"
                                  ,style: TextStyle(color:  darkomdee.darkomde==true?Colors.white:Colors.black ),

                                  ),
                                ),
                                Divider(color:    darkomdee.darkomde==true?
                                Colors.white: Colors.grey,)
                              ],
                            ),
                          );
                        },) : const Text(" No friends"));
                  },)
                    : const SizedBox();
              }
              )
            ],
          ),
        ),
      ),
    );
  }
}
