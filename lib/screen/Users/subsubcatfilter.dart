import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../Api/productlistbysubsubcat.dart';

enum Gender { male, female, other }

late final w;
late final h;

class SubsubFilter extends StatefulWidget {
  final subsubcatid;
  const SubsubFilter({Key? key, required this.subsubcatid}) : super(key: key);

  @override
  State<SubsubFilter> createState() => _SubsubFilterState();
}

class _SubsubFilterState extends State<SubsubFilter> {
  Set<int> selectedIndices = {};
  Set<int> selectedIndices2 = {};
  Set<int> selectedIndices3 = {};
  int selectedIndex = 0;

  List<String> categories2 = [
    "5% off or more",
    "10% off or more",
    "20% off or more",
    "25% off or more",
    "50% off or more"
  ];

  final prodlist = Get.put(fetchInntsubsubCategoryproductList());

  late double _lowerValue = double.parse(
      prodlist.productWithLowestSalePrice["sale_price"].toString());
  late double _upperValue = double.parse(
      prodlist.productWithHighestSalePrice["sale_price"].toString());

  late final double minPrice = double.parse(
      prodlist.productWithLowestSalePrice["sale_price"].toString());
  late final double maxPrice = double.parse(
      prodlist.productWithHighestSalePrice["sale_price"].toString());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Filter",
        ),
      ),
      body: SizedBox(
        height: 900,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildPriceSectionnnn(),
              buildCategorySection2(),
              buildCategorySection3(),
              buildApplyFilterButt(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPriceSectionnnn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 15, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Price",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              buildPriceTexttttttt(),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Column(
          children: [
            buildPriceSlider(),
          ],
        ),
        const SizedBox(height: 31),
      ],
    );
  }

  Widget buildPriceSlider() {
    return RangeSlider(
      values: RangeValues(
        _lowerValue.clamp(minPrice, maxPrice),
        _upperValue.clamp(minPrice, maxPrice),
      ),
      min: minPrice,
      max: maxPrice,
      divisions: ((maxPrice - minPrice) / 100).toInt(),
      onChanged: (RangeValues newValues) {
        setState(() {
          _lowerValue = newValues.start;
          _upperValue = newValues.end;
        });
      },
      onChangeStart: (RangeValues startValues) {},
      onChangeEnd: (RangeValues endValues) {},
      activeColor: const Color(0xff1455ac),
      inactiveColor: Colors.grey,
    );
  }

  Widget buildPriceTexttttttt() {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(
        ' ${_lowerValue.round()} CFA - ${_upperValue.round()} CFA',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget buildApplyFilterButt() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 1),
      child: Container(
        width: double.infinity,
        height: 44,
        decoration: const ShapeDecoration(
          shape: StadiumBorder(),
          color: Color(0xff1455ac),
        ),
        child: ElevatedButton(
          onPressed: () async {
            print("ggmldsgm;lmgsfd${widget.subsubcatid}");
            await prodlist.subsubcatprofilter(
                discount: selectedIndices2 == 0
                    ? "5"
                    : selectedIndices2 == 1
                        ? "10"
                        : selectedIndices2 == 2
                            ? "20"
                            : selectedIndices2 == 3
                                ? "25"
                                : selectedIndices2 == 4
                                    ? "50"
                                    : null,
                price1: double.parse(_upperValue.toString()),
                price: double.parse(_lowerValue.toString()),
                rating: selectedIndices3 == 0
                    ? "1"
                    : selectedIndices3 == 1
                        ? "2"
                        : selectedIndices3 == 2
                            ? "3"
                            : selectedIndices3 == 3
                                ? "4"
                                : selectedIndices3 == 4
                                    ? "5"
                                    : null,
                subsubid: widget.subsubcatid);
            Get.back();
            // Add your onPressed logic here
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(327, 44),
            backgroundColor: Colors.transparent,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "Apply Filter",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget buildCategorySection2() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Discount",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 6.0,
                children: categories2
                    .map((category) => buildColoredButtonnn2(category))
                    .toList(),
              ),
              const SizedBox(height: 1),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildColoredButtonnn2(String text) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          int index = categories2.indexOf(text);
          if (selectedIndices2.contains(index)) {
            selectedIndices2.remove(index);
          } else {
            selectedIndices2.add(index);
          }
        });
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: selectedIndices2.contains(categories2.indexOf(text))
            ? const Color(0xff1455ac)
            : Colors.black,
        backgroundColor: selectedIndices2.contains(categories2.indexOf(text))
            ? const Color(0xff1455ac)
            : Colors.white,
        side: BorderSide(
            color: selectedIndices2.contains(categories2.indexOf(text))
                ? const Color(0xff1455ac)
                : Colors.black),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selectedIndices2.contains(categories2.indexOf(text))
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }

  Widget buildCategorySection3() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16, top: 25, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Customer Review",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          GridView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            // padding: EdgeInsets.all(4),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: (MediaQuery.of(context).size.width / 1) /
                  (MediaQuery.of(context).size.height / 9),
            ),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade300, blurRadius: 1)
                    ]),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (selectedIndices3.contains(index)) {
                        selectedIndices3.remove(index);
                      } else {
                        selectedIndices3.clear();
                        selectedIndices3.add(index);
                      }
                    });
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(120, 40),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set states) {
                        return selectedIndices3.contains(index)
                            ? const Color(0xff1455ac)
                            : Colors.white;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set states) {
                        return selectedIndices3.contains(index)
                            ? Colors.white
                            : Colors.black;
                      },
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: selectedIndices3.contains(index)
                            ? const Color(0xff1455ac)
                            : Colors.black,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        initialRating: index + 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true, ignoreGestures: true,
                        itemCount: 5,
                        itemSize: 15,
                        // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Text(
                        " & up",
                        style: TextStyle(
                            color: selectedIndices3.contains(index)
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 37),
        ],
      ),
    );
  }

  // Widget buildColoredButtonnn3(String text) {
  //   int index = categories3.indexOf(text);
  //
  //   double screenWidth = MediaQuery.of(context).size.width;
  //   double containerWidth = (screenWidth - 12) / 2.2;
  //   return
  //     ListView.builder(
  //       physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: 4,
  //       itemBuilder: (context, index) {
  //       return Container(
  //         width: containerWidth,
  //         child:
  //         ElevatedButton(
  //           onPressed: () {
  //             setState(() {
  //               if (selectedIndices3.contains(index)) {
  //                 selectedIndices3.remove(index);
  //               } else {
  //                 selectedIndices3.add(index);
  //               }
  //             });
  //           },
  //           style: ButtonStyle(
  //             minimumSize: MaterialStateProperty.all(
  //               Size(120, 40),
  //             ),
  //             backgroundColor: MaterialStateProperty.resolveWith<Color>(
  //                   (Set<MaterialState> states) {
  //                 return selectedIndices3.contains(index)
  //                     ? Color(0xff1455ac)
  //                     : Colors.white;
  //               },
  //             ),
  //             foregroundColor: MaterialStateProperty.resolveWith<Color>(
  //                   (Set<MaterialState> states) {
  //                 return selectedIndices3.contains(index)
  //                     ? Colors.white
  //                     : Colors.black;
  //               },
  //             ),
  //             side: MaterialStateProperty.all(
  //               BorderSide(
  //                 color: selectedIndices3.contains(index)
  //                     ? Color(0xff1455ac)
  //                     : Colors.black,
  //               ),
  //             ),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               RatingBar.builder(
  //                 initialRating: 3,
  //                 minRating: 1,
  //                 direction: Axis.horizontal,
  //                 allowHalfRating: true,ignoreGestures: true,
  //                 itemCount: 5,
  //                 itemSize: 15,
  //                 // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
  //                 itemBuilder: (context, _) => Icon(
  //                   Icons.star,
  //                   color: Colors.amber,
  //                 ),
  //                 onRatingUpdate: (rating) {},
  //               ),
  //
  //               Text(
  //                 text,
  //                 style: TextStyle(
  //                     color: selectedIndices3.contains(index)
  //                         ? Colors.white
  //                         : Colors.black),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },);
  //
  // }
}
