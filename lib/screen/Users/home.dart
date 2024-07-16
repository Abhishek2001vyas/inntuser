import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inntuser/screen/Users/Navgationbar.dart';
import 'package:inntuser/screen/Users/productdeatils.dart';
import 'package:inntuser/screen/Users/scan_screen.dart';
import 'package:inntuser/screen/Users/subcatebycat.dart';
import 'package:inntuser/screen/Users/view_all_screen.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../Api/Homepageproductlist.dart';
import '../../Api/addressList_api.dart';
import '../../Api/get_bannerlist_api.dart';
import '../../Api/getuserprofile.dart';
import '../../Api/innt_categoryList_api.dart';
import '../../Api/wishlist.dart';
import '../../Controller/text2.dart';
import '../../after/viewall/all_categories.dart';
import '../../language_constant.dart';
import '../../main.dart';
import '../../models/inntCategoryListModel.dart';
import '../innt_out/dashboardinntout.dart';
import 'add_address/homepageaddress.dart';
import 'home_search.dart';

String? currentAddress11;
late LatLng currentLocation;
final wishh = Get.put(wishlist_api());
final homeapi = Get.put(Homepage_api());

class CardWithImage extends StatefulWidget {
  final String imagePath;
  final String topText;
  final String bottomText;

  const CardWithImage({
    super.key,
    required this.imagePath,
    required this.topText,
    required this.bottomText,
  });

  @override
  State<CardWithImage> createState() => _CardWithImageState();
}

final getInntCategory_api = Get.put(fetchInntCategoryList());

class _CardWithImageState extends State<CardWithImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardInntOut(),
                  ));
            },
            child: Card(
              color: Colors.blue.shade50,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.topText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        widget.imagePath,
                        width: 100,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.bottomText,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  late VideoPlayerController controllervideo;
  late Future<void> initializeVideoPlayerFuture;
  // bool _showControls = true;

  void saveAddressToSharedPreferences(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', address);
  }

  Set<Marker> markers = {};
  LatLng? showLocation;
  String address = "Address not found ";

  late LatLng currentLocation1;
  String currentCity = "";

  LatLng get currentLocation0 => currentLocation1;

  Future<void> getCurrentLocation() async {
    print("Get Current Location");
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        locationPermission();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> locationPermission() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentLocation = LatLng(position.latitude, position.longitude);
    setState(() {});
    print("uidhgfhgihfg2");
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      print("uidhgfhgihfg1");
      Placemark placemark = placemarks.first;
      String address =
          '${placemark.subLocality}, ${placemark.locality}\n${placemark.administrativeArea}, ${placemark.country}';
      String city = "${placemark.locality}";
      currentCity = city;
      print("uidhgfhgihfg");
      setState(() {
        currentAddress11 = address;
      });
      print("opkgdofd$currentAddress11");
    }
  }

