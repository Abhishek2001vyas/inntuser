import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/productdeatils.dart';

import '../../screen/Users/cattegory_screen.dart';
import 'filter.dart';

class ViewAllarrival extends StatefulWidget {
  const ViewAllarrival({super.key});

  @override
  State<ViewAllarrival> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAllarrival> {
  @override
  Widget build(BuildContext context) {
    String selectedItem = 'Move to bag';
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("New arrivals"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Filter(),
                  ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.grid_view_rounded),
            onPressed: () {
              // Add your shopping cart icon onPressed logic here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                // padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade300, blurRadius: 3)
                    ]),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/camera.png",
                        height: h / 5,
                        width: w / 3,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: w / 70,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: w / 1.8,
                          child: Text(
                            "A product description is the marketing copy on each product page that explains what a product is and why a shopper should buy it. The purpose of a product description is to give your customers any important information about a product that they are interested in buying, along with any other reasons they should purchase the product.",
                            maxLines: 7,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Amazon_med",
                            ),
                          ),
                        ),
                        const Text(
                          "\$33",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Amazon_med",
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: jeansCategory.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => const Product_deatils(conn: 0,sourceName: "0",));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
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
                                            child: Image.asset(
                                              "assets/images/jeans1.png",
                                              fit: BoxFit.cover,
                                              height: h / 6,
                                              width: w / 2,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: SizedBox(
                                              width: w / 4,
                                              child: Text(
                                                jeansCategory[index]
                                                    ["products"],
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: "Amazon_med",
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 4),
                                            child: SizedBox(
                                              width: w / 4,
                                              child: const Text(
                                                "\$786",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily: "Ember_Light",
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: h / 100),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: w / 100),
                                  Expanded(
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
                                            child: Image.asset(
                                              "assets/images/jeans1.png",
                                              fit: BoxFit.cover,
                                              height: h / 6,
                                              width: w / 2,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: SizedBox(
                                              width: w / 4,
                                              child: Text(
                                                jeansCategory[index]
                                                    ["products"],
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: "Amazon_med",
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: SizedBox(
                                              width: w / 4,
                                              child: const Text(
                                                "\$786",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: "Ember_Light",
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: h / 100),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: h / 80),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
