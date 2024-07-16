import 'package:flutter/material.dart';
import '../../ulits/constant.dart';


class Receives extends StatefulWidget {
  const Receives({super.key});

  @override
  State<Receives> createState() => _ReceivesState();
}

class _ReceivesState extends State<Receives> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          // forceMaterialTransparency: true,
          // centerTitle: true,
        backgroundColor: logocolo,
          title: const Center(
            child: Text(
              "My Wallet",
              style: TextStyle(
                  color: Colors.white ,
                  fontSize: 20,
                  fontFamily: "Ember"),
              textAlign: TextAlign.center,
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: h / 90,
              ),

              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  textAlign: TextAlign.start,
                  "Transaction history",
                  style:TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontFamily: "Amazon_med",
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),

              SizedBox(
                height: h / 90,
              ),

              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        // margin: const EdgeInsets.all(5) ,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10) ,
                        margin: const EdgeInsets.only(left: 5,right: 5, top: 5) ,
                        // padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
                            border: Border.all(
                                color: Colors.grey.shade300,
                                width: 2
                            )),
                        child: Row(
                          children: [
                            Text(
                              "Transaction ID: 10",
                              style: A_style_order_status,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const Spacer(),
                            Container(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFFd9e4f2),
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                                  child: Text(
                                    '600.00 CFA',
                                    style: A_style_order_status_blue,
                                    overflow: TextOverflow.ellipsis,
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
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10) ,
                        margin: const EdgeInsets.only(left: 5,right: 5, bottom: 5) ,
                        // padding: const EdgeInsets.only(left: 16,right: 16,bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
                            border: Border.all(
                                color: Colors.grey.shade300,
                                width: 2
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                Text(
                                  "Date : ",
                                  style: A_style_order_status,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const Spacer(),
                                Text(
                                  "11 Jan 2024 16:24",
                                  style: A_style_order_status,
                                  overflow: TextOverflow.ellipsis,
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
                                  "Transaction type : ",
                                  style: A_style_order_status,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const Spacer(),
                                Text(
                                  "Withdrawal",
                                  style: A_style_order_status,
                                  overflow: TextOverflow.ellipsis,
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
                                  "Order Status : ",
                                  style: A_style_order_status,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const Spacer(),
                                const Text(
                                  "Accepted",
                                  style: TextStyle(
                                      color: Colors.green,
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: "Amazon_med",
                                      fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}


