import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/subsubcatepro.dart';

import '../../Api/subcate_api.dart';
import '../../ulits/constant.dart';

class Subcatby extends StatefulWidget {
  final subcate;
  final categoryId;

  const Subcatby({super.key, required this.subcate, this.categoryId});

  @override
  State<Subcatby> createState() => _SubcatbyState();
}

class _SubcatbyState extends State<Subcatby> {
  final getsubcateList_api = Get.put(fetchInntsubCategoryList());
 late List<bool> _isExpandedList = List.generate(getsubcateList_api.inntsubCategory[0].length, (index) => false);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.subcate,
            ),
          ],
        ),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            FutureBuilder(
                future: getsubcateList_api.subcategoryList(widget.categoryId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting for the data
                    return const Center(
                        child: CircularProgressIndicator(
                      color: logocolo,
                    ));
                  } else if (snapshot.hasError) {
                    // Display an error message if the future throws an error
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return getsubcateList_api.inntsubCategory.isEmpty
                        ? Center(
                            child: Image.asset(
                                "assets/images/out-of-stock-9832079-8049857-ezgif.com-video-to-gif-converter.gif",
                                scale: 3),
                          )
                        :
                    ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                getsubcateList_api.inntsubCategory[0].length,
                            itemBuilder: (context, subcate1) =>
                                Theme(
                              data: theme,
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ExpansionTile(
                                  initiallyExpanded: _isExpandedList[subcate1],
                                  iconColor: Colors.black,
                                  collapsedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  collapsedBackgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Text(
                                    getsubcateList_api.inntsubCategory[0]
                                        [subcate1]["english_subcategory_name"],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onExpansionChanged: (value) {
                                    setState(() {
                                      _isExpandedList = List.generate(getsubcateList_api.inntsubCategory[0].length, (i) => i == subcate1 ? value : false);
                                    });
                                    print("ppp");
                                    getsubcateList_api.subsubcategoryList(
                                        getsubcateList_api.inntsubCategory[0]
                                            [subcate1]["_id"]);
                                  },
                                  backgroundColor: Colors.white,
                                  children: <Widget>[
                                    Obx(() => getsubcateList_api
                                            .inntsubsubCategory.value.isEmpty
                                        ? Center(
                                            child: Image.asset(
                                              "assets/images/out-of-stock-9832079-8049857-ezgif.com-video-to-gif-converter.gif",
                                              scale: 5,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0, left: 8),
                                            child: ListView.builder(
                                              itemCount: getsubcateList_api
                                                  .inntsubsubCategory[0].length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Get.to(Subsubcatprod(
                                                      shopid: getsubcateList_api
                                                          .inntsubsubCategory
                                                          .value[0][index]
                                                      [
                                                      "venderId"]
                                                          .toString() ,
                                                      Subsubcatid:getsubcateList_api
                                                          .inntsubsubCategory
                                                          .value[0][index]
                                                      [
                                                      "_id"]
                                                          .toString() ,
                                                      Subsubcatname: getsubcateList_api
                                                        .inntsubsubCategory
                                                        .value[0][index]
                                                    [
                                                    "english_sub_subcategory_name"]
                                                        .toString(),));
                                                    // Get.to(const Filter());
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            getsubcateList_api
                                                                .inntsubsubCategory
                                                                .value[0][index]
                                                                    [
                                                                    "english_sub_subcategory_name"]
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          const Icon(
                                                              Icons.arrow_right)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                  ],
                                ),
                              ),
                            ),
                          );
                    // GridView.builder(
                    //   physics: NeverScrollableScrollPhysics(),
                    //   shrinkWrap: true,
                    //   itemCount: getsubcateList_api.inntsubCategory[0].length,
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3,
                    //     crossAxisSpacing: 5,
                    //     mainAxisSpacing: 5,
                    //     childAspectRatio: MediaQuery.of(context).size.width /
                    //         (MediaQuery.of(context).size.height / 1.5),
                    //   ),
                    //   itemBuilder: (context, index) {
                    //     // final inntsubCategoryList = snapshot.data![index];
                    //     return GestureDetector(
                    //       onTap: () {
                    //         // Navigate to the category screen when tapped
                    //         // Get.to(Subcatby(
                    //         //   categoryId: getsubcateList_api
                    //         //       .inntsubCategory[index].sId
                    //         //       .toString(), subcate: getsubcateList_api
                    //         //     .inntsubCategory[index].categoryEnglishName
                    //         //     .toString(),
                    //         // ));
                    //       },
                    //       child: Container(
                    //         margin: const EdgeInsets.all(4),
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(8),
                    //           boxShadow: [
                    //             BoxShadow(
                    //                 color: Colors.grey.shade300, blurRadius: 5)
                    //           ],
                    //           image: const DecorationImage(
                    //             image:
                    //             AssetImage("assets/images/catbackground.png"),
                    //             fit: BoxFit.cover,
                    //           ),
                    //         ),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Align(
                    //               alignment: Alignment.topLeft,
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(5.0),
                    //                 child: Text(
                    //                   getsubcateList_api
                    //                       .inntsubCategory[0][index]["english_subcategory_name"]
                    //                       .toString(),
                    //                   overflow: TextOverflow.ellipsis,
                    //                   style: A_style_mid_black,
                    //                   maxLines: 3,
                    //                 ),
                    //               ),
                    //             ),
                    //             Image.network(
                    //               "$image_url${getsubcateList_api.inntsubCategory[0][index]["subcategory_image"].toString()}",
                    //               fit: BoxFit.fill,
                    //               width: MediaQuery.of(context).size.width / 7,
                    //               height: MediaQuery.of(context).size.height / 11,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );
                  }
                }),
            /* GridView.builder(
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.2),
              ),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade200, blurRadius: 2)
                      ]),
                  child: Stack(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            jeansCategory[index]["image"].toString(),
                            fit: BoxFit.cover,
                            height: h / 4,
                            width: w / 2,
                          ),
                        ),
                        Text(
                          jeansCategory[index]["products"],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Amazon_bold",
                              overflow: TextOverflow.ellipsis),
                          maxLines: 1,
                        ),
                        Text(
                          jeansCategory[index]["types"],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: "Ember_Light",
                              overflow: TextOverflow.ellipsis),
                          maxLines: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              jeansCategory[index]["price"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: "Amazon_bold",
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                            SizedBox(
                              width: w / 60,
                            ),
                            Text(
                              jeansCategory[index]["discount"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: "Amazon_bold",
                                  decoration: TextDecoration.lineThrough,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                            SizedBox(
                              width: w / 60,
                            ),
                            Text(
                              jeansCategory[index]["offer"],
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.green,
                                  fontFamily: "Amazon_bold",
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                          ],
                        )
                      ],
                    ),
                    Positioned(
                        child: Container(
                      margin: EdgeInsets.all(4),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: logocolo,
                      ),
                      child: Text(
                        "Regular",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: "Amazon_bold",
                        ),
                      ),
                    )),
                    // Positioned(
                    //     bottom: h / 7,
                    //     left: 1,
                    //     child: Container(
                    //       margin: EdgeInsets.all(4),
                    //       padding: EdgeInsets.all(4),
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Colors.white,
                    //       ),
                    //       child: Icon(
                    //         Icons.copy,
                    //         size: 15,
                    //         color: Colors.grey.shade800,
                    //       ),
                    //     )),
                    */
            /* Positioned(
                        bottom: h / 7,
                        right: 1,
                        child: Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            size: 15,
                            Icons.favorite_border,
                            color: Colors.grey.shade800,
                          ),
                        ))*/
            /*
                  ]),
                );
              },
            )*/
          ],
        ),
      ),
    );
  }
}
