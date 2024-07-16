import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../ulits/constant.dart';
import '../../Api/addressList_api.dart';
import '../../Api/get_bannerlist_api.dart';
import '../../Api/inntOutcategoryList_api.dart';
import '../../Api/inntoutshoplistmap.dart';
import '../Users/home.dart';
import 'Innoutshoplistmapsloctions.dart';
import 'Innt_Out_productlistbycate.dart';
import 'Searchinnoutproduct.dart';

class InntOutHome extends StatefulWidget {
  final current;
  const InntOutHome({super.key, this.current});

  @override
  State<InntOutHome> createState() => _InntOutHomeState();
}

class _InntOutHomeState extends State<InntOutHome> {
  final getInntOutCategory_api = Get.put(fetchInntOutCategoryList());

  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  final double _volume = 100;
  final bool _muted = false;
  final bool _isPlayerReady = false;
  final shopmapss = Get.put(Inntoutshopmap());
  final List<String> _ids = ["yg8116aeD7E"];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
          mute: true,
          autoPlay: false,
          disableDragSeek: true,
          loop: true,
          isLive: false,
          forceHD: false,
          enableCaption: true,
          showLiveFullscreenButton: false),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  int currentindex = 0;
  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  final Address_api addressList = Get.put(Address_api());
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   // Status bar color
        //   statusBarColor: secondryColor,
        // ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: Image.asset(
              "assets/images/back.png",
              fit: BoxFit.cover,
              height: 5,
              width: 5,
            ),
          ),
        ),
        backgroundColor: secondryColor,
        elevation: 0,
        // forceMaterialTransparency: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: h / 25,
              width: w / 1.5,
              child: TextFormField(
                onTap: () {
                  Get.to(const HomeSearchinnout());
                },
                readOnly: true,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    hintText: "Search in innt out",
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    fillColor: const Color(0xffeef1f5),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(7))),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await shopmapss.InntoutshopmapList();

                Get.to(() => const Locationinntout());
                /*map scrren thi*/
              },
              child: Image.asset(
                "assets/images/mapinntout.png",
                fit: BoxFit.fill,
                height: h / 25,
                width: w / 15,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // InkWell(
            //   onTap: () {
            //     Get.to(const AddressScreen());
            //   },
            //   child: Container(
            //       padding: const EdgeInsets.only(left: 70, bottom: 5),
            //       width: w,
            //       decoration: const BoxDecoration(color: secondryColor),
            //       child: Row(
            //         children: [
            //           const Icon(
            //             Icons.location_on_outlined,
            //             color: Colors.black,
            //           ),
            //           FutureBuilder(
            //             future: addressList.getAddressListApi(),
            //             builder: (context, snapshot) {
            //               return Obx(() => addressList.addressList.isEmpty ||
            //                       addressList.addressList[0].isEmpty
            //                   ? Text(
            //                       "Deliver to :- ${currentAddress11 ?? ""}",
            //                       maxLines: 1,
            //                       style: const TextStyle(
            //                           fontSize: 15,
            //                           fontFamily: "Amazon_bold",
            //                           fontWeight: FontWeight.bold),
            //                     )
            //                   : Text(
            //                       "Deliver to :- ${addressList.addressList[0][0]["place_type"] ?? currentAddress11}",
            //                       style: const TextStyle(
            //                           fontSize: 15,
            //                           fontFamily: "Amazon_bold",
            //                           fontWeight: FontWeight.bold),
            //                     ));
            //             },
            //           )
            //         ],
            //       )),
            // ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: getInntOutCategory_api.inntOutCategoryList(),
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
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Categories",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Amazon_Bold",
                                            fontSize: 16)),
                                    Text(
                                      AppLocalizations.of(context)!.viewall,
                                      style: TextStyle(
                                          //letterSpacing: 1.5,
                                          //color: Colors.white,
                                          color: Colors.blue,
                                          fontFamily: "Amazon_med",
                                          fontSize: 14),
                                    ),
                                  ]),
                              SizedBox(
                                height: h / 50,
                              ),
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: getInntOutCategory_api
                                            .inntOutCategory.length >=
                                        8
                                    ? 8
                                    : getInntOutCategory_api
                                        .inntOutCategory.length,
                                // homeapi.newarrivallist.elementAt(0).data!.length >=4 ? 4: homeapi.newarrivallist.elementAt(0).data!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.3),
                                ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(Inntout_Productlist(
                                        inntoutcateid: getInntOutCategory_api
                                            .inntOutCategory[index].sId
                                            .toString(),
                                      ));
                                      //  Get.to(() => const InntOutInformationShop());
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            onBackgroundImageError:
                                                (exception, stackTrace) {
                                              Text("Loadin.....");
                                            },
                                            maxRadius: 40,
                                            backgroundColor: logocolo,
                                            backgroundImage: NetworkImage(
                                              "$image_url${getInntOutCategory_api.inntOutCategory[index].categoryImage.toString()}",
                                            ),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(12.0),
                                        //   child: ClipRRect(
                                        //     borderRadius:
                                        //         BorderRadius.circular(80),
                                        //     child: Image.network(
                                        //       errorBuilder: (context, error,
                                        //           stackTrace) {
                                        //         return Text("Loading....");
                                        //       },
                                        //       "$image_url${getInntOutCategory_api.inntOutCategory[index].categoryImage.toString()}",
                                        //       height: 80,
                                        //       width: 80,
                                        //       fit: BoxFit.cover,
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          width: w / 4,
                                          child: Text(
                                            getInntOutCategory_api
                                                .inntOutCategory[index]
                                                .categoryEnglishName
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Amazon_med",
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ]);
                      }
                    })),
            SizedBox(
              height: h / 90,
            ),
            Stack(children: [
              inntoutheaderbannerlist[0].isEmpty
                  ? const SizedBox()
                  : CarouselSlider.builder(
                      itemCount: inntoutheaderbannerlist[0].length,
                      itemBuilder: (context, index, realIndex) {
                        var findvideo = inntoutheaderbannerlist[0][index]
                                ["banner_image"]
                            .split('.')
                            .last
                            .toLowerCase();

                        if (findvideo == "mp4" ||
                            findvideo == "mov" ||
                            findvideo == "avi" ||
                            findvideo == "mkv") {
                          return VideoWithImagePlaceholder(
                            videoUrl:
                                "$image_url${inntoutheaderbannerlist[0][index]["banner_image"].toString()}",
                          );
                        } else {
                          return Center(
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 2,
                              child: Container(
                                  width: double.infinity,
                                  height: h / 4,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color(0xff0e18cf).withOpacity(.8),
                                  ),
                                  child: ClipRRect(
                                      child: Image.network(
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                          child: Text(
                                        "Loading .....",
                                        style: TextStyle(color: Colors.white),
                                      ));
                                    },
                                    "$image_url${inntoutheaderbannerlist[0][index]["banner_image"]}",
                                    fit: BoxFit.fill,
                                  ))),
                            ),
                          );
                        }
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          // setState(() {
                          //   currentindex = index;
                          // });
                        },

                        aspectRatio: 1.8,
                        // height: 170,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        // aspectRatio: 10 / 15,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 1,
                      ),
                    ),
            ]),
            SizedBox(
              height: h / 80,
            ),
            // const Padding(
            //   padding: EdgeInsets.all(4.0),
            //   child: Text("Today's offers",
            //       style: TextStyle(
            //           //letterSpacing: 1.5,
            //           color: Colors.black,
            //           fontFamily: "Amazon_Bold",
            //           fontSize: 16)),
            // ),

            FutureBuilder(
                future: homeapi.dayoffer(),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : homeapi.todayofferlist.isEmpty ||
                              homeapi.todayofferlist
                                  .elementAt(0)["data"]
                                  .isEmpty
                          ? SizedBox()
                          : Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Today's offers",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Amazon_Bold",
                                              fontSize: 16)),
                                      Text(
                                        AppLocalizations.of(context)!.viewall,
                                        style: TextStyle(
                                            //letterSpacing: 1.5,
                                            //color: Colors.white,
                                            color: Colors.blue,
                                            fontFamily: "Amazon_med",
                                            fontSize: 14),
                                      ),
                                    ]),
                                SizedBox(
                                  height: h / 80,
                                ),
                                Dealofday(h: h, w: w),
                              ],
                            );
                }),
            SizedBox(
              height: h / 90,
            ),
            FutureBuilder(
              future: homeapi.advertisementProduct_list_List1(),
              builder: (context, snapshot) {
                return Obx(
                    () => homeapi.advertisementProduct_listList.isEmpty ||
                            homeapi.advertisementProduct_listList1[0]["data"]
                                .isEmpty
                        ? const SizedBox()
                        : Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 3)
                                ]),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    //homeapi.advertisementProduct_listList1[0]["data"][0]['image1']
                                    "$image_url${homeapi.advertisementProduct_listList1[0]["data"][0]['image1']}",
                                    height: h / 5,
                                    width: w / 3,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: w / 70,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: w / 1.8,
                                      child: Text(
                                        "${homeapi.advertisementProduct_listList1[0]["data"][0]["description"]}",
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Amazon_med",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h / 70,
                                    ),
                                    Container(
                                      width: w / 3.5,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.yellow.shade700,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // SizedBox(width: w/20,),
                                          const Icon(
                                            Icons.star,
                                            size: 16,
                                            color: white,
                                          ),
                                          SizedBox(
                                            child: Text(
                                              "${homeapi.advertisementProduct_listList1[0]["data"][0]["rating"]}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(width: w / 100),
                                          Text(
                                            "(${homeapi.advertisementProduct_listList1[0]["data"][0]["raters"]})",
                                            style: const TextStyle(
                                                fontSize: 12, color: white),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: h / 70,
                                    ),
                                    Text(
                                      "${homeapi.advertisementProduct_listList1[0]["data"][0]["sales"]} sales",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontFamily: "Amazon_med",
                                      ),
                                    ),
                                    SizedBox(
                                      height: h / 70,
                                    ),
                                    Text(
                                      "${homeapi.advertisementProduct_listList1[0]["data"][0]["sale_price"]} CFA",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Amazon_med",
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                    // Container(
                    //         padding: const EdgeInsets.all(4),
                    //         decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(8),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                   color: Colors.grey.shade300,
                    //                   blurRadius: 3)
                    //             ]),
                    //         child: Row(
                    //           children: [
                    //             ClipRRect(
                    //               borderRadius: BorderRadius.circular(8),
                    //               child: Image.network(
                    //                 "$image_url${homeapi.advertisementProduct_listList1[0]["data"][0]['image1']}",
                    //                 height: h / 5,
                    //                 width: w / 3,
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: w / 70,
                    //             ),
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 SizedBox(
                    //                   width: w / 1.8,
                    //                   child: Text(
                    //                     "${homeapi.advertisementProduct_listList1[0]["data"][0]["description"]}",
                    //                     softWrap: true,
                    //                     maxLines: 7,
                    //                     overflow: TextOverflow.ellipsis,
                    //                     style: TextStyle(
                    //                       fontSize: 15,
                    //                       color: Colors.grey.shade500,
                    //                       fontWeight: FontWeight.w400,
                    //                       fontFamily: "Amazon_med",
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   "\$${homeapi.advertisementProduct_listList1[0]["data"][0]["sale_price"]}",
                    //                   maxLines: 1,
                    //                   overflow: TextOverflow.ellipsis,
                    //                   style: const TextStyle(
                    //                     fontSize: 15,
                    //                     fontWeight: FontWeight.w700,
                    //                     fontFamily: "Amazon_med",
                    //                   ),
                    //                 )
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //       )
                    );
              },
            ),
            SizedBox(
              height: h / 50,
            ),
            Stack(children: [
              inntoutfooterbannerlist[0].isEmpty
                  ? const SizedBox()
                  : CarouselSlider.builder(
                      itemCount: inntoutfooterbannerlist[0].length,
                      itemBuilder: (context, index, realIndex) {
                        var findvideo = inntoutfooterbannerlist[0][index]
                                ["banner_image"]
                            .split('.')
                            .last
                            .toLowerCase();
                        if (findvideo == "mp4" ||
                            findvideo == "mov" ||
                            findvideo == "avi" ||
                            findvideo == "mkv") {
                          return VideoWithImagePlaceholder(
                            videoUrl:
                                "$image_url${inntoutfooterbannerlist[0][index]["banner_image"].toString()}",
                          );
                        } else {
                          return Center(
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 2,
                              child: Container(
                                  width: double.infinity,
                                  height: h / 4,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color(0xff0e18cf).withOpacity(.8),
                                  ),
                                  child: ClipRRect(
                                      child: Image.network(
                                    errorBuilder:
                                        (context, error, stackTrace) => Center(
                                            child: Text(
                                      "Loading .....",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                    "$image_url${inntoutfooterbannerlist[0][index]["banner_image"]}",
                                    fit: BoxFit.fill,
                                  ))),
                            ),
                          );
                        }
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          /* setState(() {
                      _currentIndex02 = index;
                    });*/
                        },

                        aspectRatio: 1.8,
                        // height: 170,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        // aspectRatio: 10 / 15,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 1,
                      ),
                    ),
            ]),
            SizedBox(
              height: h / 90,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: homeapi.topsaleinnout(),
                builder: (context, snapshot) {
                  return homeapi.topsaleiinntout.isNotEmpty &&
                          homeapi.topsaleiinntout.elementAt(0).data!.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Top sales of the week",
                                style: TextStyle(
                                    //letterSpacing: 1.5,
                                    color: Colors.black,
                                    fontFamily: "Amazon_Bold",
                                    fontSize: 16)),
                            SizedBox(
                              height: h / 80,
                            ),
                            SizedBox(
                              height: h / 4.2,
                              width: w,
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: homeapi.topsaleiinntout
                                            .elementAt(0)
                                            .data!
                                            .length >=
                                        6
                                    ? 6
                                    : homeapi.topsaleiinntout
                                        .elementAt(0)
                                        .data!
                                        .length,
                                // homeapi.newarrivallist.elementAt(0).data!.length >=4 ? 4: homeapi.newarrivallist.elementAt(0).data!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.2),
                                ),

                                // itemCount: homeapi.topsaleiinntout
                                //     .elementAt(0)
                                //     .data!
                                //     .length,
                                // scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Get.to(() => InntOutProduct_deatils());
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              "$image_url${homeapi.topsaleiinntout.elementAt(0).data!.elementAt(index).image1.toString()}",
                                              height: h / 5,
                                              width: w / 2.8,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          homeapi.topsaleiinntout
                                              .elementAt(0)
                                              .data!
                                              .elementAt(index)
                                              .productName
                                              .toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Amazon_med",
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      /*    GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    // padding: EdgeInsets.all(4),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: (MediaQuery.of(context).size.width / 1) /
                          (MediaQuery.of(context).size.height / 1.7),
                    ),
                    itemCount:
                    homeapi.newarrivallist.elementAt(0).data!.length >=4 ? 4: homeapi.newarrivallist.elementAt(0).data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child:

                        GestureDetector(
                          onTap: () {
                            Get.to( Product_deatils(conn:"0.0" ,subsubcateid: homeapi.newarrivallist.elementAt(0).data!.elementAt(index).productId ,shopid:  homeapi.newarrivallist.elementAt(0).data!.elementAt(index).venderId,));
                          },
                          child: Container(
                            margin: EdgeInsets.all(4),
                            width: w * 2 / 6,
                            height: h / 1,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.shade300, blurRadius: 1)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: h / 5.5,
                                      width: w / 1,
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              topLeft: Radius.circular(8)),
                                          child: Image.network("$image_url${ homeapi.newarrivallist.elementAt(0).data!.elementAt(index).image1}",
                                              fit: BoxFit.fitHeight)),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: w / 2.5,
                                        child: Text(
                                          homeapi.newarrivallist.elementAt(0).data!.elementAt(index).productName.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Amazon_med",
                                          ),
                                        ),
                                      ),

                                      Text(
                                        "\$${ homeapi.newarrivallist.elementAt(0).data!.elementAt(index).salePrice}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Emebr_light",
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )*/
                      : const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Dealofday extends StatelessWidget {
  const Dealofday({
    super.key,
    required this.h,
    required this.w,
  });

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h / 4,
      width: double.infinity,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: homeapi.todayofferlist.elementAt(0)["data"]!.length >= 6
            ? 6
            : homeapi.todayofferlist.elementAt(0)["data"]!.length,
        // homeapi.newarrivallist.elementAt(0).data!.length >=4 ? 4: homeapi.newarrivallist.elementAt(0).data!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.2),
        ),

        // shrinkWrap: true,
        // // physics: NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.horizontal,
        // itemCount: homeapi.todayofferlist.elementAt(0)["data"]!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Get.to(Product_deatils(
              //   subsubcateid: homeapi.todayofferlist
              //       .elementAt(0)
              //       .data!
              //       .elementAt(index)
              //       .productId
              //       .toString(),
              //   shopid: homeapi.todayofferlist
              //       .elementAt(0)
              //       .data!
              //       .elementAt(index)
              //       .venderId
              //       .toString(),
              // ));
            },
            child: Container(
              margin: const EdgeInsets.all(4),
              width: w * 2 / 6,
              // Adjusted width to show 2/5 of the screen width
              height: h / 1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 1)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: h / 5.5,
                        width: w / 1,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(8),
                                topLeft: Radius.circular(8)),
                            child: Image.network(
                                "$image_url${homeapi.todayofferlist.elementAt(0)["data"]!.elementAt(index)["image1"].toString()}",
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: logocolo,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Text(
                              "${homeapi.todayofferlist.elementAt(0)["data"]!.elementAt(index)["discount"].toString()}% off",
                              style: const TextStyle(
                                color: Color(0xfffefff7),
                              ),
                            )),
                          ),
                          // Container(
                          //   margin: EdgeInsets.all(4),
                          //   padding: EdgeInsets.all(4),
                          //   decoration: BoxDecoration(
                          //       color: Colors.white, shape: BoxShape.circle),
                          //   child: const Icon(
                          //     CupertinoIcons.heart,
                          //     color: Colors.black,
                          //     size: 18,
                          //   ),
                          // )
                        ],
                      ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: w / 2.5,
                          child: Text(
                            homeapi.todayofferlist
                                .elementAt(0)["data"]!
                                .elementAt(index)["product_name"]
                                .toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Amazon_med",
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class VideoWithImagePlaceholder extends StatefulWidget {
  final String videoUrl;

  const VideoWithImagePlaceholder({
    super.key,
    required this.videoUrl,
  });

  @override
  _VideoWithImagePlaceholderState createState() =>
      _VideoWithImagePlaceholderState();
}

class _VideoWithImagePlaceholderState extends State<VideoWithImagePlaceholder> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize().then((value) {
      _controller.play();

      setState(() {});
      _controller.addListener(_videoListener);
    });
  }

  void _videoListener() {
    if (_controller.value.isPlaying) {}
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final he = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    height: he / 4,
                    decoration: BoxDecoration(
                      color: const Color(0xff0e18cf).withOpacity(.8),
                    ),
                    child: ClipRRect(
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
