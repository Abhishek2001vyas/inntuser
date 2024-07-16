import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../Api/favoriteshop_api.dart';

class favSellerfilter extends StatefulWidget {
  final higher;
  final lower;
  const favSellerfilter({super.key, this.higher, this.lower});

  @override
  State<favSellerfilter> createState() => _favSellerfilterState();
}

class _favSellerfilterState extends State<favSellerfilter> {
  final double _rating = 0;
  Set selectedIndices = {};
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
  late final double minPrice = double.parse(widget.lower.toString());
  late final double maxPrice = double.parse(widget.higher.toString());
  late double _lowerValue = double.parse(widget.lower.toString());
  late double _upperValue = double.parse(widget.higher.toString());
  final favshop = Get.put(Inntfavoriteshop());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.only(left: 14.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Distance",
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
      divisions: (100).toInt(),
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
        ' ${_lowerValue.round()} - ${_upperValue.round()} KM',
        style: const TextStyle(fontSize: 16),
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
            await favshop.favsellerfilter(
              distances1: _lowerValue.toString(),
              distances2: _upperValue.toString(),
              rating: selectedIndices3.isEmpty
                  ? "0"
                  : selectedIndices3.contains(0)
                      ? "1"
                      : selectedIndices3.contains(1)
                          ? "2"
                          : selectedIndices3.contains(2)
                              ? "3"
                              : selectedIndices3.contains(3)
                                  ? "4"
                                  : selectedIndices3.contains(4)
                                      ? "5"
                                      : null,
            );
            Get.back();
            // } else {
            //   Utils().sendMassage('please selecte rating');
            // }
            //
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

  Widget buildColoredButtonnn2(String text) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          int index = categories2.indexOf(text);
          if (selectedIndices2.contains(index)) {
            selectedIndices2.remove(index);
          } else {
            selectedIndices2.clear();
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
}
