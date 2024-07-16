// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inntuser/ulits/constant.dart';
//
// import '../../after/viewall/filter.dart';
//
// class HomeSubcate extends StatefulWidget {
//   const HomeSubcate({super.key});
//
//   @override
//   State<HomeSubcate> createState() => _HomeSubcateState();
// }
//
// class _HomeSubcateState extends State<HomeSubcate> {
//   //List<bool> _isExpandedList = List.generate(subcatename.length, (index) => false);
// // List expanded=[0];
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Sub Categories"),
//         // automaticallyImplyLeading: false,
//         backgroundColor: logocolo,
//       ),
//       body: SingleChildScrollView(
//           child: Padding(
//         padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
//         child: Column(
//           children: [
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: subcatename.length,
//               itemBuilder: (context, subcate1) => Theme(
//                 data: theme,
//                 child: Card(
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   child: ExpansionTile(
//                     //initiallyExpanded: true,
//                     //initiallyExpanded: _isExpandedList[subcate1],
//                     onExpansionChanged: (isExpanded) {
//                       // Update the list of expansion states when a tile is expanded or collapsed
//                       // setState(() {
//                       //   _isExpandedList = List.generate(subcatename.length, (i) => i == subcate1 ? isExpanded : false);
//                       // });
//                     },
//                     iconColor: Colors.black,
//                     collapsedShape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     collapsedBackgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     title: Text(
//                       subcatename[subcate1],
//                       style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     backgroundColor: Colors.white,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(right: 8.0, left: 8),
//                         child: ListView.builder(
//                           itemCount: subcatebyname[subcate1].length,
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return GestureDetector(
//                               onTap: () {
//                                 Get.to(const Filter());
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.only(bottom: 10.0),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(0)),
//                                   padding: const EdgeInsets.all(10),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         subcatebyname[subcate1]
//                                             .elementAt(index)
//                                             .toString(),
//                                         style: TextStyle(color: Colors.black),
//                                       ),
//                                       const Icon(Icons.arrow_right)
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }
