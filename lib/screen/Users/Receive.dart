import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:get/get.dart';
import '../../Api/getuserprofile.dart';
import '../../ulits/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MyQrReceive extends StatefulWidget {
  const MyQrReceive({super.key});

  @override
  State<MyQrReceive> createState() => _MyQrReceiveState();
}

class _MyQrReceiveState extends State<MyQrReceive> {

  final userqr =Get.put(Getuserprofile_api());
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child:
            FutureBuilder(future: userqr.userprofile(), builder: (context, snapshot) {
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
                userqr.profiledata.isEmpty?
                const Text("error to loading your qrcode"):
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height:h/10 ,),
                    Text(AppLocalizations.of(context)!.paymentto,style: const TextStyle(fontSize: 15),),
                    SizedBox(height:h/50 ,),
                    Center(child: Text("${userqr.profiledata[0][0]['first_name']}  ${userqr.profiledata[0][0]['last_name']}",style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)),
                    SizedBox(height:h/20 ,),
                    SizedBox(width: w/1.5,
                      child: PrettyQrView.data(
                        data: '${userqr.profiledata[0][0]['payment_qrcode'] ?? "0.0"}',
                        // decoration:  PrettyQrDecoration(
                        //   image: PrettyQrDecorationImage(
                        //     image: AssetImage('assets/images/th-_1_.jpg'),
                        //   ),
                        // ),
                      ),
                    ),
                    SizedBox(height:h/40 ,),
                    Center(child: Text(AppLocalizations.of(context)!.myqrrrrec,textAlign: TextAlign.center,)),


                  ],
                ));
            },)

        ),
      ),
    );
  }
}
