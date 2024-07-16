import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/productdeatils.dart';
import 'package:inntuser/screen/Users/sellers/sellercontroller.dart';
import 'package:inntuser/screen/Users/subsubcatfilter.dart';

import '../../Api/productlistbysubsubcat.dart';
import '../../ulits/constant.dart';

class Subsubcatprod extends StatefulWidget {
  final Subsubcatname;
  final Subsubcatid;
  final shopid;
  const Subsubcatprod(
      {super.key, this.Subsubcatname, this.Subsubcatid, this.shopid});

  @override
  State<Subsubcatprod> createState() => _SubsubcatprodState();
}

class _SubsubcatprodState extends State<Subsubcatprod> {
  final changeviews = Get.put(Seller());
  final prodlist = Get.put(fetchInntsubsubCategoryproductList());

  @override
  void dispose() {
    // TODO: implement dispose
    prodlist.inntsubsubCateprofilter.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String selectedItem = 'Move to bag';
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.Subsubcatname),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              Get.to(() => SubsubFilter(
                    subsubcatid: widget.Subsubcatid,
                  ));
              //  _showScannerOptions(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future:
                  prodlist.subsubcatproList(widget.Subsubcatid, widget.shopid),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(color: logocolo),
                      )
                    : Obx(() => prodlist.inntsubsubCateprofilter.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 1 / 1.3),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: prodlist.inntsubsubCateprofilter
                                .elementAt(0)
                                .data!
                                .length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => Product_deatils(
                                        sourceName: "0",
                                        shopid: prodlist.inntsubsubCateprofilter
                                            .elementAt(0)
                                            .data!
                                            .elementAt(index)
                                            .venderId
                                            .toString(),
                                        subsubcateid: prodlist
                                            .inntsubsubCateprofilter
                                            .elementAt(0)
                                            .data!
                                            .elementAt(index)
                                            .productId
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8),
                                        ),
                                        child: Image.network(
                                          "$image_url${prodlist.inntsubsubCateprofilter.elementAt(0).data!.elementAt(index).image1.toString()}",
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
                                            prodlist.inntsubsubCateprofilter
                                                .elementAt(0)
                                                .data!
                                                .elementAt(index)
                                                .productName
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
                                            "${prodlist.inntsubsubCateprofilter.elementAt(0).data!.elementAt(index).salePrice.toString()} CFA",
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
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: Padding(
                                //         padding: const EdgeInsets.only(
                                //             left: 8.0, right: 8),
                                //         child: Column(
                                //           crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //           children: [
                                //
                                //
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              );
                            },
                          )
                        : prodlist.inntsubsubCateprod12
                                .elementAt(0)
                                .data!
                                .isNotEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        childAspectRatio: 1 / 1.3),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: prodlist.inntsubsubCateprod12
                                    .elementAt(0)
                                    .data!
                                    .length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => Product_deatils(
                                            sourceName: "0",
                                            shopid: prodlist
                                                .inntsubsubCateprod12
                                                .elementAt(0)
                                                .data!
                                                .elementAt(index)
                                                .venderId
                                                .toString(),
                                            subsubcateid: prodlist
                                                .inntsubsubCateprod12
                                                .elementAt(0)
                                                .data!
                                                .elementAt(index)
                                                .productId
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              topLeft: Radius.circular(8),
                                            ),
                                            child: Image.network(
                                              "$image_url${prodlist.inntsubsubCateprod12.elementAt(0).data!.elementAt(index).image1.toString()}",
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
                                                prodlist.inntsubsubCateprod12
                                                    .elementAt(0)
                                                    .data!
                                                    .elementAt(index)
                                                    .productName
                                                    .toString(),
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                "${prodlist.inntsubsubCateprod12.elementAt(0).data!.elementAt(index).salePrice.toString()} CFA",
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
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.only(
                                    //             left: 8.0, right: 8),
                                    //         child: Column(
                                    //           crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //           children: [
                                    //
                                    //
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  );
                                },
                              )
                            : const Text(
                                "No product",
                                style: TextStyle(color: Colors.black),
                              ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