//  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;
  int currentindex = 0;
  int _currentIndex02 = 0;
  final homeapi = Get.put(Homepage_api());

  @override
  void initState() {
    getCurrentLocation();

    super.initState();

    controllervideo = VideoPlayerController.network('${image_url}video19.mp4');
    initializeVideoPlayerFuture =
        controllervideo.initialize().catchError((error) {
      print("Error initializing video player: $error");
    }).then((_) {
      // Once video has been initialized, start playing it
      //controllervideo.setVolume(_muted ? 0 : 1);
      controllervideo.play();
      controllervideo.setLooping(true);
      setState(() {});
    });

    controllervideo.addListener(_videoListener);
  }

  void _videoListener() {
    if (controllervideo.value.isPlaying) {}
  }

  @override
  void dispose() {
    super.dispose();
    controllervideo.dispose();
  }

  var type;
  final Address_api addressList = Get.put(Address_api());
  final getprofile = Get.put(Getuserprofile_api());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.to(() => const allCategories());
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
          ),
          backgroundColor: logocolo,
          elevation: 0,
          // forceMaterialTransparency: true,
          //Search bar
          title: Container(
            decoration: BoxDecoration(
                color: const Color(0xffeef1f5),
                borderRadius: BorderRadius.circular(7)),
            height: h / 23,
            width: w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const HomeSearch());
                  },
                  child: SizedBox(
                    height: h / 23,
                    width: w / 1.7,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: AppLocalizations.of(context)!.searchininnt,
                        hintStyle: A_style_order,

                        //search icon
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black),
                        fillColor: const Color(0xffeef1f5),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(7)),
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: w/40,),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ScanScreen());
                  },
                  child: Container(
                    height: h / 20,
                    margin: const EdgeInsets.only(left: 7, top: 6, bottom: 6),
                    child: Image.asset(
                      "assets/images/cam1.png",
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //show address
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const homepageAddAddress(),
                    ));
              },
              child: Container(
                  padding: const EdgeInsets.all(8),
                  width: w,
                  height: h / 20,
                  decoration: BoxDecoration(
                      color: darkomdee.darkomde == true
                          ? Colors.black
                          : Colors.blue.shade50),
                  child: FutureBuilder(
                    future: addressList.getAddressListApi2(),
                    builder: (context, snapshot) {
                      print("kkjjjj1 ${addressList.addressList[0]}");
                      addressList.addressList[0].forEach((element) {
                        print("kkjjjj ${element["status"]}");
                        if (element["status"].toString() == "1".toString()) {
                          type = element["place_type"].toString();
                        } else {
                          type =
                              addressList.addressList[0][0]["place_type"] ?? "";
                        }
                        // type = element["status"].toString() == "1".toString()
                        //     ? element["place_type"].toString()
                        //     : addressList.addressList[0][1]["place_type"];
                      });

                      return Obx(() => addressList.addressList.isEmpty ||
                              addressList.addressList[0].isEmpty
                          ? Text(
                              "${AppLocalizations.of(context)!.deliverto} :- ${currentAddress11 ?? ""}",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: darkomdee.darkomde == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontFamily: "Amazon_bold",
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "${AppLocalizations.of(context)!.deliverto} :-  ${getprofile.profiledata[0][0]["first_name"] ?? ""}  ${type}",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: darkomdee.darkomde == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontFamily: "Amazon_bold",
                                  fontWeight: FontWeight.bold),
                            ));
                    },
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardInntOut(),
                    ));
              },
              child: Container(
                  padding: const EdgeInsets.all(8),
                  width: w,
                  height: h / 20,
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: Text(
                    AppLocalizations.of(context)!.inntout,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15,
                        color: darkomdee.darkomde == true
                            ? Colors.white
                            : Colors.black,
                        fontFamily: "Amazon_bold",
                        fontWeight: FontWeight.bold),
                  )),
            ),
            //banner list
            bannerlist.isEmpty || bannerlist[0].isEmpty
                ? const SizedBox()
                : buildCarouselSlider(h),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: h / 50,
                  ),
                  FutureBuilder(
                      future: homeapi.dayOftheDeals_List(),
                      builder: (context, snapshot) {
                        return Obx(() => homeapi
                                    .dayOftheDeals_ProductList.isEmpty ||
                                homeapi.advertisementProduct_listList[0]["data"]
                                    .isEmpty
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context)!.todaydeals,
                                      style: TextStyle(
                                          //letterSpacing: 1.5,
                                          color: darkomdee.darkomde == true
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: "Amazon_Bold",
                                          fontSize: 16)),
                                  InkWell(
                                    onTap: () {
                                      homeapi.homepageprofilter
                                          .add({"result": "0"});
                                      Get.to(() => const ViewAll(
                                            unkey: 1,
                                            textapp: "Today's deals",
                                          ));
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.viewall,
                                      style: TextStyle(
                                          //letterSpacing: 1.5,
                                          //color: Colors.white,
                                          color: Colors.blue,
                                          fontFamily: "Amazon_med",
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ));
                      }),
                  // homeapi.advertisementProduct_listList[0]["data"].isEmpty
                  //     ? SizedBox()
                  //     :
                  SizedBox(
                    height: h / 70,
                  ),
                  FutureBuilder(
                      future: homeapi.dayOftheDeals_List(),
                      builder: (context, snapshot) {
                        return Obx(() => homeapi
                                    .dayOftheDeals_ProductList.isEmpty ||
                                homeapi.advertisementProduct_listList[0]["data"]
                                    .isEmpty
                            ? const SizedBox()
                            : Dealofday(h: h, w: w));
                      }),
                  SizedBox(
                    height: h / 70,
                  ),
                  FutureBuilder(
                    future: homeapi.advertisementProduct_list_List(),
                    builder: (context, snapshot) {
                      return Obx(() =>
                          homeapi.advertisementProduct_listList.isEmpty ||
                                  homeapi
                                      .advertisementProduct_listList[0]["data"]
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
                                          "$image_url${homeapi.advertisementProduct_listList[0]["data"][0]['image1']}",
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: w / 1.8,
                                            child: Text(
                                              "${homeapi.advertisementProduct_listList[0]["data"][0]["description"]}",
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
                                                    "${homeapi.advertisementProduct_listList[0]["data"][0]["rating"]}",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(width: w / 100),
                                                Text(
                                                  "(${homeapi.advertisementProduct_listList[0]["data"][0]["raters"]})",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: white),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: h / 70,
                                          ),
                                          Text(
                                            "${homeapi.advertisementProduct_listList[0]["data"][0]["sales"]} sales",
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
                                            "${homeapi.advertisementProduct_listList[0]["data"][0]["sale_price"]} CFA",
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
                                ));
                    },
                  ),
                  SizedBox(
                    height: h / 70,
                  ),
                  homeapi.newarrivallist.isNotEmpty &&
                          homeapi.newarrivallist[0].data!.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppLocalizations.of(context)!.newarrival,
                                style: TextStyle(
                                    //letterSpacing: 1.5,
                                    color: darkomdee.darkomde == true
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: "Amazon_Bold",
                                    fontSize: 16)),
                            InkWell(
                              onTap: () {
                                //Get.to(() => ViewAll());
                                homeapi.homepageprofilter.add({"result": "0"});
                                Get.to(() => ViewAll(
                                      textapp: AppLocalizations.of(context)!
                                          .newarrival,
                                      unkey: 2,
                                    ));
                              },
                              child: Text(AppLocalizations.of(context)!.viewall,
                                  style: TextStyle(
                                      //letterSpacing: 1.5,
                                      //color: Colors.white,
                                      color: Colors.blue,
                                      fontFamily: "Amazon_med",
                                      fontSize: 14)),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: h / 50,
                  ),
                  FutureBuilder(
                    future: homeapi.newarrival(),
                    builder: (context, snapshot) {
                      return homeapi.newarrivallist.isNotEmpty &&
                              homeapi.newarrivallist[0].data!.isNotEmpty
                          ? GridView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              // padding: EdgeInsets.all(4),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                                childAspectRatio:
                                    (MediaQuery.of(context).size.width / 1) /
                                        (MediaQuery.of(context).size.height /
                                            1.7),
                              ),
                              itemCount: homeapi.newarrivallist
                                          .elementAt(0)
                                          .data!
                                          .length >=
                                      4
                                  ? 4
                                  : homeapi.newarrivallist
                                      .elementAt(0)
                                      .data!
                                      .length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(Product_deatils(
                                        sourceName: "0",
                                        conn: "0.0",
                                        subsubcateid: homeapi.newarrivallist
                                            .elementAt(0)
                                            .data!
                                            .elementAt(index)
                                            .productId,
                                        shopid: homeapi.newarrivallist
                                            .elementAt(0)
                                            .data!
                                            .elementAt(index)
                                            .venderId,
                                      ));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(4),
                                      width: w * 2 / 6,
                                      height: h / 1,
                                      decoration: BoxDecoration(
                                          color: darkomdee.darkomde == true
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                              color: darkomdee.darkomde == true
                                                  ? Colors.white
                                                  : Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    darkomdee.darkomde == true
                                                        ? Colors.white
                                                        : Colors.grey.shade300,
                                                blurRadius: 1)
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                color:
                                                    darkomdee.darkomde == true
                                                        ? Colors.black
                                                        : Colors.white,
                                                height: h / 5.5,
                                                width: w / 1,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            topLeft:
                                                                Radius.circular(
                                                                    8)),
                                                    child: Image.network(
                                                        "$image_url${homeapi.newarrivallist.elementAt(0).data!.elementAt(index).image1}",
                                                        fit: BoxFit.fitHeight)),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  width: w / 2.5,
                                                  child: Text(
                                                    homeapi.newarrivallist
                                                        .elementAt(0)
                                                        .data!
                                                        .elementAt(index)
                                                        .productName
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          darkomdee.darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Amazon_med",
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "\$${homeapi.newarrivallist.elementAt(0).data!.elementAt(index).salePrice}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: darkomdee.darkomde ==
                                                            true
                                                        ? Colors.white
                                                        : Colors.black,
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
                            )
                          : const SizedBox();
                    },
                  ),
                  SizedBox(
                    height: h / 70,
                  ),
                  Stack(children: [
                    inntfooterbannerlist.isEmpty ||
                            inntfooterbannerlist[0].isEmpty
                        ? const SizedBox()
                        : CarouselSlider.builder(
                            itemCount: inntfooterbannerlist[0].length,
                            itemBuilder: (context, index, realIndex) {
                              var findvideo = inntfooterbannerlist[0][index]
                                      ["banner_image"]
                                  .split('.')
                                  .last
                                  .toLowerCase();
                              return findvideo == "mp4" ||
                                      findvideo == "mov" ||
                                      findvideo == "avi" ||
                                      findvideo == "mkv"
                                  ? VideoWithImagePlaceholder(
                                      videoUrl:
                                          "$image_url${inntfooterbannerlist[0][index]["banner_image"].toString()}",
                                    )
                                  : Center(
                                      child: Material(
                                        borderRadius: BorderRadius.circular(10),
                                        elevation: 2,
                                        child: Container(
                                            width: double.infinity,
                                            height: h / 4,
                                            decoration: BoxDecoration(
                                              color: const Color(0xff0e18cf)
                                                  .withOpacity(.8),
                                            ),
                                            child: ClipRRect(
                                                child: Image.network(
                                              "$image_url${inntfooterbannerlist[0][index]["banner_image"]}",
                                              fit: BoxFit.fill,
                                            ))),
                                      ),
                                    );
                            },
                            options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex02 = index;
                                });
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
                    height: h / 70,
                  ),
                  Obx(() => wishh.wishlistlist.isEmpty
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                AppLocalizations.of(context)!.customerfavorites,
                                style: TextStyle(
                                    //letterSpacing: 1.5,
                                    color: darkomdee.darkomde == true
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: "Amazon_Bold",
                                    fontSize: 16)),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  currentTab = 1;
                                });
                                Get.offAll(const DashBoardScreen());
                                //Get.to(() => ViewAll(textapp: "Customer favorites",unkey: 5,));
                              },
                              child: Text(
                                AppLocalizations.of(context)!.viewall,
                                style: TextStyle(
                                    //letterSpacing: 1.5,
                                    //color: Colors.white,
                                    color: Colors.blue,
                                    fontFamily: "Amazon_med",
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        )),
                  SizedBox(
                    height: h / 70,
                  ),
                  Obx(() => wishh.wishlistlist.isEmpty
                      ? const SizedBox()
                      : FutureBuilder(
                          future: wishh.wishlikelist1(),
                          builder: (context, snapshot) {
                            return wishh.wishlistlist.isNotEmpty
                                ? GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    // padding: EdgeInsets.all(4),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 1,
                                      childAspectRatio: (MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1) /
                                          (MediaQuery.of(context).size.height /
                                              1.7),
                                    ),
                                    itemCount: wishh.wishlistlist.length >= 4
                                        ? 4
                                        : wishh.wishlistlist.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(Product_deatils(
                                              sourceName: "0",
                                              conn: "0.0",
                                              subsubcateid: wishh.wishlistlist
                                                      .elementAt(index)[
                                                  "productId"]!["-id"],
                                              shopid: wishh.wishlistlist
                                                      .elementAt(
                                                          index)["shopInfo"]
                                                  ["venderId"],
                                            ));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(4),
                                            width: w * 2 / 6,
                                            height: h / 1,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade300,
                                                      blurRadius: 1)
                                                ]),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    SizedBox(
                                                      height: h / 5.5,
                                                      width: w / 1,
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8)),
                                                          child: Image.network(
                                                              "$image_url${wishh.wishlistlist.elementAt(index)["productId"]!["image1"]}",
                                                              fit: BoxFit
                                                                  .fitHeight)),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                        width: w / 2.5,
                                                        child: Text(
                                                          wishh.wishlistlist
                                                              .elementAt(index)[
                                                                  "productId"][
                                                                  "product_name"]
                                                              .toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "Amazon_med",
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${wishh.wishlistlist.elementAt(index)["productId"]!["sale_price"]}  CFA",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              "Emebr_light",
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
                                  )
                                : const SizedBox();
                          },
                        )),
                  SizedBox(
                    height: h / 70,
                  ),
                  Obx(() => homeapi.advertisementProduct_listList.isEmpty ||
                          homeapi.advertisementProduct_listList[0]["data"]
                              .isEmpty ||
                          homeapi.advertisementProduct_listList[0]["data"]
                                  .length <
                              2
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {
                            Get.to(Product_deatils(
                              sourceName: "0",
                              shopid: homeapi.advertisementProduct_listList[0]
                                  ["data"][1]["venderId"],
                              subsubcateid:
                                  homeapi.advertisementProduct_listList[0]
                                      ["data"][1]["productId"],
                            ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: darkomdee.darkomde == true
                                    ? Colors.black
                                    : Colors.white,
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
                                    errorBuilder: (context, error, stackTrace) {
                                      return Text("Loading ....");
                                    },
                                    "$image_url${homeapi.advertisementProduct_listList[0]["data"][1]["image1"]}",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: w / 1.8,
                                      child: Text(
                                        "${homeapi.advertisementProduct_listList[0]["data"][1]["description"]}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: darkomdee.darkomde == true
                                              ? Colors.white
                                              : Colors.grey.shade500,
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
                                              "${homeapi.advertisementProduct_listList[0]["data"][1]["rating"]}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(width: w / 100),
                                          Text(
                                            "(${homeapi.advertisementProduct_listList[0]["data"][1]["raters"]})",
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
                                      "${homeapi.advertisementProduct_listList[0]["data"][1]["sales"]} sales",
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
                                      "\$${homeapi.advertisementProduct_listList[0]["data"][1]["sale_price"]}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: darkomdee.darkomde == true
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Amazon_med",
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),

                  FutureBuilder(
                    future: homeapi.trendingNow_List(),
                    builder: (context, snapshot) {
                      return homeapi.trendingNowList.isNotEmpty &&
                              homeapi.trendingNowList[0]["data"].isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: h / 70,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!
                                            .trendingnow,
                                        style: TextStyle(
                                            //letterSpacing: 1.5,
                                            color: darkomdee.darkomde == true
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: "Amazon_Bold",
                                            fontSize: 16)),
                                    InkWell(
                                      onTap: () {
                                        homeapi.homepageprofilter
                                            .add({"result": "0"});
                                        Get.to(() => ViewAll(
                                              textapp:
                                                  AppLocalizations.of(context)!
                                                      .trendingnow,
                                              unkey: 6,
                                            ));
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.viewall,
                                        style: TextStyle(
                                            //letterSpacing: 1.5,
                                            //color: Colors.white,
                                            color: Colors.blue,
                                            fontFamily: "Amazon_med",
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h / 70,
                                ),
                                GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  // padding: EdgeInsets.all(4),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 1,
                                    childAspectRatio: (MediaQuery.of(context)
                                                .size
                                                .width /
                                            1) /
                                        (MediaQuery.of(context).size.height /
                                            1.7),
                                  ),
                                  itemCount: homeapi.trendingNowList
                                              .elementAt(0)["data"]!
                                              .length >=
                                          4
                                      ? 4
                                      : homeapi.trendingNowList
                                          .elementAt(0)["data"]!
                                          .length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(Product_deatils(
                                            sourceName: "0",
                                            conn: "0.0",
                                            subsubcateid: homeapi
                                                .trendingNowList
                                                .elementAt(0)["data"]!
                                                .elementAt(index)["productId"],
                                            shopid: homeapi.trendingNowList
                                                .elementAt(0)["data"]!
                                                .elementAt(index)["venderId"],
                                          ));
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(4),
                                          width: w * 2 / 6,
                                          height: h / 1,
                                          decoration: BoxDecoration(
                                              color: darkomdee.darkomde == true
                                                  ? Colors.black
                                                  : Colors.white,
                                              border: Border.all(
                                                  color:
                                                      darkomdee.darkomde == true
                                                          ? Colors.white
                                                          : Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    blurRadius: 1)
                                              ]),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  SizedBox(
                                                    height: h / 5.5,
                                                    width: w / 1,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        8),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8)),
                                                        child: Image.network(
                                                            "$image_url${homeapi.trendingNowList.elementAt(0)["data"]!.elementAt(index)["image1"].toString()}",
                                                            fit: BoxFit
                                                                .fitHeight)),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    SizedBox(
                                                      width: w / 2.5,
                                                      child: Text(
                                                        homeapi.trendingNowList
                                                            .elementAt(
                                                                0)["data"]!
                                                            .elementAt(index)[
                                                                "product_name"]
                                                            .toString(),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: darkomdee
                                                                      .darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              "Amazon_med",
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "\$${homeapi.trendingNowList.elementAt(0)["data"]!.elementAt(index)["sale_price"]}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: darkomdee
                                                                    .darkomde ==
                                                                true
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            "Emebr_light",
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
                                ),
                              ],
                            )
                          : const SizedBox();
                    },
                  ),
                  SizedBox(
                    height: h / 70,
                  ),
                  Obx(() => homeapi.advertisementProduct_listList.isEmpty ||
                          homeapi.advertisementProduct_listList[0]["data"]
                                  .length <
                              3
                      ? const SizedBox()
                      : Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300, blurRadius: 3)
                              ]),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "$image_url${homeapi.advertisementProduct_listList[0]["data"][2]["image1"]}",
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
                                      "${homeapi.advertisementProduct_listList[0]["data"][2]["description"]}",
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
                                        borderRadius: BorderRadius.circular(8)),
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
                                            "${homeapi.advertisementProduct_listList[0]["data"][2]["rating"]}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(width: w / 100),
                                        Text(
                                          "(${homeapi.advertisementProduct_listList[0]["data"][2]["raters"]})",
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
                                    "${homeapi.advertisementProduct_listList[0]["data"][2]["sales"]} sales",
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
                                    "\$${homeapi.advertisementProduct_listList[0]["data"][2]["sale_price"]}",
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
                        )),
                  SizedBox(
                    height: h / 70,
                  ),
                  homeapi.suggested_ProductListList.isNotEmpty &&
                          homeapi.suggested_ProductListList[0].data!.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppLocalizations.of(context)!.suggestedforyou,
                                style: TextStyle(
                                    //letterSpacing: 1.5,
                                    color: darkomdee.darkomde == true
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: "Amazon_Bold",
                                    fontSize: 16)),
                            InkWell(
                              onTap: () {
                                homeapi.homepageprofilter.add({"result": "0"});
                                Get.to(() => ViewAll(
                                      unkey: 5,
                                      textapp: AppLocalizations.of(context)!
                                          .suggestedforyou,
                                    ));
                              },
                              child: Text(AppLocalizations.of(context)!.viewall,
                                  style: TextStyle(
                                      //letterSpacing: 1.5,
                                      //color: Colors.white,
                                      color: Colors.blue,
                                      fontFamily: "Amazon_med",
                                      fontSize: 14)),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: h / 70,
                  ),
                  FutureBuilder(
                    future: homeapi.suggested_ProductList_List(),
                    builder: (context, snapshot) {
                      return homeapi.suggested_ProductListList.isNotEmpty &&
                              homeapi
                                  .suggested_ProductListList[0].data!.isNotEmpty
                          ? GridView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              // padding: EdgeInsets.all(4),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                                childAspectRatio:
                                    (MediaQuery.of(context).size.width / 1) /
                                        (MediaQuery.of(context).size.height /
                                            1.7),
                              ),
                              itemCount: homeapi.suggested_ProductListList
                                          .elementAt(0)
                                          .data!
                                          .length >=
                                      4
                                  ? 4
                                  : homeapi.suggested_ProductListList
                                      .elementAt(0)
                                      .data!
                                      .length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(Product_deatils(
                                        sourceName: "0",
                                        conn: "0.0",
                                        subsubcateid: homeapi
                                            .suggested_ProductListList
                                            .elementAt(0)
                                            .data!
                                            .elementAt(index)
                                            .productId!
                                            .id,
                                        shopid: homeapi
                                            .suggested_ProductListList
                                            .elementAt(0)
                                            .data!
                                            .elementAt(index)
                                            .productId!
                                            .venderId,
                                      ));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(4),
                                      width: w * 2 / 6,
                                      height: h / 1,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade300,
                                                blurRadius: 1)
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              SizedBox(
                                                height: h / 5.5,
                                                width: w / 1,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            topLeft:
                                                                Radius.circular(
                                                                    8)),
                                                    child: Image.network(
                                                        "$image_url${homeapi.suggested_ProductListList.elementAt(0).data!.elementAt(index).productId!.image1}",
                                                        fit: BoxFit.fitHeight)),
                                              ),
                                              /*   Positioned(
                                                      child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(
                              CupertinoIcons.heart,
                              color: Colors.black,
                              size: 18,
                            ),
                                                      )
                                                    ],
                                                  ))*/
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  width: w / 2.5,
                                                  child: Text(
                                                    homeapi
                                                        .suggested_ProductListList
                                                        .elementAt(0)
                                                        .data!
                                                        .elementAt(index)
                                                        .productId!
                                                        .productName
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Amazon_med",
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "\$${homeapi.suggested_ProductListList.elementAt(0).data!.elementAt(index).productId!.salePrice}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
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
                            )
                          : const SizedBox();
                    },
                  ),
                  SizedBox(
                    height: h / 70,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.shopbycategories,
                    style: darkomdee.darkomde == true
                        ? TextStyle(
                            //letterSpacing: 1.5,
                            //color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            color: darkomdee.darkomde == true
                                ? Colors.white
                                : Colors.black,
                            fontFamily: "Amazon_med",
                            fontSize: 16)
                        : A_style_medium,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ViewAll(
                          unkey: 10,
                          textapp:
                              AppLocalizations.of(context)!.allcategories));
                    },
                    child: Text(AppLocalizations.of(context)!.allcategories,
                        style: TextStyle(
                            //letterSpacing: 1.5,
                            //color: Colors.white,
                            color: Colors.blue,
                            fontFamily: "Amazon_med",
                            fontSize: 14)),
                  ),
                ],
              ),
            ),

            FutureBuilder<List<InntCategoryListModel>>(
              future: getInntCategory_api.categoryList(),
              builder: (context, snapshot) {
                lll();

                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: getInntCategory_api.inntCategory.length >= 6
                      ? 6
                      : getInntCategory_api.inntCategory.length,
                  // homeapi.newarrivallist.elementAt(0).data!.length >=4 ? 4: homeapi.newarrivallist.elementAt(0).data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.5),
                  ),
                  itemBuilder: (context, index) {
                    //  final inntCategoryList = snapshot.data![index] ?? 0;
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the category screen when tapped
                        Get.to(Subcatby(
                          categoryId: getInntCategory_api
                              .inntCategory[index].sId
                              .toString(),
                          subcate: getInntCategory_api
                              .inntCategory[index].categoryEnglishName
                              .toString(),
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300, blurRadius: 5)
                          ],
                          image: const DecorationImage(
                            image:
                                AssetImage("assets/images/catbackground.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  languagee != "en"
                                      ? getInntCategory_api.inntCategory[index]
                                          .categoryFrenchName
                                          .toString()
                                      : getInntCategory_api.inntCategory[index]
                                          .categoryEnglishName
                                          .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: A_style_mid_black,
                                  maxLines: 3,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Image.network(
                                "$image_url${getInntCategory_api.inntCategory[index].categoryImage.toString()}",
                                width: MediaQuery.of(context).size.width / 7,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Text("Loading ....");
                                },
                                height: MediaQuery.of(context).size.height / 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                // }
              },
            ),
          ],
        ),
      ),
    );
  }

  CarouselSlider buildCarouselSlider(double h) {
    return CarouselSlider.builder(
      itemCount: bannerlist[0].length,
      itemBuilder: (context, index, realIndex) {
        var findvideo =
            bannerlist[0][index]["banner_image"].split('.').last.toLowerCase();

        if (findvideo == "mp4" ||
            findvideo == "mov" ||
            findvideo == "avi" ||
            findvideo == "mkv") {
          return VideoWithImagePlaceholder(
            videoUrl:
                "$image_url${bannerlist[0][index]["banner_image"].toString()}",
          );

          // return
          //   FutureBuilder(
          //     future: initializeVideoPlayerFuture,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         return AspectRatio(
          //           aspectRatio: 11/3,
          //           child: VideoPlayer(controllervideo),
          //         );
          //       } else {
          //         return Center(
          //           child: CircularProgressIndicator(color: logocolo),
          //         );
          //       }
          //     },
          //   );
        } else {
          return Center(
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 2,
              child: Container(
                width: double.infinity,
                height: h / 4,
                decoration: BoxDecoration(
                  color: const Color(0xff0e18cf).withOpacity(.8),
                ),
                child: ClipRRect(
                  child: Image.network(
                    "$image_url${bannerlist[0][index]["banner_image"]}",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
        }
      },
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          setState(() {
            currentindex = index;
          });
        },
        height: 170,
        enlargeCenterPage: true,
        autoPlay: false,
        aspectRatio: 10 / 15,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 1,
      ),
    );
  }

  var languagee;

  lll() async {
    print("hkhfhfff");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    languagee = prefs.get(LAGUAGE_CODE).toString();
    print("jklkljgljbgj $languagee");
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
      child: ListView.builder(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeapi.dayOftheDeals_ProductList.elementAt(0).data!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(Product_deatils(
                sourceName: "0",
                conn: "0.0",
                subsubcateid: homeapi.dayOftheDeals_ProductList
                    .elementAt(0)
                    .data!
                    .elementAt(index)
                    .productId
                    .toString(),
                shopid: homeapi.dayOftheDeals_ProductList
                    .elementAt(0)
                    .data!
                    .elementAt(index)
                    .venderId
                    .toString(),
              ));
            },
            child: Container(
              margin: const EdgeInsets.all(4),
              width: w * 2 / 6,
              // Adjusted width to show 2/5 of the screen width
              height: h / 1,
              decoration: BoxDecoration(
                  color:
                      darkomdee.darkomde == true ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: darkomdee.darkomde == true
                          ? Colors.white
                          : Colors.white),
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
                                "$image_url${homeapi.dayOftheDeals_ProductList.elementAt(0).data!.elementAt(index).image1.toString()}",
                                fit: BoxFit.contain)),
                      ),
                      homeapi.dayOftheDeals_ProductList
                                  .elementAt(0)
                                  .data!
                                  .elementAt(index)
                                  .discount
                                  .toString() ==
                              "0"
                          ? SizedBox()
                          : Positioned(
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
                                    "${homeapi.dayOftheDeals_ProductList.elementAt(0).data!.elementAt(index).discount.toString()} ${homeapi.dayOftheDeals_ProductList.elementAt(0).data!.elementAt(index).discountName.toString() == "Percent off" ? "%" : "CFA"} off",
                                    style: const TextStyle(
                                      color: Color(0xfffefff7),
                                    ),
                                  )),
                                ),
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
                            homeapi.dayOftheDeals_ProductList
                                .elementAt(0)
                                .data!
                                .elementAt(index)
                                .productName
                                .toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: darkomdee.darkomde == true
                                  ? Colors.white
                                  : Colors.black,
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

class Trending_now extends StatelessWidget {
  const Trending_now({
    super.key,
    required this.h,
    required this.w,
  });

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h / 1.9,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        // padding: EdgeInsets.all(4),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: (MediaQuery.of(context).size.width / 1) /
              (MediaQuery.of(context).size.height / 1.8),
        ),
        itemCount: new_arrivalname.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              //   Get.to(const Product_deatils());
            },
            child: Container(
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
                      SizedBox(
                        height: h / 5.5,
                        width: w / 1,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(8),
                                topLeft: Radius.circular(8)),
                            child: Image.asset("assets/images/jeans1.png",
                                fit: BoxFit.fill)),
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
                            new_arrivalname.elementAt(index),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Amazon_med",
                            ),
                          ),
                        ),
                        const Text(
                          "\$986",
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
