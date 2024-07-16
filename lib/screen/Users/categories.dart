import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/sellers/sellerall.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Controller/controller.dart';
import '../../Controller/dotscontroller.dart';
import '../../Controller/text2.dart';
import '../../ulits/constant.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int _currentIndex02 = 0;
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  final double _volume = 100;
  final bool _muted = false;
  bool _isPlayerReady = false;

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

  @override
  void deactivate() {
    // Pauses video while navigating to the next page.
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

  bool isSelected = false;
  GetxControllers controller = Get.put(GetxControllers());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 5,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            const Center(child: Text("All categories")),
            SizedBox(
              height: h / 100,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                SizedBox(
                  height: h / 20,
                  width: w / 1.2,
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Search in innt",
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black),
                        fillColor: const Color(0xffeef1f5),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(7))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Text(
                "Suggested categories",
                style: A_style_medium,
              ),
            ),
            GridView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    //Get.to(const CategoryScreen());
                   // Get.to(const Subcate());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 5)
                            ]),
                        child: Center(
                            child: Image.asset(
                          categorieslist.elementAt(index),
                          width: w / 8,
                          height: h / 9,
                        )),
                      ),
                      SizedBox(
                        height: h / 80,
                      ),
                      Center(
                        child: Text(categoriesInntlist[index],
                            overflow: TextOverflow.ellipsis,
                            style: A_style_mid_black),
                      ),
                    ],
                  ),
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 7,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.7),
              ),
            ),
            Divider(
              color: Colors.grey.shade200,
              height: 1,
              thickness: 2,
            ),
            SizedBox(
              height: h / 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("innt",
                    style: TextStyle(
                        //letterSpacing: 1.5,
                        color: Color(0xff1455ac),
                        fontFamily: "Regular",
                        fontSize: 35)),
                InkWell(
                  onTap: () {
                    Get.to(() => const Sellerall());
                  },
                  child: Text(
                    "See Shops",
                    style: A_style_mid,
                  ),
                ),
              ],
            ),
            GridView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //  Get.to(const CategoryScreen());
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                        ],
                        image: const DecorationImage(
                          image: AssetImage("assets/images/catbackground.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 5),
                            child: Text(
                              categoriesInntlist[index],
                              overflow: TextOverflow.ellipsis,
                              style: A_style_mid_black,
                              maxLines: 3,
                            ),
                          ),
                          Image.asset(
                            categorieslist.elementAt(index),
                            width: w / 8,
                            height: h / 9,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.5),
                )),
            SizedBox(
              height: h / 70,
            ),
            Divider(
              color: Colors.grey.shade200,
              height: 1,
              thickness: 2,
            ),
            SizedBox(
              height: h / 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("innt out",
                    style: TextStyle(
                        //letterSpacing: 1.5,
                        color: Colors.green.shade300,
                        fontFamily: "Regular",
                        fontSize: 35)),
                InkWell(
                  onTap: () {
                    Get.to(() => const Sellerall());
                  },
                  child: Text(
                    "See Shops",
                    style: A_style_mid,
                  ),
                ),
              ],
            ),
            GridView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Get.to(const CategoryScreen());
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                        ],
                        image: const DecorationImage(
                          image: AssetImage("assets/images/catbackground.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 5),
                            child: Text(
                              categoriesInntOutlist[index],
                              overflow: TextOverflow.ellipsis,
                              style: A_style_mid_black,
                              maxLines: 3,
                            ),
                          ),
                          Image.asset(
                            categorieslist.elementAt(index),
                            width: w / 8,
                            height: h / 9,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.5),
                )),
            SizedBox(
              height: h / 70,
            ),
            Row(
              children: [
                Text("innt live",
                    style: TextStyle(
                        //letterSpacing: 1.5,
                        color: Colors.red.shade700,
                        fontFamily: "Regular",
                        fontSize: 35)),
                SizedBox(
                  width: w / 90,
                ),
                Image.asset(
                  "assets/images/live.png",
                  color: Colors.red.shade700,
                  height: 30,
                  width: 30,
                )
                // InkWell(
                //   onTap: () {
                //     Get.to(() => const Sellerall());
                //   },
                //   child: Text(
                //     "See Shops",
                //     style: A_style_mid,
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: h / 70,
            ),
            Stack(children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  aspectRatio: 1.5,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex02 = index;
                    });
                  },
                ),
                items: [
                  YoutubePlayer(
                    aspectRatio: 1.5,
                    controller: _controller,
                    showVideoProgressIndicator: false,
                    progressIndicatorColor: Colors.blueAccent,
                    topActions: const <Widget>[
                      //  const SizedBox(width: 8.0),
                      // IconButton(
                      //   icon: const Icon(
                      //     Icons.settings,
                      //     color: Colors.white,
                      //     size: 25.0,
                      //   ),
                      //   onPressed: () {
                      //     print('Settings Tapped!');
                      //   },
                      // ),
                    ],
                    onReady: () {
                      _isPlayerReady = true;
                    },
                    onEnded: (data) {
                      _controller.load(
                          _ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
                      _showSnackBar('Next Video Started!');
                    },
                  ),
                  InkWell(
                    child: const AddVideoImageBanner(
                        imageUrl1: "assets/images/shopping.jpg"),
                    onTap: () {
                      // Get.to(const Third_Class());
                    },
                  ),
                  YoutubePlayer(
                    aspectRatio: 1.5,
                    controller: _controller,
                    showVideoProgressIndicator: false,
                    progressIndicatorColor: Colors.blueAccent,
                    topActions: const <Widget>[
                      //  const SizedBox(width: 8.0),
                      // IconButton(
                      //   icon: const Icon(
                      //     Icons.settings,
                      //     color: Colors.white,
                      //     size: 25.0,
                      //   ),
                      //   onPressed: () {
                      //     print('Settings Tapped!');
                      //   },
                      // ),
                    ],
                    onReady: () {
                      _isPlayerReady = true;
                    },
                    onEnded: (data) {
                      _controller.load(
                          _ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
                      _showSnackBar('Next Video Started!');
                    },
                  ),
                  InkWell(
                      child: const AddVideoImageBanner(
                          imageUrl1: "assets/images/shopping2.jpg"),
                      onTap: () {
                        //   Get.to(const FreeVideos());
                      }),
                  InkWell(
                      child: const AddVideoImageBanner(
                          imageUrl1: "assets/images/shopping3.jpg"),
                      onTap: () {
                        //   Get.to(const Third_Class());
                      }),
                ],
              ),
              Positioned(
                left: w / 2.7,
                bottom: h / 35,
                child: CustomIndicator(
                  currentIndex: _currentIndex02,
                  itemCount: 5,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: logocolo,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

class AddVideoImageBanner extends StatelessWidget {
  final String imageUrl1;

  const AddVideoImageBanner({super.key, required this.imageUrl1});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 200,
      width: w,
      child: Image(
        image: AssetImage(imageUrl1),
        fit: BoxFit.cover,
      ),
    );
  }
}
