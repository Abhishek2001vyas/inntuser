import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api/meassage_api.dart';
import '../../main.dart';
import '../../models/chatlistt.dart';
import '../../ulits/constant.dart';
import 'chatting.dart';


class Searchfriends extends StatefulWidget {
  const Searchfriends({super.key});

  @override
  State<Searchfriends> createState() => _SearchfriendsState();
}

class _SearchfriendsState extends State<Searchfriends> {
  final chat_api = Get.put(meassage_api());
  List <FinalMurged>searchf=[];
  bool ss=false;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor: darkomdee.darkomde==true?Colors.black:Colors.white,
      appBar: AppBar(title:         SizedBox(
        height: h / 25,
        width: w / 1.41,
        child: TextFormField(
          onChanged: (value) {

            setState(() {
              ss=true;

            });
            searchf.clear();
            for(int i=0;i<chat_api.chatlistlist[0].finalMurged!.length;i++){
              var dataa=chat_api.chatlistlist[0].finalMurged![i];
              var searchtext =value.toLowerCase();
              print("ff $searchtext  ${dataa.fname}");
              final shopName = dataa.shopName?.toLowerCase() ?? '';
            if(
            shopName.contains(searchtext)||
            dataa.fname!.toLowerCase().contains(searchtext) || dataa.lname!.toLowerCase().contains(searchtext)
            ){
              searchf.add(dataa);
              print("hjkhkjhngdv ${searchf[0].fname}");
            }
            // where((chatItem) {
            //     final fname = chatItem.fname.toLowerCase();
            //     final lname = chatItem.lname.toLowerCase();
            //     final shopName = chatItem.shopName?.toLowerCase() ?? '';
            //     return fname.contains(query) || lname.contains(query) || shopName.contains(query);
            //   }).toList();
            }
          },
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              hintText: "Search in chats",
              prefixIcon:
              const Icon(Icons.search, color: Colors.black),
              fillColor: const Color(0xffeef1f5),
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(7))),
        ),
      ),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              searchf.isEmpty?
                  const Center(child: Text("No Chats")):

              ListView.builder(
                shrinkWrap: true,
                itemCount: searchf.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(UserChat(
                          status: searchf.elementAt(index).shopName!=null? 1:3,
                          venderimage: searchf.elementAt(index).image!.toString(),
                          venderid:searchf.elementAt(index).iD.toString(),
                          shopname:searchf.elementAt(index).shopName ?? "${searchf.elementAt(index).fname} ${searchf.elementAt(index).lname}",
                        ));
                      },
                      child: Material(
                        color: Colors.white,
                        elevation: 1,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: darkomdee.darkomde==true?Colors.black:Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: logocolo,radius: 25,
                                backgroundImage:NetworkImage(  "$image_url${searchf.elementAt(index).image!.toString()}") ,),


                              SizedBox(
                                width: w / 50,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   height: h / 100,
                                    // ),
                                    SizedBox(
                                      width: w / 1.8,
                                      child: Text(
                                          searchf.elementAt(index).shopName ?? "${searchf.elementAt(index).fname} ${searchf.elementAt(index).lname}",
                                          maxLines: 1,
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w500,
                                              color:
                                              darkomdee.darkomde==true?
                                              Colors.white:
                                              Colors.black,
                                              fontFamily: "Amazon_med",
                                              fontSize: 16)),
                                    ),
                                    SizedBox(
                                      width: w / 1.8,
                                      child: Text(
                                        searchf.elementAt(index).text!.toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                          //letterSpacing: 1.5,
                                          //color: Colors.white,
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.grey.shade700,
                                            fontFamily: "Amazon_med",
                                            fontSize: 14),
                                      ),
                                    ),
                                  ]),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(
                                  //   height: h / 100,
                                  // ),
                                  Text(
                                    searchf.elementAt(index).createdAt!.toString().substring(11,16),
                                    style: TextStyle(
                                      fontSize: 13,color: darkomdee.darkomde==true?Colors.white:Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Ember_Light",
                                    ),
                                  ),
                                 searchf.elementAt(index).msgCount!.toString()=="0"?
                                  const SizedBox()
                                      :
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                        color: logocolo,
                                        shape: BoxShape.circle),
                                    child:  Text(
                                      searchf.elementAt(index).msgCount!.toString(),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Ember_Light",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          
          ),
        ),
      ),
    );
  }
}
