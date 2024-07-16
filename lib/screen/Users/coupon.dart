import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Api/coupen.dart';

class Coupon extends StatefulWidget {
  const Coupon({super.key});

  @override
  State<Coupon> createState() => _CouponState();
}

class _CouponState extends State<Coupon> {

final coupen =Get.put(coupenn());
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          AppLocalizations.of(context)!.coupon,
        ),
        // actions: [
        //   Icon(Icons.search),
        //   Icon(Icons.grid_view_rounded),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child:
        FutureBuilder(future:coupen.coupen_list() , builder: (context, snapshot) {
          return
            snapshot.connectionState ==ConnectionState.waiting?
                const Center(child: CircularProgressIndicator(),):

            coupen.coupenlist.isEmpty?
                Center(child: const Text("No Coupons")):
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: coupen.coupenlist[0]["data"].length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade300, blurRadius: 1)
                      ]),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/images/coupon_ecom.png",
                          height: h / 7,
                          width: w / 4,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: w / 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: w / 1.7,
                            child: Text(
                coupen.coupenlist[0]["data"][index]["cupon_title"].toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Ember",
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ), SizedBox(
                            height: h / 80,
                          ),
                           Text(
                coupen.coupenlist[0]["data"][index]["discountType"]=="Percentage"?
                            " ${ coupen.coupenlist[0]["data"][index]  ["discountAmount"] .toString() } % off":
                " ${ coupen.coupenlist[0]["data"][index]  ["discountAmount"] .toString() } money off"


                             ,
                             style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Ember",
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: h / 80,
                          ),
                          Text(
                           " ${ coupen.coupenlist[0]["data"][index]  ["start_date"] .toString() } - ${ coupen.coupenlist[0]["data"][index]  ["expire_date"] .toString() }"
                            ,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Ember",
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ), SizedBox(
                            height: h / 80,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: w / 2.5,
                              height: h / 30,
                              decoration: BoxDecoration(
                                  color: logocolo,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  coupen.coupenlist[0]["data"][index]["cupon_code"].toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: "Ember_Bold"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },),


      ),
    );
  }
}
