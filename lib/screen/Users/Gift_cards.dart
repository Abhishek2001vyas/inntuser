import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/gift_api.dart';
import '../../ulits/utils.dart';
import 'Navgationbar.dart';
import 'Send_gift_card.dart';

class Giftcards extends StatefulWidget {
  const Giftcards({super.key});

  @override
  State<Giftcards> createState() => _GiftcardsState();
}

class _GiftcardsState extends State<Giftcards> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            "Gift Cards",
          ),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const TabBar(
                  labelStyle: TextStyle(fontSize: 20),
                  dividerColor: logocolo,
                  automaticIndicatorColorAdjustment: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: logocolo,
                  indicatorWeight: 3,
                  tabs: [
                    Tab(
                      child: Text("Received"),
                    ),
                    Tab(
                      child: Text("Sent"),
                    ),
                  ]),
              SizedBox(
                width: w,
                height: h / 1.1,
                child: TabBarView(children: [
                  receivedgift(w: w, h: h),
                  sentgift(w: w, h: h),
                ]),
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: h / 10,
          width: w,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                Get.to(const Sendgiftcard());
              },
              child: Container(
                decoration: BoxDecoration(
                    color: logocolo, borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "Send a gift card",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class sentgift extends StatelessWidget {
  sentgift({
    super.key,
    required this.w,
    required this.h,
  });

  final double w;
  final double h;

  final giftlist = Get.put(Gift_api());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 160),
      child: FutureBuilder(
        future: giftlist.sentgiftlist(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(color: logocolo),
                )
              : Obx(() => giftlist.sentgiftlistt.isEmpty
                  ? const Center(child: Text("No gift"))
                  : ListView.builder(
                      //physics: NeverScrollableScrollPhysics(), // Ensure no scrolling
                      itemCount: giftlist.sentgiftlistt[0]["data"].length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var dataa = giftlist.sentgiftlistt[0]["data"][index];
                        return SizedBox(
                          width: w,
                          height: h / 3.5,
                          child: Stack(
                            children: [
                              Image.asset(
                                "assets/images/WhatsApp Image 2024-04-11 at 16.28.24.jpeg",
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                  left: w / 12,
                                  top: h / 40,
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Sent to",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        " : ",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                      dataa["selectOne"].toString() == "1"
                                          ? Text(
                                              "${dataa["sender_userId"]["first_name"] ?? "N/A"} ${dataa["sender_userId"]["last_name"] ?? ""}",
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            )
                                          : dataa["selectOne"].toString() == "3"
                                              ? const Text(
                                                  "anonymous",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  "${dataa["name"] ?? "N/A"}",
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white),
                                                ),
                                    ],
                                  )),
                              Positioned(
                                  right: w / 12,
                                  top: h / 40,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${dataa["amount"] ?? ""}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        " CFA ",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                              // Positioned(
                              //     left: w/6,top: h/10,
                              //     child: Row(
                              //       children: [
                              //         Text("Code",style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),),
                              //         Text(" : ",style: TextStyle(fontSize: 17,color: Colors.white),),
                              //         Text("2223 6427 3453 3456",style: TextStyle(fontSize: 17,color: Colors.white),),
                              //
                              //
                              //       ],)),
                              // Positioned(
                              //     left: w / 17,
                              //     top: h / 10,
                              //     right: w / 60,
                              //     child: const Row(
                              //       children: [
                              //         Text(
                              //           "Message",
                              //           style: TextStyle(
                              //               fontSize: 17,
                              //               color: Colors.white,
                              //               fontWeight: FontWeight.bold),
                              //         ),
                              //         Text(
                              //           " : ",
                              //           style: TextStyle(
                              //               fontSize: 17, color: Colors.white),
                              //         ),
                              //       ],
                              //     )),

                              Positioned(
                                  left: w / 11,
                                  top: h / 10,
                                  right: w / 60,
                                  child: Row(
                                    children: [
                                      Container(
                                          // color: Colors.red,
                                          height: h / 7,
                                          width: w / 1.7,
                                          child: Text(
                                            "${dataa["message"] ?? ""}",
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ],
                                  )),
                              // Positioned(
                              //     left: w / 11,
                              //     top: h / 10,
                              //     right: w / 60,
                              //     child: Row(
                              //       children: [
                              //         Container(
                              //             // color: Colors.red,
                              //             height: h / 7,
                              //             width: w / 1.7,
                              //             child: Text(
                              //               "${dataa["message"] ?? ""}",
                              //               style: const TextStyle(
                              //                   fontSize: 17,
                              //                   color: Colors.white),
                              //               maxLines: 4,
                              //               overflow: TextOverflow.ellipsis,
                              //             )),
                              //       ],
                              //     )),

                              Positioned(
                                  left: w / 7,
                                  bottom: h / 50,
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Date",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        " : ",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                      Text(
                                        dataa["createdAt"]
                                                .toString()
                                                .substring(0, 10) ??
                                            "",
                                        style: const TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      },
                    ));
        },
      ),
    );
  }
}

class receivedgift extends StatelessWidget {
  receivedgift({
    super.key,
    required this.w,
    required this.h,
  });

  final double w;
  final double h;

  final giftlist = Get.put(Gift_api());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 160),
        child: FutureBuilder(
          future: giftlist.recivedgiftlist(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(color: logocolo),
                  )
                : Obx(
                    () => giftlist.recivedgiftlistt.isEmpty
                        ? const Center(child: Text("No gift"))
                        : ListView.builder(
                            //physics: NeverScrollableScrollPhysics(), // Ensure no scrolling
                            itemCount:
                                giftlist.recivedgiftlistt[0]["data"].length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var dataa =
                                  giftlist.recivedgiftlistt[0]["data"][index];
                              return SizedBox(
                                width: w,
                                height: h / 3.5,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      "assets/images/WhatsApp Image 2024-04-11 at 16.28.23.jpeg",
                                      fit: BoxFit.fill,
                                    ),
                                    Positioned(
                                        left: w / 12,
                                        top: h / 40,
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Sender",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              " : ",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                            dataa["selectOne"].toString() == "1"
                                                ? Text(
                                                    "${dataa["sender_userId"]["first_name"] ?? "N/A"} ${dataa["sender_userId"]["last_name"] ?? ""}",
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white),
                                                  )
                                                : dataa["selectOne"]
                                                            .toString() ==
                                                        "3"
                                                    ? const Text(
                                                        "anonymous",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : Text(
                                                        "${dataa["name"] ?? "N/A"}",
                                                        style: const TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                                Colors.white),
                                                      ),
                                          ],
                                        )),
                                    Positioned(
                                        right: w / 12,
                                        top: h / 40,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${dataa["amount"] ?? ""}",
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              " CFA ",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                    Positioned(
                                        left: w / 6,
                                        top: h / 10.5,
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Code",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              " : ",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "${dataa["card_no"] ?? ""}",
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )),

                                    Positioned(
                                        right: w / 8,
                                        top: h / 13,
                                        child: IconButton(
                                            onPressed: () {
                                              Clipboard.setData(ClipboardData(
                                                  text:
                                                      "${dataa["card_no"] ?? ""}"));
                                              Utils().sendMassage(
                                                  'Copy to Clipboard');
                                            },
                                            icon: const Icon(
                                              Icons.copy,
                                              color: Colors.white,
                                              size: 18,
                                            ))),
                                    // Positioned(
                                    //     left: w / 17,
                                    //     top: h / 7.5,
                                    //     right: w / 60,
                                    //     child: const Row(
                                    //       children: [
                                    //         Text(
                                    //           "Message",
                                    //           style: TextStyle(
                                    //               fontSize: 17,
                                    //               color: Colors.white,
                                    //               fontWeight: FontWeight.bold),
                                    //         ),
                                    //         Text(
                                    //           " : ",
                                    //           style: TextStyle(
                                    //               fontSize: 17,
                                    //               color: Colors.white),
                                    //         ),
                                    //       ],
                                    //     )),
                                    Positioned(
                                        left: w / 13,
                                        top: h / 7.5,
                                        right: w / 60,
                                        child: Row(
                                          children: [
                                            Container(
                                                // color: Colors.red,
                                                height: h / 11,
                                                width: w / 1.7,
                                                child: Text(
                                                  "${dataa["message"] ?? ""}",
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                          ],
                                        )),
                                    Positioned(
                                        left: w / 7,
                                        bottom: h / 70,
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Date",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              " : ",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              dataa["createdAt"]
                                                      .toString()
                                                      .substring(0, 10) ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              );
                            },
                          ),
                  );
          },
        ));
  }
}
