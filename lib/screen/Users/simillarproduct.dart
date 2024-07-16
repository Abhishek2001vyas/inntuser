import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:inntuser/screen/Users/productdeatils.dart';

import '../../Api/wishlist.dart';
import '../../ulits/constant.dart';



class Simillarproducts extends StatefulWidget {
  final subsubcatid;
  const Simillarproducts({super.key, this.subsubcatid});

  @override
  State<Simillarproducts> createState() => _SimillarproductsState();
}

class _SimillarproductsState extends State<Simillarproducts> {
  
  
  final simillarproductt =Get.put(wishlist_api());
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return  Scaffold(
      appBar: AppBar(
        title: Text("similar Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(future: simillarproductt.seesimilar(widget.subsubcatid),
                builder: (context, snapshot) {
                return
                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                    child: CircularProgressIndicator(color: logocolo),
                  )
                      :
                Obx(() =>
                  simillarproductt.seesimilarlist.isEmpty
                      ? const Center(child: Text("No products"))
                      :


                  GridView.builder(

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,childAspectRatio: 1/1.3),
                  physics: const NeverScrollableScrollPhysics(),

                  shrinkWrap: true,
                  itemCount: simillarproductt.seesimilarlist.elementAt(0)["data"].length,
                  itemBuilder: (context, index) {
                    return
                      InkWell(
                        onTap: () {
                          Get.to(() => Product_deatils(sourceName: "0",
                            shopid:simillarproductt.seesimilarlist.elementAt(0)["data"]!.elementAt(index)["venderId"].toString() ,
                            subsubcateid: simillarproductt.seesimilarlist.elementAt(0)["data"]!.elementAt(index)["productId"].toString(),));
                        },
                        child:
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: w / 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(
                                8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors
                                    .grey.shade300,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              ClipRRect(
                                borderRadius:
                                const BorderRadius
                                    .only(
                                  topRight:
                                  Radius.circular(
                                      8),
                                  topLeft:
                                  Radius.circular(
                                      8),
                                ),
                                child: Image.network(
                                  "$image_url${simillarproductt.seesimilarlist.elementAt(0)["data"]!.elementAt(index)["image1"].toString()}",
                                  fit: BoxFit.fitHeight,
                                  height: h / 5,
                                  width: w / 2,
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets
                                    .only(
                                    left: 8.0,top: 5),
                                child: SizedBox(
                                  width: w / 3,
                                  child: Text(
                                    simillarproductt.seesimilarlist.elementAt(0)["data"]!.elementAt(index)["product_name"].toString(),
                                    style:
                                    const TextStyle(
                                      overflow:
                                      TextOverflow
                                          .ellipsis,
                                      color:
                                      Colors.black,
                                      fontSize: 14,
                                      fontFamily:
                                      "Amazon_med",
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets
                                    .only(
                                    left: 8.0,
                                    top: 4),
                                child: SizedBox(
                                  width: w / 4,
                                  child: Text(
                                    "\$${simillarproductt.seesimilarlist.elementAt(0)["data"]!.elementAt(index)["sale_price"].toString()}",
                                    overflow:
                                    TextOverflow
                                        .ellipsis,
                                    style:
                                    const TextStyle(
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight
                                          .w400,
                                      fontFamily:
                                      "Emebr_light",
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
                      )

                    ;
                  },
                ));
              },)
              
            
            ],
          ),
        ),
      ),
    );
  }
}
