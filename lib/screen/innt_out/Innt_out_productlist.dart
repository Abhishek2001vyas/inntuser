// import 'dart:ffi';
//
// import 'package:animated_read_more_text/animated_read_more_text.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart';
// import 'package:get/get.dart';
// import 'package:inntuser/Controller/button.dart';
// import '../../Api/productlistbysubsubcat.dart';
// import '../../Api/wishlist.dart';
// import '../../Controller/dotscontroller.dart';
// import '../../Controller/text2.dart';
// import '../../ulits/constant.dart';
//
// class Product_deatils extends StatefulWidget {
//   final subsubcateid;
//   final shopid;
//
//   const Product_deatils({super.key, this.subsubcateid, this.shopid});
//
//   @override
//   State<Product_deatils> createState() => _Product_deatilsState();
// }
//
// class _Product_deatilsState extends State<Product_deatils> {
//
//
//   String selectedItem = 'Delete item';
//   String ?_selectedSize ;
//   String ?_selectedColor;
//   String _selectedType = 'No sleeve';
//   final List<String> _dropdownType = [
//     'No sleeve',
//     'Sleeve',
//   ];
//   String _selectedQty = 'Quantity';
//   final List<String> _dropdownQTy = ['Quantity', '1', '2', '3', '4', '5'];
//   final proddea = Get.put(fetchInntsubsubCategoryproductList());
//   final wishl = Get.put(wishlist_api());
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar:
//
//       AppBar(
//         centerTitle: true,
//         title: const Text("Product Details"),
//         actions: [
//
//           Obx(() =>
//
//               IconButton(
//                 onPressed: () async{
//                   await  wishl.wishlike( proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).productId,
//                       widget.shopid,widget.subsubcateid
//                   );
//                   setState(() {
//
//                   });
//                 },
//                 icon:
//                 proddea.inntsubsubCateproddeta.isEmpty?
//
//                 Icon(
//                   CupertinoIcons.heart,
//
//                 )       :
//
//                 proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).likeStatus ==1?
//
//                 Icon(
//                   CupertinoIcons.heart_solid,color: Colors.pink,
//
//                 ):
//
//                 Icon(
//                   CupertinoIcons.heart,
//
//                 ),
//               )
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//           child: FutureBuilder(
//               future: proddea.subsubcatprodeat(widget.subsubcateid,widget.shopid),
//               builder: (context, snapshot) {
//
//                 return
//                   snapshot.connectionState==ConnectionState.waiting?
//                   Center(child: CircularProgressIndicator(color: logocolo),)
//                       :
//                   snapshot.hasError ?
//                   Center(child: CircularProgressIndicator(color: logocolo),)
//                       :
//                   proddea.inntsubsubCateproddeta.isNotEmpty?
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Stack(
//                           children: [
//                             Obx(() =>
//                                 CarouselSlider.builder(
//                                   itemCount: proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).images!.length,
//                                   itemBuilder: (context, index, realIndex) => Center(
//                                     child: ClipRRect(
//                                         child: Image.network(
//                                           "$image_url${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).images!.elementAt(index).toString()}",
//                                           height: h / 1,
//                                           fit: BoxFit.fill,
//                                           // filterQuality: FilterQuality.low,
//                                         )),
//                                   ),
//                                   options: CarouselOptions(
//                                     onPageChanged: (index, reason) {
//                                       proddea.changeindicator(index);
//                                       // setState(() {
//                                       //   currentindex = index;
//                                       // });
//                                     },
//                                     height: h / 2.2,
//                                     enlargeCenterPage: true,
//                                     autoPlay: true,
//                                     aspectRatio: 15 / 20,
//                                     autoPlayCurve: Curves.fastOutSlowIn,
//                                     autoPlayAnimationDuration:
//                                     const Duration(milliseconds: 800),
//                                     viewportFraction: 1,
//                                   ),
//                                 )),
//                             Obx(() =>  Positioned(
//                                 bottom: 1,
//                                 left: w / 2.5,
//                                 child: CustomIndicator(
//                                   currentIndex: proddea.currentindex.value,
//                                   itemCount: proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).images!.length,
//                                 )))
//                           ],
//                         ),
//                         Container(
//                           color: Colors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.all(15.0),
//                             child: Column(
//                               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).productName!.toString(),
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: "Amazon_med",
//                                   ),
//                                 ),
//                                 SizedBox(height: h / 100),
//                                 AnimatedReadMoreText(
//                                   "${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).description!.toString()}"
//
//                                   ,
//                                   maxLines: 4,
//                                   // Set a custom text for the expand button. Defaults to Read more
//                                   readMoreText: 'Read more +',
//                                   // Set a custom text for the collapse button. Defaults to Read less
//                                   readLessText: 'Read less -',
//                                   // Set a custom text style for the main block of text
//                                   textStyle: A_style_mid,
//                                   // Set a custom text style for the expand/collapse button
//                                   buttonTextStyle: TextStyle(
//                                     fontSize: 14,color: logocolo,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 /*  Text(
//                                   "${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).description!.toString()}",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 14,
//                                       fontFamily: "Ember_Light")),*/
//                                 SizedBox(height: h / 100),
//                                 Row(
//                                   children: [
//                                     Text("\$${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).salePrice ?? 0}  ",
//                                         style: A_style_text_head2),
//                                     Text(
//                                       "\$${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).mrpPrice ?? 0}",
//                                       style: TextStyle(
//                                         //letterSpacing: 2.5,
//                                         //color: Colors.white,
//                                           color: Colors.grey,
//                                           fontFamily: "Amazon_bold",
//                                           decoration: TextDecoration.lineThrough,
//                                           decorationColor: Colors.grey,
//                                           fontSize: 20),
//                                     ),
//                                     Text(
//                                       " (- ${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).discount ?? 0}%)",
//                                       style: TextStyle(
//                                         color: Colors.redAccent.shade700,
//                                         fontSize: 20,
//                                         fontFamily: "Amazon_Medium",
//                                       ),
//                                     ),
//                                     Spacer(),
//                                     PopupMenuButton(
//                                       color: Colors.white,
//                                       surfaceTintColor: Colors.white,
//                                       initialValue: selectedItem,
//                                       icon: const Icon(
//                                         Icons.more_horiz,
//                                         color: Colors.black,
//                                       ),
//                                       itemBuilder: (_) {
//                                         return <PopupMenuEntry<String>>[
//                                           PopupMenuItem<String>(
//                                             height: h / 25,
//                                             value: 'Chat',
//                                             child: Row(
//                                               children: [
//                                                 const Text("Chat"),
//                                                 Spacer(),
//                                                 const Icon(
//                                                   Icons.message_outlined,
//                                                   size: 20,
//                                                   color: Colors.black,
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                           PopupMenuDivider(),
//                                           PopupMenuItem<String>(
//                                             height: h / 25,
//                                             value: 'Share',
//                                             child: Row(
//                                               children: [
//                                                 const Text("Share"),
//                                                 Spacer(),
//                                                 Image.asset(
//                                                   "assets/images/share.png",
//                                                   width: w / 27,
//                                                   height: h / 27,
//                                                   color: Colors.black,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           PopupMenuDivider(),
//                                           PopupMenuItem<String>(
//                                             height: h / 25,
//                                             value: 'Report',
//                                             child: Row(
//                                               children: [
//                                                 const Text("Report"),
//                                                 Spacer(),
//                                                 const Icon(
//                                                   Icons.report_problem_outlined,
//                                                   size: 20,
//                                                   color: Colors.black,
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ];
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: h / 100),
//                                 Container(
//                                   width: w / 3.5,
//                                   padding: EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                       color: Colors.yellow.shade700,
//                                       borderRadius: BorderRadius.circular(8)),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       // SizedBox(width: w/20,),
//                                       const Icon(
//                                         Icons.star,
//                                         size: 16,
//                                         color: white,
//                                       ),
//                                       SizedBox(
//                                         child: Text(
//                                           "${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).rating.toString()}",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       SizedBox(width: w / 100),
//                                       Text(
//                                         "(${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).totalRating}+)",
//                                         style:
//                                         TextStyle(fontSize: 14, color: white),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: w,
//                           height: h / 5,
//                           color: Colors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.all(15.0),
//                             child: Column(
//                               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Select", style: A_style_text_head2),
//                                 SizedBox(
//                                   height: h / 100,
//                                 ),
//                                 Wrap(runSpacing: 10,
//                                   children: [
//                                     Container(
//                                       height: h / 20,
//                                       padding: const EdgeInsets.only(left: 4),
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           border: Border.all(
//                                               color: Colors.black12, width: 1)),
//                                       child: DropdownButton<String>(
//                                         underline: const SizedBox(),
//                                         hint: Text("Select size"),
//                                         value: _selectedSize,
//
//                                         items:  proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).size!.map((String item) {
//                                           return DropdownMenuItem<String>(
//                                             value: item,
//                                             child: Text(item,
//                                                 style: TextStyle(fontSize: 12)),
//                                           );
//                                         }).toList(),
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             _selectedSize = newValue!;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: w / 40,
//                                     ),
//                                     Container(
//                                       height: h / 20,
//                                       padding: const EdgeInsets.only(left: 4),
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           border: Border.all(
//                                               color: Colors.black12, width: 1)),
//                                       child: DropdownButton<String>(
//                                         underline: const SizedBox(),  hint: Text("Select color"),
//                                         value: _selectedColor,
//                                         items: proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).color!.map((String item) {
//                                           return DropdownMenuItem<String>(
//                                             value: item,
//                                             child: Text(item,
//                                                 style: TextStyle(fontSize: 12)),
//                                           );
//                                         }).toList(),
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             _selectedColor = newValue!;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: w / 40,
//                                     ),
//                                     Container(
//                                       height: h / 20,
//                                       padding: const EdgeInsets.only(left: 4),
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           border: Border.all(
//                                               color: Colors.black12, width: 1)),
//                                       child: DropdownButton<String>(
//                                         underline: const SizedBox(),
//                                         value: _selectedType,
//                                         items: _dropdownType.map((String item) {
//                                           return DropdownMenuItem<String>(
//                                             value: item,
//                                             child: Text(item,
//                                                 style: TextStyle(fontSize: 12)),
//                                           );
//                                         }).toList(),
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             _selectedType = newValue!;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: w / 40,
//                                     ),
//                                     Container(
//                                       height: h / 20,
//                                       padding: const EdgeInsets.only(left: 4),
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           border: Border.all(
//                                               color: Colors.black12, width: 1)),
//                                       child: DropdownButton<String>(
//                                         underline: const SizedBox(),
//                                         value: _selectedQty,
//                                         items: _dropdownQTy.map((String item) {
//                                           return DropdownMenuItem<String>(
//                                             value: item,
//                                             child: Text(item,
//                                                 style: TextStyle(fontSize: 12)),
//                                           );
//                                         }).toList(),
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             _selectedQty = newValue!;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: h / 100),
//                         Column(
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(width: w / 10),
//                                 Image.asset("assets/images/fast-delivery.png",
//                                     scale: 13),
//                                 SizedBox(width: w / 30),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Delivery",
//                                         maxLines: 3,
//                                         textAlign: TextAlign.center,
//                                         style: A_style_text_head21),
//                                     SizedBox(
//                                       height: 2,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text("Time : ",
//                                             maxLines: 3,
//                                             textAlign: TextAlign.center,
//                                             style:  TextStyle(
//                                               //letterSpacing: 1.5,
//                                               //color: Colors.white,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.black,
//                                                 fontFamily: "Amazon_med",
//                                                 fontSize: 14)),
//                                         Text("${ proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).deliveryTime!}",
//                                             style: TextStyle(
//                                               //letterSpacing: 1.5,
//                                               //color: Colors.white,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.green,
//                                                 fontFamily: "Amazon_med",
//                                                 fontSize: 14)),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 2,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text("Fees : ",
//                                             maxLines: 3,
//                                             textAlign: TextAlign.center,
//                                             style:  const TextStyle(
//                                               //letterSpacing: 1.5,
//                                               //color: Colors.white,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.black,
//                                                 fontFamily: "Amazon_med",
//                                                 fontSize: 14)),
//                                         Text("${ proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).deliveryFee!} CFA",
//                                             style: TextStyle(
//                                               //letterSpacing: 1.5,
//                                               //color: Colors.white,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.green,
//                                                 fontFamily: "Amazon_med",
//                                                 fontSize: 14)),
//                                       ],
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: h / 30,
//                             ),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(width: w / 10),
//                                 Image.asset("assets/images/exchange.png",
//                                     scale: 13),
//                                 SizedBox(width: w / 30),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Return policy",
//                                         maxLines: 3,
//                                         textAlign: TextAlign.center,
//                                         style: A_style_text_head21),
//                                     SizedBox(
//                                       height: 2,
//                                     ),
//                                     Obx(() =>
//                                     proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).returnType!.elementAt(0).type.toString() !="false"?
//                                     Row(
//                                       children: [
//                                         Text("Within",
//                                             maxLines: 3,
//                                             textAlign: TextAlign.center,
//                                             style: const TextStyle(
//                                               //letterSpacing: 1.5,
//                                               //color: Colors.white,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.black,
//                                                 fontFamily: "Amazon_med",
//                                                 fontSize: 14)),
//                                         SizedBox(width: w / 50),
//                                         Text("${ proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).returnType!.elementAt(0).value ?? 0}",
//                                             style: TextStyle(
//                                               //letterSpacing: 1.5,
//                                               //color: Colors.white,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.red.shade700,
//                                                 fontFamily: "Amazon_med",
//                                                 fontSize: 14)),
//                                         SizedBox(width: w / 50),
//                                         Text("days",
//                                             maxLines: 3,
//                                             textAlign: TextAlign.center,
//                                             style: const TextStyle(
//                                               //letterSpacing: 1.5,
//                                               //color: Colors.white,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.black,
//                                                 fontFamily: "Amazon_med",
//                                                 fontSize: 14)),
//                                       ],
//                                     )
//                                         :
//                                     Row(
//                                       children: [
//                                         Text("No return accepted",
//                                             maxLines: 3,
//                                             textAlign: TextAlign.center,
//                                             style: const TextStyle(
//                                               //letterSpacing: 1.5,
//                                               //color: Colors.white,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.red,
//                                                 fontFamily: "Amazon_med",
//                                                 fontSize: 14)),
//
//                                       ],
//                                     )
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: h / 100,
//                         ),
//
//
//                         Material(
//                           color: Colors.white,
//                           elevation: 1,
//                           child: Container(
//                             width: w,
//                             color: Colors.white,
//                             child: Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: Column(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text("Product Details",
//                                           style: A_style_text_head2),
//
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: h / 100,
//                                   ),
//                                   AnimatedReadMoreText(
//                                     "Brand : ${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).brandName.toString()} \n"
//                                         "warranty : ${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).warranty.toString()} \n"
//                                         "note : ${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).note.toString()} \n"
//                                         "product weight : ${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).productWeight.toString()} \n"
//                                         "delivery : ${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).deliveryType.toString()} \n"
//
//                                     ,
//                                     maxLines: 3,
//                                     // Set a custom text for the expand button. Defaults to Read more
//                                     readMoreText: 'Read more +',
//                                     // Set a custom text for the collapse button. Defaults to Read less
//                                     readLessText: 'Read less -',
//                                     // Set a custom text style for the main block of text
//                                     textStyle: A_style_mid,
//                                     // Set a custom text style for the expand/collapse button
//                                     buttonTextStyle: TextStyle(
//                                       fontSize: 14,color: logocolo,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: h / 100,
//                         ),
//                         Material(
//                           color: Colors.white,
//                           elevation: 1,
//                           child: Container(
//                             width: w,
//                             color: Colors.white,
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                   left: 15, right: 15, bottom: 15, top: 4),
//                               child: Column(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Sold By", style: A_style_text_head2),
//                                   SizedBox(
//                                     height: h / 100,
//                                   ),
//                                   Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       CircleAvatar(
//                                         backgroundColor: Colors.grey.shade100,
//                                         radius: 22,
//                                         child: Image.network(
//                                           "$image_url${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).shopLogo} ",
//                                           color: logocolo,
//                                           height: 22,
//                                           width: 22,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: w / 70,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Text("${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).shopName.toString()} ",
//                                               style: A_style_medium),
//                                           Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.location_on,
//                                                 color: Colors.grey.shade400,
//                                               ),
//                                               SizedBox(width: w/2,
//                                                 child: Text(
//                                                   "${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).shopAddress.toString()} ${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).shopCity.toString()} ",
//                                                   style: A_style_mid,
//                                                   overflow: TextOverflow.ellipsis,
//                                                   maxLines: 1,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       Spacer(),
//                                       PopupMenuButton(
//                                         color: Colors.white,
//                                         surfaceTintColor: Colors.white,
//                                         initialValue: selectedItem,
//                                         icon: const Icon(
//                                           Icons.more_horiz,
//                                           color: Colors.black,
//                                         ),
//                                         itemBuilder: (_) {
//                                           return <PopupMenuEntry<String>>[
//                                             PopupMenuItem<String>(
//                                               height: h / 25,
//                                               value: 'Chat',
//                                               child: Row(
//                                                 children: [
//                                                   const Text("Chat"),
//                                                   Spacer(),
//                                                   const Icon(
//                                                     Icons.message_outlined,
//                                                     size: 20,
//                                                     color: Colors.black,
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                             PopupMenuDivider(),
//                                             PopupMenuItem<String>(
//                                               height: h / 25,
//                                               value: 'Share',
//                                               child: Row(
//                                                 children: [
//                                                   const Text("Share"),
//                                                   Spacer(),
//                                                   Image.asset(
//                                                     "assets/images/share.png",
//                                                     width: w / 27,
//                                                     height: h / 27,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             PopupMenuDivider(),
//                                             PopupMenuItem<String>(
//                                               height: h / 25,
//                                               value: 'Report',
//                                               child: Row(
//                                                 children: [
//                                                   const Text("Report"),
//                                                   Spacer(),
//                                                   const Icon(
//                                                     Icons.report_problem_outlined,
//                                                     size: 20,
//                                                     color: Colors.black,
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ];
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: h / 80,
//                                   ),
//                                   IntrinsicHeight(
//                                     child: SingleChildScrollView(
//                                       scrollDirection: Axis.horizontal,
//                                       child: Row(
//                                         children: [
//                                           Container(
//                                             width: w / 3.5,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                               children: [
//                                                 Text(
//                                                   "Rating",
//                                                   style: A_style_mid_black,
//                                                 ),
//                                                 SizedBox(
//                                                   height: h / 100,
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Icon(Icons.star,
//                                                         size: 20,
//                                                         color: Colors
//                                                             .yellow.shade800),
//                                                     Icon(Icons.star,
//                                                         size: 20,
//                                                         color: Colors
//                                                             .yellow.shade800),
//                                                     Icon(Icons.star,
//                                                         size: 20,
//                                                         color: Colors
//                                                             .yellow.shade800),
//                                                     Icon(Icons.star,
//                                                         size: 20,
//                                                         color: Colors
//                                                             .yellow.shade800),
//                                                     Icon(Icons.star,
//                                                         size: 20,
//                                                         color: Colors
//                                                             .yellow.shade800),
//                                                   ],
//                                                 ),
//                                                 SizedBox(
//                                                   height: h / 100,
//                                                 ),
//                                                 Text(
//                                                   "${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).totalRater.toString()}",
//                                                   style: A_style_mid_black,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           VerticalDivider(
//                                             thickness: 2,
//                                             indent: 6,
//                                             endIndent: 6,
//                                             color: Colors.grey,
//                                           ),
//                                           Container(
//                                             width: w / 3.5,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                               children: [
//                                                 Text(
//                                                   "Products",
//                                                   style: A_style_mid_black,
//                                                 ),
//                                                 SizedBox(
//                                                   height: h / 100,
//                                                 ),
//                                                 Image.asset(
//                                                   "assets/images/products.png",
//                                                   height: 20,
//                                                   width: 20,
//                                                 ),
//                                                 SizedBox(
//                                                   height: h / 100,
//                                                 ),
//                                                 Text(
//                                                   "${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).totalProduct.toString()}",
//                                                   style: A_style_mid_black,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           VerticalDivider(
//                                             thickness: 2,
//                                             indent: 6,
//                                             endIndent: 6,
//                                             color: Colors.grey,
//                                           ),
//                                           Container(
//                                             width: w / 3.5,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                               children: [
//                                                 Text(
//                                                   "Sales",
//                                                   style: A_style_mid_black,
//                                                 ),
//                                                 SizedBox(
//                                                   height: h / 100,
//                                                 ),
//                                                 Image.asset(
//                                                   "assets/images/sales.png",
//                                                   height: 20,
//                                                   width: 20,
//                                                 ),
//                                                 SizedBox(
//                                                   height: h / 100,
//                                                 ),
//                                                 Text(
//                                                   "${proddea.inntsubsubCateproddeta.elementAt(0).data!.elementAt(0).totalSale.toString()}",
//                                                   style: A_style_mid_black,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           VerticalDivider(
//                                             indent: 6,
//                                             endIndent: 6,
//                                             thickness: 2,
//                                             color: Colors.grey,
//                                           ),
//                                           Container(
//                                             width: w / 3.5,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                               children: [
//                                                 Text(
//                                                   "Page views",
//                                                   style: A_style_mid_black,
//                                                 ),
//                                                 SizedBox(
//                                                   height: h / 100,
//                                                 ),
//                                                 Image.asset(
//                                                   "assets/images/eyes.png",
//                                                   height: 20,
//                                                   width: 20,
//                                                 ),
//                                                 SizedBox(
//                                                   height: h / 100,
//                                                 ),
//                                                 Text(
//                                                   "101k",
//                                                   style: A_style_mid_black,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           VerticalDivider(
//                                             indent: 6,
//                                             endIndent: 6,
//                                             thickness: 2,
//                                             color: Colors.grey,
//                                           ),
//                                           Container(
//                                             width: w / 3.5,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                               children: [
//                                                 Text(
//                                                   "Liked items",
//                                                   style: A_style_mid_black,
//                                                 ),
//                                                 SizedBox(
//                                                   height: h / 100,
//                                                 ),
//                                                 Icon(
//                                                   Icons.favorite,
//                                                   size: 20,
//                                                   color: Colors.black,
//                                                 ),
//                                                 SizedBox(
//                                                   height: h / 100,
//                                                 ),
//                                                 Text(
//                                                   "10k",
//                                                   style: A_style_mid_black,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: h / 70,
//                                   ),
//                                   Text("More products customer reviews",
//                                       style: A_style_text_head2),
//                                   SizedBox(
//                                     height: h / 90,
//                                   ),
//                                   ListView.builder(
//                                       physics: NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       itemCount: 3,
//                                       itemBuilder: (context, index) {
//                                         return Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             ClipRRect(
//                                               borderRadius:
//                                               BorderRadius.circular(8),
//                                               child: Image.asset(
//                                                 "assets/images/jeans1.png",
//                                                 fit: BoxFit.cover,
//                                                 height: h / 10,
//                                                 width: w / 5,
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: h / 90,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 ProfilePicture(
//                                                   name: '',
//                                                   radius: 11,
//                                                   fontsize: 1,
//                                                   img:
//                                                   'https://static-koimoi.akamaized.net/wp-content/new-galleries/2023/03/how-bigg-boss-16-winner-mc-stan-connected-with-rap-music-001.jpg',
//                                                 ),
//                                                 SizedBox(
//                                                   width: w / 90,
//                                                 ),
//                                                 Text(
//                                                   "Aditya Dharmawan Saputra",
//                                                   style: A_style_mid_black,
//                                                 )
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: h / 100,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Icon(Icons.star,
//                                                     size: 20,
//                                                     color:
//                                                     Colors.yellow.shade800),
//                                                 Icon(Icons.star,
//                                                     size: 20,
//                                                     color:
//                                                     Colors.yellow.shade800),
//                                                 Icon(Icons.star,
//                                                     size: 20,
//                                                     color:
//                                                     Colors.yellow.shade800),
//                                                 Icon(Icons.star,
//                                                     size: 20,
//                                                     color:
//                                                     Colors.yellow.shade800),
//                                                 Icon(Icons.star,
//                                                     size: 20,
//                                                     color:
//                                                     Colors.yellow.shade800),
//                                                 SizedBox(
//                                                   width: w / 90,
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: h / 90,
//                                             ),
//                                           ],
//                                         );
//                                       }),
//                                   Center(
//                                     child: Text(
//                                       "See more reviews",
//                                       style: TextStyle(
//                                         //letterSpacing: 2,
//                                         //color: Colors.white,
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: h / 90,
//                                   ),
//                                   Text("More products on the shop",
//                                       style: A_style_text_head2),
//                                   SizedBox(
//                                     height: h / 90,
//                                   ),
//                                   GridView.builder(
//                                     itemBuilder: (context, index) {
//                                       return GestureDetector(
//                                         onTap: () {},
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                               BorderRadius.circular(8),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                     color: Colors.grey.shade300,
//                                                     blurRadius: 5)
//                                               ]),
//                                           child: Center(
//                                               child: Image.asset(
//                                                 "assets/images/perfume.png",
//                                                 width: w / 5,
//                                                 height: h / 9,
//                                                 fit: BoxFit.fill,
//                                               )),
//                                         ),
//                                       );
//                                     },
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     shrinkWrap: true,
//                                     itemCount: 6,
//                                     gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 3,
//                                       crossAxisSpacing: 8,
//                                       mainAxisSpacing: 8,
//                                       childAspectRatio: MediaQuery.of(context)
//                                           .size
//                                           .width /
//                                           (MediaQuery.of(context).size.height /
//                                               1.7),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ])
//                       :SizedBox()
//                 ;
//               })),
//       bottomNavigationBar: Container(
//         padding:
//         EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         color: Colors.grey.shade100,
//         child: Container(
//           padding: EdgeInsets.all(8),
//           child: ElevatedButton(
//               style: buttonPrimary,
//               onPressed: () {},
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.shopping_bag, color: Colors.white, size: 20),
//                   Text(" Add To Bag",
//                       style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontFamily: "Amazon_bold")),
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// }
