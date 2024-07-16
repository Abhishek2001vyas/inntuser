import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/home.dart';
import 'package:inntuser/screen/Users/productdeatils.dart';
import 'package:inntuser/screen/Users/scan_screen.dart';

// import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

import '../../Controller/text2.dart';
import '../../ulits/constant.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  TextEditingController search = TextEditingController();
// final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();String? code;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: h / 23,
          width: w,
          child: TextFormField(
            enabled: true,
            controller: search,
            onChanged: (value) async {
              await homeapi.innt_prodfilter(value);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              hintText: "Search in innt",
              hintStyle: A_style_order,
              suffixIcon: GestureDetector(
                onTap: () {
                  // _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                  //     context: context,
                  //     onCode: (code) {
                  //       setState(() {
                  //         this.code = code;
                  //       });
                  //     });
                  Get.to(() => const ScanScreen());
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 7, top: 6, bottom: 6),
                  child: Image.asset(
                    "assets/images/cam1.png",
                    height: 10,
                    color: Colors.black,
                  ),
                ),
              ),
              //search icon
              prefixIcon: const Icon(Icons.search, color: Colors.black),
              fillColor: const Color(0xffeef1f5),
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(7)),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h / 80,
            ),
            /*   Center(
              child: Text(
                "Recent Searches",
                style: TextStyle(
                    //letterSpacing: 2,
                    //color: Colors.white,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Amazon_bold",
                    fontSize: 22),
              ),
            ),*/

            Obx(() => homeapi.loading == true
                ? const Center(
                    child: CircularProgressIndicator(color: logocolo),
                  )
                : homeapi.inntprof.isNotEmpty && search.text.isNotEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 1 / 1.3),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            homeapi.inntprof.elementAt(0)["data"]!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => Product_deatils(
                                    sourceName: "0",
                                    shopid: homeapi.inntprof
                                        .elementAt(0)["data"]!
                                        .elementAt(index)["venderId"]
                                        .toString(),
                                    subsubcateid: homeapi.inntprof
                                        .elementAt(0)["data"]!
                                        .elementAt(index)["productId"]
                                        .toString(),
                                  ));
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: w / 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                    ),
                                    child: Image.network(
                                      "$image_url${homeapi.inntprof.elementAt(0)["data"]!.elementAt(index)["image1"].toString()}",
                                      fit: BoxFit.fitHeight,
                                      height: h / 5,
                                      width: w / 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 5),
                                    child: SizedBox(
                                      width: w / 3,
                                      child: Text(
                                        homeapi.inntprof
                                            .elementAt(0)["data"]!
                                            .elementAt(index)["product_name"]
                                            .toString(),
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Amazon_med",
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 4),
                                    child: SizedBox(
                                      width: w / 4,
                                      child: Text(
                                        "\$${homeapi.inntprof.elementAt(0)["data"]!.elementAt(index)["sale_price"].toString()}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Emebr_light",
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    :
                    // prodlist.inntsubsubCateprod12.elementAt(0).data!.isNotEmpty
                    //     ?
                    // GridView.builder(
                    //
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,childAspectRatio: 1/1.3),
                    //   physics: NeverScrollableScrollPhysics(),
                    //
                    //   shrinkWrap: true,
                    //   itemCount: prodlist.inntsubsubCateprod12.elementAt(0).data!.length,
                    //   itemBuilder: (context, index) {
                    //     return
                    //       InkWell(
                    //         onTap: () {
                    //           Get.to(() => Product_deatils(
                    //             shopid:prodlist.inntsubsubCateprod12.elementAt(0).data!.elementAt(index).venderId.toString() ,
                    //             subsubcateid: prodlist.inntsubsubCateprod12.elementAt(0).data!.elementAt(index).productId.toString(),));
                    //         },
                    //         child:
                    //         Container(
                    //           constraints: BoxConstraints(
                    //             maxWidth: w / 4,
                    //           ),
                    //           decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius:
                    //             BorderRadius.circular(
                    //                 8),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: Colors
                    //                     .grey.shade300,
                    //                 blurRadius: 2,
                    //               ),
                    //             ],
                    //           ),
                    //           child: Column(
                    //             crossAxisAlignment:
                    //             CrossAxisAlignment
                    //                 .start,
                    //             children: [
                    //               ClipRRect(
                    //                 borderRadius:
                    //                 const BorderRadius
                    //                     .only(
                    //                   topRight:
                    //                   Radius.circular(
                    //                       8),
                    //                   topLeft:
                    //                   Radius.circular(
                    //                       8),
                    //                 ),
                    //                 child: Image.network(
                    //                   "$image_url${prodlist.inntsubsubCateprod12.elementAt(0).data!.elementAt(index).image1.toString()}",
                    //                   fit: BoxFit.fitHeight,
                    //                   height: h / 5,
                    //                   width: w / 2,
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding:
                    //                 const EdgeInsets
                    //                     .only(
                    //                     left: 8.0,top: 5),
                    //                 child: SizedBox(
                    //                   width: w / 3,
                    //                   child: Text(
                    //                     prodlist.inntsubsubCateprod12.elementAt(0).data!.elementAt(index).productName.toString(),
                    //                     style:
                    //                     const TextStyle(
                    //                       overflow:
                    //                       TextOverflow
                    //                           .ellipsis,
                    //                       color:
                    //                       Colors.black,
                    //                       fontSize: 14,
                    //                       fontFamily:
                    //                       "Amazon_med",
                    //                     ),
                    //                     maxLines: 2,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding:
                    //                 const EdgeInsets
                    //                     .only(
                    //                     left: 8.0,
                    //                     top: 4),
                    //                 child: SizedBox(
                    //                   width: w / 4,
                    //                   child: Text(
                    //                     "\$${prodlist.inntsubsubCateprod12.elementAt(0).data!.elementAt(index).salePrice.toString()}",
                    //                     overflow:
                    //                     TextOverflow
                    //                         .ellipsis,
                    //                     style:
                    //                     const TextStyle(
                    //                       fontSize: 15,
                    //                       fontWeight:
                    //                       FontWeight
                    //                           .w400,
                    //                       fontFamily:
                    //                       "Emebr_light",
                    //                     ),
                    //                     maxLines: 1,
                    //                   ),
                    //                 ),
                    //               ),
                    //
                    //             ],
                    //           ),
                    //         ),
                    //
                    //       )
                    //
                    //     ;
                    //   },
                    // ) :
                    homeapi.inntprof.isEmpty && search.text.isNotEmpty
                        ? const Text(
                            "No product",
                            style: TextStyle(color: Colors.black),
                          )
                        : const SizedBox())
          ],
        ),
      ),
    );
  }
}
