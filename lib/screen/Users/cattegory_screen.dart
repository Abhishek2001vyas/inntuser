import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/productList_api.dart';
import '../../models/productListModel.dart';

class CategoryScreen extends StatefulWidget {
  final categoryId;

  const CategoryScreen({super.key, this.categoryId});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

List jeansCategory = [
  {
    "image": "assets/images/makeup.png",
    "products": "Jock & Jones",
    "types": "Low Rise Straight Fit Jeans",
    "price": "\$ 1400",
    "discount": "\$ 3999",
    "offer": "65% Off"
  },
  {
    "image": "assets/images/makeup.png",
    "products": "Jock & Jones",
    "types": "Low Rise Straight Fit Jeans",
    "price": "\$ 2000",
    "discount": "\$ 9999",
    "offer": "70% Off"
  },
  {
    "image": "assets/images/makeup.png",
    "products": "Jock & Jones",
    "types": "Low Rise Straight Fit Jeans",
    "price": "\$ 1500",
    "discount": "\$ 5999",
    "offer": "30% Off"
  },
  {
    "image": "assets/images/makeup.png",
    "products": "Jock & Jones",
    "types": "Low Rise Straight Fit Jeans",
    "price": "\$ 1200",
    "discount": "\$ 4999",
    "offer": "50% Off"
  },
  {
    "image": "assets/images/makeup.png",
    "products": "Jock & Jones",
    "types": "Low Rise Straight Fit Jeans",
    "price": "\$ 1400",
    "discount": "\$ 3999",
    "offer": "65% Off"
  },
  {
    "image": "assets/images/makeup.png",
    "products": "Jock & Jones",
    "types": "Low Rise Straight Fit Jeans",
    "price": "\$ 2000",
    "discount": "\$ 9999",
    "offer": "70% Off"
  },
  {
    "image": "assets/images/makeup.png",
    "products": "Jock & Jones",
    "types": "Low Rise Straight Fit Jeans",
    "price": "\$ 1500",
    "discount": "\$ 5999",
    "offer": "30% Off"
  },
  {
    "image": "assets/images/makeup.png",
    "products": "Jock & Jones",
    "types": "Low Rise Straight Fit Jeans",
    "price": "\$ 1200",
    "discount": "\$ 4999",
    "offer": "50% Off"
  },
];

class _CategoryScreenState extends State<CategoryScreen> {
  final getProductList_api = Get.put(fetchProductList());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // centerTitle: true,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jeans",
            ),
            Text(
              "2000 Products",
              style: TextStyle(
                  fontFamily: "Ember_Light", color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        actions: const [
          Icon(
            Icons.search,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.filter_list,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            FutureBuilder<List<ProductListModel>>(
                future: getProductList_api.productList(widget.categoryId),
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
                    return getProductList_api.productCategoryList.isEmpty
                        ? Center(
                            child: Image.asset(
                                "assets/images/out-of-stock-9832079-8049857-ezgif.com-video-to-gif-converter.gif",
                                scale: 3),
                          )
                        : GridView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: MediaQuery.of(context)
                                      .size
                                      .width /
                                  (MediaQuery.of(context).size.height / 1.2),
                            ),
                            itemCount:
                                getProductList_api.productCategoryList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade200,
                                          blurRadius: 2)
                                    ]),
                                child: Stack(children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: Image.network(
                                          "$image_url${getProductList_api.productCategoryList[index].image1.toString()}",
                                          fit: BoxFit.cover,
                                          height: h / 3.9,
                                          width: w / 2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: h / 90,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              getProductList_api
                                                  .productCategoryList[index]
                                                  .productName
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontFamily: "Amazon_bold",
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              maxLines: 1,
                                            ),
                                            SizedBox(
                                              height: h / 90,
                                            ),
                                            Text(
                                              getProductList_api
                                                  .productCategoryList[index]
                                                  .description
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontFamily: "Ember_Light",
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              maxLines: 1,
                                            ),
                                            SizedBox(
                                              height: h / 90,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${getProductList_api.productCategoryList[index].mrpPrice} CFA',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontFamily: "Amazon_bold",
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  width: w / 60,
                                                ),
                                                Text(
                                                  '${getProductList_api.productCategoryList[index].salePrice} CFA',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontFamily: "Amazon_bold",
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  width: w / 60,
                                                ),
                                                Text(
                                                  '${getProductList_api.productCategoryList[index].discountPercentage}% Off',
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.green,
                                                      fontFamily: "Amazon_bold",
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  maxLines: 1,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Positioned(
                                      child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: logocolo,
                                    ),
                                    child: const Text(
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
                                ]),
                              );
                            },
                          );
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
