import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/Api/referralapi.dart';
import 'package:inntuser/ulits/constant.dart';

import 'Navgationbar.dart';

class Referralhistory extends StatefulWidget {
  const Referralhistory({super.key});

  @override
  State<Referralhistory> createState() => _ReferralhistoryState();
}

class _ReferralhistoryState extends State<Referralhistory> {
  final referrapi = Get.put(refer_api());
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
          "Referral history",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: h / 90),
              FutureBuilder(
                future: referrapi.referhistroy(),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(
                            color: logocolo,
                          ),
                        )
                      : referrapi.referlist.isEmpty
                          ? Center(child: Text("No history"))
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: referrapi.referlist[0]["data"].length,
                              itemBuilder: (context, index) {
                                var dataa =
                                    referrapi.referlist[0]["data"][index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                          CupertinoIcons.profile_circled,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        trailing: Container(
                                          decoration: BoxDecoration(
                                              color: logocolo,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              "${dataa["amount"]} CFA",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                            "${dataa["friendFirst_name"]} ${dataa["friendLast_name"]}"),
                                        subtitle: Text(
                                            "Joined on ${dataa["createdAt"].toString().substring(0, 10)}"),
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
