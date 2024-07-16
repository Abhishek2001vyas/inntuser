import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:intl/intl.dart';

import '../../Api/meassage_api.dart';
import '../../main.dart';
import 'chatsearch.dart';
import 'chatting.dart';
import 'myfriends.dart';

class Chatall extends StatefulWidget {
  const Chatall({super.key});

  @override
  State<Chatall> createState() => _ChatallState();
}

class _ChatallState extends State<Chatall> {
  var filterchat = 0;
  String selectedBagItem = 'Delete item';
  final chat_api = Get.put(meassage_api());
  var order1 = ["All", "Friends"];
  bool isSameDate = false;
  var newDate;
  var datematch;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            const Center(child: Text("Chats")),
            SizedBox(
              height: h / 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: h / 25,
                  width: w / 1.41,
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      Get.to(const Searchfriends());
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
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      filterchat = 1;
                    });
                  },
                  icon: const Icon(Icons.filter_list_outlined),
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(const My_friends());
                    },
                    child: const Icon(Icons.add)),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: filterchat == 1
              ? Column(
                  children: [
                    FutureBuilder(
                      future: chat_api.chatlist(),
                      builder: (context, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const Center(
                                child:
                                    CircularProgressIndicator(color: logocolo),
                              )
                            : Obx(() => chat_api.chatlistlist.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 50.0),
                                    child: Center(child: Text("No Messages")),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Filter : ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    darkomdee.darkomde == true
                                                        ? Colors.white
                                                        : black),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                filterchat = 0;
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: logocolo,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: logocolo)),
                                              padding: const EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    "Unread meassage",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: w / 50,
                                                  ),
                                                  const Icon(
                                                    CupertinoIcons.xmark,
                                                    color: Colors.white,
                                                    size: 15,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: h / 100,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 4.0, left: 4, top: 4),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: chat_api.chatlistlist
                                              .elementAt(0)
                                              .finalMurged!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return chat_api.chatlistlist
                                                        .elementAt(0)
                                                        .finalMurged!
                                                        .elementAt(index)
                                                        .msgCount!
                                                        .toString() ==
                                                    "0"
                                                ? const SizedBox()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.to(UserChat(
                                                          status: chat_api
                                                                      .chatlistlist
                                                                      .elementAt(
                                                                          0)
                                                                      .finalMurged!
                                                                      .elementAt(
                                                                          index)
                                                                      .shopName !=
                                                                  null
                                                              ? 1
                                                              : 3,
                                                          venderimage: chat_api
                                                              .chatlistlist
                                                              .elementAt(0)
                                                              .finalMurged!
                                                              .elementAt(index)
                                                              .image!
                                                              .toString(),
                                                          venderid: chat_api
                                                              .chatlistlist
                                                              .elementAt(0)
                                                              .finalMurged!
                                                              .elementAt(index)
                                                              .iD
                                                              .toString(),
                                                          shopname: chat_api
                                                                  .chatlistlist
                                                                  .elementAt(0)
                                                                  .finalMurged!
                                                                  .elementAt(
                                                                      index)
                                                                  .shopName ??
                                                              "${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).fname} ${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).lname}",
                                                        ));
                                                      },
                                                      child: Material(
                                                        color: Colors.white,
                                                        elevation: 1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: darkomdee
                                                                        .darkomde ==
                                                                    true
                                                                ? Colors.black
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    logocolo,
                                                                radius: 25,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        "$image_url${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).image!.toString()}"),
                                                              ),
                                                              SizedBox(
                                                                width: w / 50,
                                                              ),
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: w /
                                                                          1.8,
                                                                      child: Text(
                                                                          chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).shopName ??
                                                                              "${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).fname} ${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).lname}",
                                                                          maxLines:
                                                                              1,
                                                                          style: TextStyle(
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: darkomdee.darkomde == true ? Colors.white : Colors.black,
                                                                              fontFamily: "Amazon_med",
                                                                              fontSize: 16)),
                                                                    ),
                                                                    SizedBox(
                                                                      width: w /
                                                                          1.8,
                                                                      child:
                                                                          Text(
                                                                        chat_api
                                                                            .chatlistlist
                                                                            .elementAt(0)
                                                                            .finalMurged!
                                                                            .elementAt(index)
                                                                            .text!
                                                                            .toString(),
                                                                        maxLines:
                                                                            1,
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
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // SizedBox(
                                                                  //   height: h / 100,
                                                                  // ),
                                                                  Text(
                                                                    chat_api
                                                                        .chatlistlist
                                                                        .elementAt(
                                                                            0)
                                                                        .finalMurged!
                                                                        .elementAt(
                                                                            index)
                                                                        .createdAt!
                                                                        .toString()
                                                                        .substring(
                                                                            11,
                                                                            16),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: darkomdee.darkomde ==
                                                                              true
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          "Ember_Light",
                                                                    ),
                                                                  ),
                                                                  chat_api.chatlistlist
                                                                              .elementAt(0)
                                                                              .finalMurged!
                                                                              .elementAt(index)
                                                                              .msgCount!
                                                                              .toString() ==
                                                                          "0"
                                                                      ? const SizedBox()
                                                                      : Container(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              4),
                                                                          decoration: const BoxDecoration(
                                                                              color: logocolo,
                                                                              shape: BoxShape.circle),
                                                                          child:
                                                                              Text(
                                                                            chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).msgCount!.toString(),
                                                                            style:
                                                                                const TextStyle(
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
                                      ),
                                    ],
                                  ));
                      },
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: h / 16,
                      child: ListView.builder(
                          itemCount: 2,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(() => GestureDetector(
                                  onTap: () {
                                    chat_api.changee.value = index;
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: w / 5,
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: chat_api.changee == index
                                            ? logocolo
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 3,
                                          )
                                        ]),
                                    child: Center(
                                      child: Text(
                                        order1[index].toString(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ));
                          }),
                    ),
                    // Obx(() =>
                    chat_api.changee == 0
                        ? StreamBuilder(
                            stream: Stream.periodic(const Duration(
                              milliseconds: 0,
                            )).asyncMap((i) => chat_api.chatlist()),
                            // FutureBuilder(
                            //     future: chat_api.chatlist(),
                            builder: (context, snapshot) {
                              return snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: logocolo),
                                    )
                                  : Obx(() => chat_api.chatlistlist.isEmpty
                                      ? const Padding(
                                          padding: EdgeInsets.only(top: 50.0),
                                          child: Center(
                                              child: Text("No Messages")),
                                        )
                                      : Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0, left: 4, top: 4),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: chat_api.chatlistlist
                                                    .elementAt(0)
                                                    .finalMurged!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  //---------------------------------------Date Time -------------------------------------//

                                                  var dt = chat_api.chatlistlist
                                                      .elementAt(0)
                                                      .finalMurged![index]
                                                      .createdAt
                                                      .toString()
                                                      .substring(0, 10);

                                                  // if (datematch.toString() !=
                                                  //     dt
                                                  //         .toString()
                                                  //         .substring(0, 10)) {
                                                  //   if (dt
                                                  //           .toString()
                                                  //           .substring(0, 10) ==
                                                  //       DateTime.now()
                                                  //           .toString()
                                                  //           .substring(0, 10)) {
                                                  //     newDate = chat_api
                                                  //         .chatlistlist
                                                  //         .elementAt(0)
                                                  //         .finalMurged![index]
                                                  //         .createdAt
                                                  //         .toString()
                                                  //         .substring(11, 16);
                                                  //     datematch = dt
                                                  //         .toString()
                                                  //         .substring(0, 10);
                                                  //     isSameDate = false;
                                                  //   } else if (dt
                                                  //           .toString()
                                                  //           .substring(0, 10) ==
                                                  //       DateTime.now()
                                                  //           .subtract(Duration(
                                                  //               days: 1))
                                                  //           .toString()
                                                  //           .substring(0, 10)) {
                                                  //     newDate = "yesterday ";
                                                  //     datematch = dt
                                                  //         .toString()
                                                  //         .substring(0, 10);
                                                  //     isSameDate = false;
                                                  //   } else {
                                                  //     newDate = dt
                                                  //         .toString()
                                                  //         .substring(0, 10);
                                                  //     datematch = dt
                                                  //         .toString()
                                                  //         .substring(0, 10);
                                                  //     isSameDate = false;
                                                  //   }
                                                  //   print(
                                                  //       "nodd  ${datematch} ${dt.toString().substring(0, 10)}  ");
                                                  // } else {
                                                  //   print("yes ${datematch}");
                                                  //   isSameDate = true;
                                                  // }

                                                  //---------------------------------------Date Time -------------------------------------//

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        chat_api
                                                            .uservenderchatlist
                                                            .clear();

                                                        Get.to(UserChat(
                                                          status: chat_api
                                                                      .chatlistlist
                                                                      .elementAt(
                                                                          0)
                                                                      .finalMurged!
                                                                      .elementAt(
                                                                          index)
                                                                      .shopName !=
                                                                  null
                                                              ? 1
                                                              : 3,
                                                          venderimage: chat_api
                                                              .chatlistlist
                                                              .elementAt(0)
                                                              .finalMurged!
                                                              .elementAt(index)
                                                              .image!
                                                              .toString(),
                                                          venderid: chat_api
                                                              .chatlistlist
                                                              .elementAt(0)
                                                              .finalMurged!
                                                              .elementAt(index)
                                                              .iD
                                                              .toString(),
                                                          shopname: chat_api
                                                                  .chatlistlist
                                                                  .elementAt(0)
                                                                  .finalMurged!
                                                                  .elementAt(
                                                                      index)
                                                                  .shopName ??
                                                              "${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).fname} ${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).lname}",
                                                        ));
                                                      },
                                                      child: Material(
                                                        color: Colors.white,
                                                        elevation: 1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: darkomdee
                                                                        .darkomde ==
                                                                    true
                                                                ? Colors.black
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    logocolo,
                                                                radius: 25,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        "$image_url${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).image!.toString()}"),
                                                              ),
                                                              SizedBox(
                                                                width: w / 50,
                                                              ),
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          w / 2,
                                                                      child: Text(
                                                                          chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).shopName ??
                                                                              "${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).fname} ${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).lname}",
                                                                          maxLines:
                                                                              1,
                                                                          style: TextStyle(
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: darkomdee.darkomde == true ? Colors.white : Colors.black,
                                                                              fontFamily: "Amazon_med",
                                                                              fontSize: 16)),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          w / 2,
                                                                      child:
                                                                          Text(
                                                                        chat_api
                                                                            .chatlistlist
                                                                            .elementAt(0)
                                                                            .finalMurged!
                                                                            .elementAt(index)
                                                                            .text!
                                                                            .toString(),
                                                                        maxLines:
                                                                            1,
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
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).createdAt!.toString().substring(0, 10) ==
                                                                              DateTime.now().toString().substring(0, 10)
                                                                          ? "${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).createdAt!.toString().substring(11, 16)}"
                                                                          : chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).createdAt!.toString().substring(0, 10) == DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 10)
                                                                              ? "yesterday "
                                                                              //"${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).createdAt!.toString().substring(11, 16)}"
                                                                              : "${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).createdAt!.toString().substring(0, 10)} ",
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontFamily:
                                                                            "Ember_Light",
                                                                      )),
                                                                  // Text(
                                                                  //   chat_api
                                                                  //       .chatlistlist
                                                                  //       .elementAt(
                                                                  //           0)
                                                                  //       .finalMurged!
                                                                  //       .elementAt(
                                                                  //           index)
                                                                  //       .createdAt!
                                                                  //       .toString()
                                                                  //       .substring(
                                                                  //           11,
                                                                  //           16),
                                                                  //   style:
                                                                  //       TextStyle(
                                                                  //     fontSize:
                                                                  //         13,
                                                                  //     color: darkomdee.darkomde ==
                                                                  //             true
                                                                  //         ? Colors
                                                                  //             .white
                                                                  //         : Colors
                                                                  //             .black,
                                                                  //     fontWeight:
                                                                  //         FontWeight
                                                                  //             .w500,
                                                                  //     fontFamily:
                                                                  //         "Ember_Light",
                                                                  //   ),
                                                                  // ),
                                                                  chat_api.chatlistlist
                                                                              .elementAt(0)
                                                                              .finalMurged!
                                                                              .elementAt(index)
                                                                              .msgCount!
                                                                              .toString() ==
                                                                          "0"
                                                                      ? const SizedBox()
                                                                      : Container(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              4),
                                                                          decoration: const BoxDecoration(
                                                                              color: logocolo,
                                                                              shape: BoxShape.circle),
                                                                          child:
                                                                              Text(
                                                                            chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).msgCount!.toString(),
                                                                            style:
                                                                                const TextStyle(
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
                                            ),
                                          ],
                                        ));
                            },
                          )
                        : FutureBuilder(
                            future: chat_api.chatlistfriends(),
                            builder: (context, snapshot) {
                              return snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: logocolo),
                                    )
                                  : Obx(() => chat_api.chatlistlistttt.isEmpty
                                      ? const Padding(
                                          padding: EdgeInsets.only(top: 50.0),
                                          child: Center(
                                              child: Text("No Messages")),
                                        )
                                      : Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0, left: 4, top: 4),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: chat_api
                                                    .chatlistlistttt
                                                    .elementAt(0)
                                                    .filteredMessages!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.to(UserChat(
                                                          status: 3,
                                                          venderimage: chat_api
                                                              .chatlistlistttt
                                                              .elementAt(0)
                                                              .filteredMessages!
                                                              .elementAt(index)
                                                              .image!
                                                              .toString(),
                                                          venderid: chat_api
                                                              .chatlistlistttt
                                                              .elementAt(0)
                                                              .filteredMessages!
                                                              .elementAt(index)
                                                              .friendId
                                                              .toString(),
                                                          shopname:
                                                              "${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).fname} ${chat_api.chatlistlistttt.elementAt(0).filteredMessages!.elementAt(index).lname}",
                                                        ));
                                                      },
                                                      child: Material(
                                                        color: Colors.white,
                                                        elevation: 1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: darkomdee
                                                                        .darkomde ==
                                                                    true
                                                                ? Colors.black
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    logocolo,
                                                                radius: 25,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        "$image_url${chat_api.chatlistlistttt.elementAt(0).filteredMessages!.elementAt(index).image!.toString()}"),
                                                              ),
                                                              SizedBox(
                                                                width: w / 50,
                                                              ),
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    // SizedBox(
                                                                    //   height: h / 100,
                                                                    // ),
                                                                    SizedBox(
                                                                      width: w /
                                                                          1.8,
                                                                      child: Text(
                                                                          "${chat_api.chatlistlistttt.elementAt(0).filteredMessages!.elementAt(index).fname} ${chat_api.chatlistlist.elementAt(0).finalMurged!.elementAt(index).lname}",
                                                                          maxLines:
                                                                              1,
                                                                          style: TextStyle(
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: darkomdee.darkomde == true ? Colors.white : Colors.black,
                                                                              fontFamily: "Amazon_med",
                                                                              fontSize: 16)),
                                                                    ),
                                                                    SizedBox(
                                                                      width: w /
                                                                          1.8,
                                                                      child:
                                                                          Text(
                                                                        chat_api
                                                                            .chatlistlistttt
                                                                            .elementAt(0)
                                                                            .filteredMessages!
                                                                            .elementAt(index)
                                                                            .text!
                                                                            .toString(),
                                                                        maxLines:
                                                                            1,
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
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // SizedBox(
                                                                  //   height: h / 100,
                                                                  // ),
                                                                  Text(
                                                                    chat_api
                                                                        .chatlistlistttt
                                                                        .elementAt(
                                                                            0)
                                                                        .filteredMessages!
                                                                        .elementAt(
                                                                            index)
                                                                        .createdAt!
                                                                        .toString()
                                                                        .substring(
                                                                            11,
                                                                            16),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: darkomdee.darkomde ==
                                                                              true
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          "Ember_Light",
                                                                    ),
                                                                  ),
                                                                  chat_api.chatlistlistttt
                                                                              .elementAt(0)
                                                                              .filteredMessages!
                                                                              .elementAt(index)
                                                                              .msgCount!
                                                                              .toString() ==
                                                                          "0"
                                                                      ? const SizedBox()
                                                                      : Container(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              4),
                                                                          decoration: const BoxDecoration(
                                                                              color: logocolo,
                                                                              shape: BoxShape.circle),
                                                                          child:
                                                                              Text(
                                                                            chat_api.chatlistlistttt.elementAt(0).filteredMessages!.elementAt(index).msgCount!.toString(),
                                                                            style:
                                                                                const TextStyle(
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
                                            ),
                                          ],
                                        ));
                            },
                          ),
                    // )
                  ],
                ),
        ),
      ),
    );
  }

  // function to convert time stamp to date
  static DateTime returnDateAndTimeFormat(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    var originalDate = DateFormat('MM/dd/yyyy').format(dt);
    return DateTime(dt.year, dt.month, dt.day);
  }

  //function to return message time in 24 hours format AM/PM
  static String messageTime(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    String difference = '';
    difference = DateFormat('jm').format(dt).toString();
    return difference;
  }

  // function to return date if date changes based on your local date and time
  static String groupMessageDateAndTime(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    var originalDate = DateFormat('MM/dd/yyyy').format(dt);

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    String difference = '';
    final aDate = DateTime(dt.year, dt.month, dt.day);

    if (aDate == today) {
      difference = "Today";
    } else if (aDate == yesterday) {
      difference = "Yesterday";
    } else {
      difference = DateFormat.yMMMd().format(dt).toString();
    }

    return difference;
  }
}
