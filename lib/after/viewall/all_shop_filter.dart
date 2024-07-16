import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inntuser/ulits/constant.dart';

enum Gender { male, female, other }

class Filterallshop extends StatefulWidget {
  const Filterallshop({Key? key}) : super(key: key);

  @override
  State<Filterallshop> createState() => _FilterState();
}

class _FilterState extends State<Filterallshop> {
  final double _rating = 0;
  Set<int> selectedIndices = {};
  Set<int> selectedIndices2 = {};
  Set<int> selectedIndices3 = {};
  int selectedIndex = 0;

  List<String> categories = [
    "Hair",
    "Makeup",
    "Haircoloring",
    "Spa",
    "Facial",
    "Facial Makeup",
    "Saving",
  ];
  List<String> categories2 = [
    "10% off or more",
    "20% off or more",
    "25% off or more",
    "5% off or more",
    "10% off or more",
  ];
  List<String> categories3 = [
    "& up",
    "& pu",
    "& kk",
  ];

  double _lowerValue = 10000.0;
  double _upperValue = 20000.0;

  double _lowerValueee = 5.0;
  double _upperValueee = 10.0;
  List<double> priceRanges = [500, 1000, 2000, 5000, 10000, 20000];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF8F8F8),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Filter",
            style: TextStyle(fontSize: 17, color: Colors.black)),
      ),
      body: SizedBox(
        height: 900,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCategorySection(),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Distance",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(
                      'Range: ${_lowerValueee.round()} - ${_upperValueee.round()} km',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding:
                    const EdgeInsets.only(left: 4.0, right: 16, bottom: 20),
                child: RangeSlider(
                  values: RangeValues(_lowerValueee, _upperValueee),
                  min: 5,
                  max: 10,
                  onChanged: (RangeValues newValues) {
                    // Ensure the new values are within the valid range
                    if (newValues.start >= 5 && newValues.end <= 10) {
                      setState(() {
                        _lowerValueee = newValues.start;
                        _upperValueee = newValues.end;
                      });
                    }
                  },
                  onChangeStart: (RangeValues startValues) {},
                  onChangeEnd: (RangeValues endValues) {},
                  activeColor: logocolo,
                  inactiveColor: Colors.grey,
                ),
              ),
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
          padding: const EdgeInsets.only(left: 14.0, right: 15),
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
    const double minPrice = 10000;
    const double maxPrice = 20000;

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
          onPressed: () {
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

  Widget buildCategorySection() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Categories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 6.0,
                children: categories
                    .map((category) => buildColoredButtonnn(category))
                    .toList(),
              ),
              const SizedBox(height: 37),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildColoredButtonnn(String text) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          if (selectedIndices.contains(categories.indexOf(text))) {
            selectedIndices.remove(categories.indexOf(text));
          } else {
            selectedIndices.add(categories.indexOf(text));
          }
        });
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: selectedIndices.contains(categories.indexOf(text))
            ? const Color(0xff1455ac)
            : Colors.black,
        backgroundColor: selectedIndices.contains(categories.indexOf(text))
            ? const Color(0xff1455ac)
            : Colors.white,
        side: BorderSide(
            color: selectedIndices.contains(categories.indexOf(text))
                ? const Color(0xff1455ac)
                : Colors.black),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selectedIndices.contains(categories.indexOf(text))
              ? Colors.white
              : Colors.black,
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
          Wrap(
            spacing: 6.0,
            runSpacing: 8.0,
            children: categories3
                .map((category) => buildColoredButtonnn3(category))
                .toList(),
          ),
          const SizedBox(height: 37),
        ],
      ),
    );
  }

  Widget buildColoredButtonnn3(String text) {
    int index = categories3.indexOf(text);

    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = (screenWidth - 12) / 2.5;
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: SizedBox(
        width: containerWidth,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if (selectedIndices3.contains(index)) {
                selectedIndices3.remove(index);
              } else {
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
            children: [
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 15,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                    color: selectedIndices3.contains(index)
                        ? Colors.white
                        : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
