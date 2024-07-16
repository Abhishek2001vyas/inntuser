import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/send_points_scrren.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Api/getuserprofile.dart';
import '../../Api/loyaltypoints.dart';
import '../../ulits/constant.dart';

class Loyalty extends StatefulWidget {
  const Loyalty({super.key});

  @override
  State<Loyalty> createState() => _LoyaltyState();
}


class _LoyaltyState extends State<Loyalty> {
  final points=Get.put( Getuserprofile_api());
  final loyatly=Get.put( loyaltypointsapi());
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true,
        title:  Text(
          AppLocalizations.of(context)!.loyaltypoints,
        ),
      ),

      body: SingleChildScrollView(
        child:
        FutureBuilder(future: points.userprofile(),builder: (context, snapshot) {
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
          points.profiledata.isEmpty?
          const Text("error to loading your qrcode"):
            Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(
                      height: h/45,
                    ),
                    Container(
                      width: w,
                      height: 150.0,
                      decoration: const BoxDecoration(
                        color: logocolo,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Total Point",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  fontFamily: "Hey"),
                            ),

                            Text(
                              "${points.profiledata[0][0]['loyalty_point']} ",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  fontFamily: "Hey"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h/45,
                    ),
                    Container(
                      width: w,
                      height: 150.0,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Total Cash",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  fontFamily: "Hey"),
                            ),

                            Text(
                              "${double.parse(points.profiledata[0][0]['loyalty_point'].toString())*0.002 } CFA",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  fontFamily: "Hey"),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: h/20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                          var  a=double.parse(points.profiledata[0][0]['loyalty_point'].toString())*0.002;

                            if(a<1000){
                              loyatly.erorrcashback.value=true;
                            }
                            else{
                              loyatly.cashback(points.profiledata[0][0]['mobile_number']);
                            }
                          },
                          child: Container(
                            width: w/2.3,
                            height: 40.0,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                border: Border.all(
                                    color: logocolo, width: 2)
                            ),

                            child: const Center(
                              child: Text(
                                "Cashback",
                                style: TextStyle(
                                    color: logocolo,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontFamily: "Hey"),
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(onTap: (){
                          Get.to(const SendPointsScrren());
                        },
                          child: Container(
                            width: w/2.3,
                            height: 40.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                border: Border.all(
                                    color: logocolo, width: 2)
                            ),
                            child: const Center(
                              child: Text(
                                "Send",
                                style: TextStyle(
                                    color: logocolo,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontFamily: "Hey"),
                              ),
                            ),
                          ),
                        ),
                      ],

                    ),
                    SizedBox(
                      height: h/7,
                    ),
Obx(() =>
loyatly.erorrcashback==true?
    const Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Insufficient funds to cashback",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            fontFamily: "Hey"),
                      ),
                    ):const SizedBox(),
),
                    const Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "You need at least\n 1,000 CFA to cash back",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            fontFamily: "Hey"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
        },),

      ),
    );
  }
}
