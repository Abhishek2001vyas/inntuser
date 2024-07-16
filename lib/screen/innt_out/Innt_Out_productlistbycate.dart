import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Api/inntOutcategoryList_api.dart';
import '../../Api/inntoutproductlist.dart';
import '../../ulits/constant.dart';
import 'Searchinnoutproduct.dart';
import 'innt_out_productdetails.dart';


class Inntout_Productlist extends StatefulWidget {
  final inntoutcateid;
  const Inntout_Productlist({super.key, this.inntoutcateid});

  @override
  State<Inntout_Productlist> createState() => _Inntout_ProductlistState();
}

class _Inntout_ProductlistState extends State<Inntout_Productlist> {
  final getInntOutCategory_api = Get.put(fetchInntOutCategoryList());

  late var dropdownvalue =widget.inntoutcateid;
final InntOutproductli=Get.put(InntOutproductlist());
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
actions: [ IconButton(onPressed: (){}, icon: const Icon(Icons.filter_list,color: Colors.white,))
],
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child:const Icon(Icons.arrow_back_ios)
        ),
        backgroundColor: secondryColor,
        elevation: 0,
        // forceMaterialTransparency: true,
        title: SizedBox(
          height: h / 25,
          width: w / 1.5,
          child: TextFormField( onTap: (){
            Get.to(const HomeSearchinnout());
          },readOnly: true,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8),
                hintText: "Search in innt out",hintStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                fillColor: const Color(0xffeef1f5),
                filled: true,
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white10,width: 5),
                    borderRadius: BorderRadius.circular(15))),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
                padding: const EdgeInsets.only(left: 5, right: 5,bottom: 5),
                width: w,
                decoration: const BoxDecoration(color: secondryColor),
                child:  const Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   /* Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder(
                            future: getInntOutCategory_api.inntOutCategoryList(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                // Show a loading indicator while waiting for the data
                                return Center(
                                    child: CircularProgressIndicator(
                                      color: logocolo,
                                    ));
                              } else if (snapshot.hasError) {
                                // Display an error message if the future throws an error
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return
                                  Container(
                                    width: w / 3,
                                    padding: EdgeInsets.only(left: 4),
                                    decoration: const BoxDecoration(
                                      //borderRadius: BorderRadius.circular(10),
                                      // border: Border.fromBorderSide(BorderSide)
                                    ),
                                    child: DropdownButton(
                                      dropdownColor: secondryColor,
                                      style: TextStyle(
                                        //  color: Colors.deepPurple,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      underline: const SizedBox(),
                                      // Initial Value
                                      value: dropdownvalue,
                                      hint: const Text(
                                        'No cate',
                                        style: TextStyle(color: Colors.white),
                                        maxLines: 1,
                                      ),
                                      isExpanded: true,
                                      // Down Arrow Icon
                                      icon: const Icon(Icons.keyboard_arrow_down,
                                          color: Colors.white, size: 20),

                                      // Array list of items
                                      items:  getInntOutCategory_api
                                          .inntOutCategory.map(( items) {
                                        return DropdownMenuItem(
                                          value:  items.sId.toString(),
                                          child: Text(
                                            items.categoryEnglishName.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: ( newValue) {
                                        dropdownvalue = newValue ?? "";
                                        print("fffff $newValue");
                                        // widget.inntoutcateid=
                                        setState(() {

                                        });
                                      },
                                    ),
                                  )
                                  // Column(
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //       SizedBox(
                                  //         height: h / 5,
                                  //         width: w,
                                  //         child: ListView.builder(
                                  //           itemCount: getInntOutCategory_api
                                  //               .inntOutCategory.length,
                                  //           scrollDirection: Axis.horizontal,
                                  //           itemBuilder: (context, index) {
                                  //             return GestureDetector(
                                  //               onTap: () {
                                  //                 Get.to(Inntout_Productlist(inntoutcateid: getInntOutCategory_api.inntOutCategory[index].sId.toString(), ));
                                  //                 //  Get.to(() => const InntOutInformationShop());
                                  //               },
                                  //               child: Column(
                                  //                 crossAxisAlignment:
                                  //                 CrossAxisAlignment.center,
                                  //                 children: [
                                  //                   Padding(
                                  //                     padding: const EdgeInsets.all(12.0),
                                  //                     child: ClipRRect(
                                  //                       borderRadius:
                                  //                       BorderRadius.circular(80),
                                  //                       child: Image.network(
                                  //                         "http://103.104.74.215:3038/uploads/${getInntOutCategory_api.inntOutCategory[index].categoryImage.toString()}",
                                  //                         height: 80,
                                  //                         width: 80,
                                  //                         fit: BoxFit.cover,
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   Container(
                                  //                     width: w / 4,
                                  //                     child: Text(
                                  //                       getInntOutCategory_api
                                  //                           .inntOutCategory[index]
                                  //                           .categoryEnglishName
                                  //                           .toString(),
                                  //                       overflow: TextOverflow.ellipsis,
                                  //                       textAlign: TextAlign.center,
                                  //                       maxLines: 2,
                                  //                       style: const TextStyle(
                                  //                         fontSize: 15,
                                  //                         fontWeight: FontWeight.w400,
                                  //                         fontFamily: "Amazon_med",
                                  //                       ),
                                  //                     ),
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             );
                                  //           },
                                  //         ),
                                  //       ),
                                  //     ])
                                ;
                              }
                            })
                    ),*/





                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(future: InntOutproductli.inntOutproductlList(dropdownvalue),
                builder: (context, snapshot) {
                  return
                    snapshot.connectionState==ConnectionState.waiting?
                    const Center(child: CircularProgressIndicator(color: logocolo),):

                    InntOutproductli.inntOutproddlist.isEmpty?
                    const Center(child: Text("No product"),)
                        :
                    InntOutproductli.inntOutproddlist.elementAt(0)["data"]!.isNotEmpty
                        ?
                    GridView.builder(

                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,childAspectRatio: 1/1.3),
                      physics: const NeverScrollableScrollPhysics(),

                      shrinkWrap: true,
                      itemCount: InntOutproductli.inntOutproddlist.elementAt(0)["data"]!.length,
                      itemBuilder: (context, index) {
                        return
                          InkWell(
                            onTap: () {
                              Get.to(() => InntoutProduct_deatils(
                                shopid:InntOutproductli.inntOutproddlist.elementAt(0)["data"].elementAt(index)["venderId"].toString() ,
                                subsubcateid: InntOutproductli.inntOutproddlist.elementAt(0)["data"].elementAt(index)["productId"].toString(),));
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
                                      "$image_url${InntOutproductli.inntOutproddlist.elementAt(0)["data"].elementAt(index)["image1"].toString()}",
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
                                        InntOutproductli.inntOutproddlist.elementAt(0)["data"].elementAt(index)["product_name"].toString(),
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
                                        "\$${InntOutproductli.inntOutproddlist.elementAt(0)["data"].elementAt(index)["sale_price"].toString()}",
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

                          )

                        ;
                      },
                    )
                        :const Text("No product",style: TextStyle(color: Colors.black),);
                },),
            )
          ],
        ),
      ),
    );
  }
}

