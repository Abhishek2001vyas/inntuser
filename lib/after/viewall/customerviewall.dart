import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/productdeatils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../ulits/constant.dart';
import '../../screen/Users/categories.dart';
import '../../screen/Users/cattegory_screen.dart';
import 'filter.dart';

class ViewAllcustom extends StatefulWidget {
  const ViewAllcustom({super.key});

  @override
  State<ViewAllcustom> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAllcustom> {
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

  @override
  Widget build(BuildContext context) {
    String selectedItem = 'Move to bag';
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Customer's favorite"),
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
            icon: const Icon(Icons.grid_view_sharp),
            onPressed: () {
              // Add your shopping cart icon onPressed logic here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  aspectRatio: 1.8,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex02 = index;
                    });
                  },
                ),
                items: [
                  InkWell(
                    child: const AddVideoImageBanner(
                        imageUrl1: "assets/images/banner.png"),
                    onTap: () {
                      // Get.to(const Third_Class());
                    },
                  ),
                  YoutubePlayer(
                    aspectRatio: 1.5,
                    controller: _controller,
                    showVideoProgressIndicator: false,
                    progressIndicatorColor: Colors.blueAccent,
                    topActions: const <Widget>[],
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
                          imageUrl1: "assets/images/shopping3.jpg"),
                      onTap: () {
                        //   Get.to(const Third_Class());
                      }),
                ],
              ),
              // Positioned(
              //   left: w / 2.7,
              //   bottom: h / 35,
              //   child: CustomIndicator(
              //     currentIndex: _currentIndex02,
              //     itemCount: 5,
              //   ),
              // ),
            ]),
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
                    Get.to(() => const Product_deatils(sourceName: "0",));
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
