import 'package:flutter/material.dart';

import '../../screen/Users/cattegory_screen.dart';
import 'filter.dart';

class ViewAlllatest extends StatefulWidget {
  const ViewAlllatest({super.key});

  @override
  State<ViewAlllatest> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAlllatest> {
  @override
  Widget build(BuildContext context) {
    String selectedItem = 'Move to bag';
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Latest"),
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
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: jeansCategory.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    //   Get.to(() => const Product_deatils());
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
