import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/scan_screen.dart';
import 'package:inntuser/screen/Users/topup.dart';
import 'package:inntuser/screen/Users/trasferwallet.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/getuserprofile.dart';
import '../../Api/walletapi.dart';
import '../../main.dart';
import 'Receive.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

//
// String _selectedWeek = 'This week';
// final List<String> _dropdownWeek = [
//   'This week',
//   'This week 1',
// ];
// String _selectedFrom = 'From';
// final List<String> _dropdownFrom = ['From', "From 1"];
// String _selectedTo = 'To';
// final List<String> _dropdownTo = [
//   'To',
//   'To 1',
// ];
final balance = Get.put(Getuserprofile_api());
final wallet = Get.put(wallet_api());

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.mywallet,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Stack(children: [
              Column(
                children: [
                  Container(
                    width: w,
                    height: h / 4,
                    // margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: logocolo,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              // border:
                              //     Border.all(color: Colors.white, width: 2)
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.balance,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Ember_Display_Medium",
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                  color: darkomdee.darkomde == true
                                      ? Colors.white
                                      : Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h / 70,
                        ),
                        Center(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.white, width: 1)),
                              child: FutureBuilder(
                                future: balance.userprofile(),
                                builder: (context, snapshot) {
                                  return snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                              backgroundColor: logocolo),
                                        )
                                      : snapshot.hasError == 'true'
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                  backgroundColor: logocolo),
                                            )
                                          : Obx(
                                              () => balance.profiledata.isEmpty
                                                  ? const Text("0.0")
                                                  : Text(
                                                      "${balance.profiledata[0][0]['wallet'].toStringAsFixed(2)} CFA",
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "Ember_Display_Medium",
                                                          fontSize: 25,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ));
                                },
                              )),
                        ),
                        SizedBox(
                          height: h / 50,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: h / 40,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: h / 40,
                  ),
                ],
              ),
              Positioned(
                  left: w / 46,
                  right: w / 46,
                  bottom: h / 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(const Topup());
                        },
                        child: Container(
                            width: w / 6,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/top_up.png",
                                  height: h / 30,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.topup,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      //letterSpacing: 1.5,
                                      //color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontFamily: "Amazon_med",
                                      fontSize: 12),
                                )
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const Trasferwallet());
                        },
                        child: Container(
                            width: w / 6,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/trasaction.png",
                                  height: h / 30,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.transfer,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      //letterSpacing: 1.5,
                                      //color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontFamily: "Amazon_med",
                                      fontSize: 12),
                                )
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ScanScreen());
                        },
                        child: Container(
                            width: w / 6,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/cam1.png",
                                  height: h / 30,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.scan,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      //letterSpacing: 1.5,
                                      //color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontFamily: "Amazon_med",
                                      fontSize: 12),
                                )
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const MyQrReceive());
                        },
                        child: Container(
                            width: w / 6,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  color: Colors.black,
                                  size: h / 30,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.receive,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      //letterSpacing: 1.5,
                                      //color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontFamily: "Amazon_med",
                                      fontSize: 12),
                                )
                              ],
                            )),
                      ),
                      /*  Container(
                          width: w / 6,
                          margin: EdgeInsets.all(3),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black)),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/wallet_check.png",
                                height: h / 30,
                                color: Colors.black,
                              ),
                              Text(
                                "My Cards",
                                maxLines: 1,
                                style: A_style_medium1,
                              )
                            ],
                          )),*/
                    ],
                  )),
            ]),
            SizedBox(
              height: h / 90,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.start,
                AppLocalizations.of(context)!.transactionhistory,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: darkomdee.darkomde == true
                        ? Colors.white
                        : Colors.black,
                    fontFamily: "Amazon_med",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: h / 90,
            ),
            FutureBuilder(
              future: wallet.transjection_history(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(
                            backgroundColor: logocolo),
                      )
                    : snapshot.hasError == 'true'
                        ? const Center(
                            child: CircularProgressIndicator(
                                backgroundColor: logocolo),
                          )
                        : Obx(() => wallet.transjectionlist.isEmpty
                            ? const Text("No histroy")
                            : ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    wallet.transjectionlist[0]["data"].length,
                                itemBuilder: (BuildContext context, int index) {
                                  var dataa =
                                      wallet.transjectionlist[0]["data"][index];
                                  return Column(
                                    children: [
                                      Container(
                                        // margin: const EdgeInsets.all(5) ,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 5, top: 5),
                                        // padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
                                        decoration: BoxDecoration(
                                            color: darkomdee.darkomde == true
                                                ? Colors.black
                                                : Colors.white,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    topRight:
                                                        Radius.circular(5.0)),
                                            border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: 2)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${AppLocalizations.of(context)!.transactionid} ${dataa["transjectionId"]}",
                                                style: TextStyle(
                                                    color: darkomdee.darkomde ==
                                                            true
                                                        ? Colors.white
                                                        : Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                              ),
                                            ),
                                            Container(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFd9e4f2),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              15.0)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 3.0),
                                                  child: Text(
                                                    '${dataa["amount"]} CFA',
                                                    style:
                                                        A_style_order_status_blue,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 5, bottom: 5),
                                        // padding: const EdgeInsets.only(left: 16,right: 16,bottom: 10),
                                        decoration: BoxDecoration(
                                            color: darkomdee.darkomde == true
                                                ? Colors.black
                                                : Colors.white,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0)),
                                            border: Border.all(
                                                color:
                                                    darkomdee.darkomde == true
                                                        ? Colors.white
                                                        : Colors.grey.shade500,
                                                width: 2)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Date : ",
                                                  style: TextStyle(
                                                      color:
                                                          darkomdee.darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "${dataa["createdAt"].toString().substring(0, 10)} ${dataa["createdAt"].toString().substring(11, 16)}",
                                                  style: TextStyle(
                                                      color:
                                                          darkomdee.darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: h / 120,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .transactiontype,
                                                  style: TextStyle(
                                                      color:
                                                          darkomdee.darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  dataa["payment_status"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color:
                                                          darkomdee.darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: h / 120,
                                            ),
                                            dataa["payment_type"] == "Cashback"
                                                ? const SizedBox()
                                                : Row(
                                                    children: [
                                                      Text(
                                                        "Recipient : ",
                                                        style: TextStyle(
                                                            color: darkomdee
                                                                        .darkomde ==
                                                                    true
                                                                ? Colors.white
                                                                : Colors.black),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                      const Spacer(),
                                                      dataa["payment_type"]
                                                                  .toString() !=
                                                              "Received"
                                                          ? Text(
                                                              "${dataa["receiverId"]["first_name"].toString()} ${dataa["receiverId"]["last_name"].toString()}",
                                                              style: TextStyle(
                                                                  color: darkomdee
                                                                              .darkomde ==
                                                                          true
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                            )
                                                          : Text(
                                                              "${dataa["userId"]["first_name"].toString()} ${dataa["userId"]["last_name"].toString()}",
                                                              style: TextStyle(
                                                                  color: darkomdee
                                                                              .darkomde ==
                                                                          true
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                            ),
                                                    ],
                                                  ),
                                            SizedBox(
                                              height: h / 120,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .sendagiftcard,
                                                  style: TextStyle(
                                                      color:
                                                          darkomdee.darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  dataa["payment_type"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color:
                                                          darkomdee.darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ));
              },
            )
          ],
        ),
      ),
    );
  }
}
