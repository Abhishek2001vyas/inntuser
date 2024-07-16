// import 'dart:async';
// import 'dart:io';
//
// // import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:chat_bubbles/chat_bubbles.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:inntuser/screen/Users/sellers/sellerdeatils.dart';
// import 'package:inntuser/ulits/constant.dart';
// import 'package:vengamo_chat_ui/theme/app_color.dart';
// import 'package:vengamo_chat_ui/vengamo_chat_ui.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../Api/meassage_api.dart';
//
//
// AudioPlayer audioPlayer = AudioPlayer();
// class UserChat extends StatefulWidget {
//   final venderid;
//   final venderimage;
//   final shopname;
//   final int status;
//
//   const UserChat({Key? key, this.venderid, this.venderimage, this.shopname, required this.status}) : super(key: key);
//
//   @override
//   _UserChatState createState() => _UserChatState();
// }
//
// class _UserChatState extends State<UserChat> {
//   final StreamController _streamController = StreamController();
//
//   Duration duration = const Duration();
//   Duration position = const Duration();
//   bool isPlaying = false;
//   bool isLoading = false;
//   bool isPause = false;
//   final chat_api = Get.put(meassage_api());
//   late VideoPlayerController controllervideo1;
//   void _scrollToBottom() {
//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: const Duration(milliseconds: 100),
//       curve: Curves.easeOut,
//     );
//   }
//   final ScrollController _scrollController = ScrollController();
//
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     controllervideo.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 60,
//         // forceMaterialTransparency: true,
//         automaticallyImplyLeading: true,
//         title: Row(
//           children: [
//             Container( height: 50,
//               width: 50,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(50),
//                   boxShadow: const [BoxShadow(color: logocolo, blurRadius: 0.5)]),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(50),
//                 child:
//                 widget.venderimage !=null?
//                 Image.network(
//                   "$image_url${widget.venderimage}",
//                   height: 50,
//                   width: 50,
//                   fit: BoxFit.cover,
//                 ):const Text("No image"),
//               ),
//             ),
//             SizedBox(
//               width: w / 80,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: w / 2,
//                   child: Text(
//                     "${widget.shopname}",
//                     maxLines: 1,
//                     style: const TextStyle(
//                         color: Colors.white,
//                         overflow: TextOverflow.ellipsis,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//
//               ],
//             ),
//             const Spacer(
//               flex: 4,
//             ),
//             widget.status==1?
//             GestureDetector(
//               onTap: (){
//                 Get.to(SellerDetails(shopid: widget.venderid,shopanme: widget.shopname ,));
//               },
//               child: Image.asset(
//                 "assets/images/shops.png",
//                 height: 25,
//                 width: 25,
//                 color: Colors.white,
//                 fit: BoxFit.cover,
//               ),
//             )
//
//                 :const SizedBox(),
//           ],
//         ),
//       ),
//       body: Stack(
//         children: [
//           StreamBuilder(
//             stream: Stream.periodic(const Duration(milliseconds:0,)).asyncMap((i) =>   chat_api.uservenderchat(widget.venderid,widget.status)),
//             builder: (context, snapshot) {
//               return
//                 snapshot.hasData =="true" ||  chat_api.uservenderchatlist.isEmpty ?
//                 const Padding(
//                   padding: EdgeInsets.only(top: 20.0),
//                   child: Center(child: Text("NO Message"),),
//                 ):
//                 ListView.builder(
//                   controller: _scrollController,
//                   shrinkWrap: true,itemCount: chat_api.uservenderchatlist[0]["data"].length,
//                   itemBuilder: (context, index) {
//
//                     var  findvideo1 =  chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"].split('.').last.toLowerCase();
//                     print("$findvideo1");
//
//                     return
//
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()=="Received" &&
//                           findvideo1 == "mp4" ||
//                           findvideo1 == "mov" ||
//                           findvideo1 == "avi" ||
//                           findvideo1 == "mkv"?
//
//
//                       VideoWithImagePlaceholder(videoUrl: "$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"].toString()}",no: 1,)
//                           :
//
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()=="Sent" &&
//                           findvideo1 == "mp4" ||
//                           findvideo1 == "mov" ||
//                           findvideo1 == "avi" ||
//                           findvideo1 == "mkv"?
//
//
//                       VideoWithImagePlaceholder(videoUrl: "$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"].toString()}",no: 0,)
//                           :
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()=="Received" &&
//                           findvideo1 == "mp3"?
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: VengamoChatUI(
//                             senderBgColor:logocolo,
//                             receiverBgColor:logocolo,
//                             isSender: false,
//                             isNextMessageFromSameSender: false,
//                             time: getTime(),
//                             isAudio: true,
//                             audioSource: '$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"]}',
//                             timeLabelColor: AppColors.iconColor,
//                             pointer: true,
//                             ack: const Icon(Icons.audiotrack,size: 15,)
//                         ),
//                       ):
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()=="Sent" &&
//                           findvideo1 == "mp3"?
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: VengamoChatUI(
//                             senderBgColor:logocolo,
//                             receiverBgColor: logocolo,
//                             isSender: true,
//                             isNextMessageFromSameSender: false,
//                             time: getTime(),
//                             isAudio: true,
//                             audioSource: '$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"]}',
//                             timeLabelColor: AppColors.iconColor,
//                             pointer: true,
//                             ack: const Icon(Icons.audiotrack,size: 15,)
//                         ),
//                       ):
//
//
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()=="Received" &&
//                           findvideo1 == "jpg" ||
//                           findvideo1 == "png" ||
//                           findvideo1 == "jpeg"?
//
//                       BubbleNormalImage(
//                         image:Image.network("$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"].toString()}"),
//                         color: logocolo,
//                         tail: false,
//                         sent: true,isSender: false,
//                         seen: true,
//                         delivered: true, id: '$index',
//                       ):
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()=="Sent" &&
//                           findvideo1 == "jpg" ||
//                           findvideo1 == "png" ||
//                           findvideo1 == "jpeg"?
//
//                       BubbleNormalImage(
//                         image:Image.network("$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"].toString()}"),
//                         color: logocolo,
//                         tail: false,
//                         sent: true,isSender: true,
//                         seen: true,
//                         delivered: true, id: '$index',
//                       ):
//
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString() !="1"  &&
//                           findvideo1 == "jpg" ||
//                           findvideo1 == "png" ||
//                           findvideo1 == "jpeg"   ?
//
//                       BubbleNormalImage(
//                         image:Image.network("$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"].toString()}"),
//                         color: logocolo,
//                         tail: false,
//                         sent: true,isSender: false,
//                         seen: true,
//                         delivered: true, id: '$index',
//                       ):
//
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()!="0"
//                           &&
//                           findvideo1 == "jpg" ||
//                           findvideo1 == "png" ||
//                           findvideo1 == "jpeg"    ?
//
//                       BubbleNormalImage(
//                         image:Image.network("$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"].toString()}"),
//                         color: logocolo,
//                         tail: false,
//                         sent: true,isSender: true,
//                         seen: true,
//                         delivered: true, id: '$index',
//                       ):
//
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()!="1" &&
//                           findvideo1 == "mp4" ||
//                           findvideo1 == "mov" ||
//                           findvideo1 == "avi" ||
//                           findvideo1 == "mkv"?
//
//
//                       VideoWithImagePlaceholder(videoUrl: "$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"].toString()}",no: 1,)
//                       // NewWidget(initializeVideoPlayerFuture2: initializeVideoPlayerFuture2, controllervideo1: controllervideo1)
//                           :
//
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()!="0" &&
//                           findvideo1 == "mp4" ||
//                           findvideo1 == "mov" ||
//                           findvideo1 == "avi" ||
//                           findvideo1 == "mkv"?
//
//                       VideoWithImagePlaceholder(videoUrl: "$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"].toString()}",no: 0,)
//                           :
//
//
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()!="1" &&
//                           findvideo1 == "mp3"?
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: VengamoChatUI(
//                             senderBgColor:logocolo,
//                             receiverBgColor:logocolo,
//                             isSender: false,
//                             isNextMessageFromSameSender: false,
//                             time: getTime(),
//                             isAudio: true,
//                             audioSource: '$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"]}',
//                             timeLabelColor: AppColors.iconColor,
//                             pointer: true,
//                             ack: const Icon(Icons.audiotrack,size: 15,)
//                         ),
//                       )
//
//
//                       // BubbleNormalAudio(
//                       //   color: logocolo,
//                       //   duration: duration.inSeconds.toDouble(),
//                       //   position: position.inSeconds.toDouble(),
//                       //   isPlaying: isPause,
//                       //   isLoading: isLoading,
//                       //   isPause: isPause,
//                       //   onSeekChanged: _changeSeek,
//                       //  onPlayPauseButtonClick:
//                       //  _playAudio('$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"]}'),
//                       //  //_playPauseButtonClick('$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"].toString()}'),
//                       //   sent: false,
//                       // )
//                           :
//
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()!="0" &&
//                           findvideo1 == "mp3"?
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: VengamoChatUI(
//                             senderBgColor:logocolo,
//                             receiverBgColor: logocolo,
//                             isSender: true,
//                             isNextMessageFromSameSender: false,
//                             time: getTime(),
//                             isAudio: true,
//                             audioSource: '$image_url${chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"]}',
//                             timeLabelColor: AppColors.iconColor,
//                             pointer: true,
//                             ack: const Icon(Icons.audiotrack,size: 15,)
//                         ),
//                       ):
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()=="1" ||  chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()=="Sent"?
//                       BubbleNormal(
//                         text: chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"].toString(),
//                         textStyle: const TextStyle(
//                           fontSize: 10,
//                           color: Colors.white,
//                         ),
//                         color: logocolo,
//                         tail: false,
//                         sent: true,
//                         seen: true,
//                         delivered: true,
//                       )
//                           :
//
//
//
//                       chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()=="0" ||  chat_api.uservenderchatlist.elementAt(0)["data"][index]["send_status"].toString()=="Received" ?
//
//                       BubbleNormal(
//                         text: chat_api.uservenderchatlist.elementAt(0)["data"][index]["text"].toString(),
//                         textStyle: const TextStyle(
//                           fontSize: 10,
//                           color: Colors.white,
//                         ),
//                         color: logocolo,
//                         tail: false,isSender: false,
//                         sent: true,
//                         seen: true,
//                         delivered: true,
//                       ):null
//
//                     ;
//
//
//                   },);
//
//             },),
//
//
//
//           MessageBar(
//             onSend: (p0) async{
//               await chat_api.chatsendlist(widget.venderid,p0.toString(), widget.status);
//               _scrollToBottom();
//             },
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InkWell(
//                     child: const Icon(
//                       Icons.attach_file,
//                       color: Colors.black,
//                       size: 24,
//                     ),
//                     onTap: () async{
//                       await bottomshet();
//
//                       //Get.to(Pickview(shopname: widget.shopname,shopid: widget.venderid,));
//                     },
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         cam();
//                       },
//                       icon: const Icon(
//                         Icons.camera_alt_outlined,
//                         color: Colors.black,
//                       ))
//                 ],
//               ),
//             ],
//           ),
//
//         ],
//       ),
//
//     );
//   }
//
//
//   Future initializeVideoPlayerFuture1() {
//     return initializeVideoPlayerFuture2=
//         controllervideo1.initialize().catchError((error) {
//           print("Error initializing video player: $error");
//         }).then((_) {
//           // Once video has been initialized, start playing it
//           //controllervideo.setVolume(_muted ? 0 : 1);
//
//           // controllervideo1.setLooping(true);
//           setState(() {});
//         });
//   }
//   Future<void> initializeVideoPlayerFuture2 = Future.value();
//   Widget _image() {
//     return Container(
//         constraints: const BoxConstraints(
//           minHeight: 20.0,
//           minWidth: 20.0,
//         ),
//         child: Image.asset("assets/images/man.png"));
//   }
//
// // Define the _changeSeek function
//   _changeSeek(double value) {
//     // Assuming audioPlayer is initialized somewhere in your code
//     try {
//       // Seek to the specified position
//       audioPlayer.seek(Duration(seconds: value.toInt()));
//     } catch (e) {
//       // Handle any errors that occur during seek operation
//       print("Error seeking audio: $e");
//       // You can also update UI state to reflect the error, if needed
//     }
//   }
//
//
// // Define the _playPauseButtonClick function
//   _playPauseButtonClick(audioUrl) async {
//     // Assuming audioPlayer is initialized somewhere in your code
//     try {
//       // Play the audio
//       await audioPlayer.play(audioUrl);
//
//       // Update UI state as needed
//       setState(() {
//         isPlaying = true;
//         isPause = false;
//         isLoading = false;
//       });
//     } catch (e) {
//       // Handle any errors that occur during audio playback
//       print("Error playing audio: $e");
//       // You can also update UI state to reflect the error, if needed
//     }
//   }
//
//
//   getTime(){
//
//     return "00.00";
//   }
//   _playAudio(urll) async {
//     // final player = AudioPlayer();
//     // await player.play(UrlSource( '$urll'));
//     "$urll";
//     if (isPause) {
//       setState(() {
//         isPlaying = true;
//         isPause = false;
//       });
//     } else if (isPlaying) {
//       setState(() {
//         isPlaying = false;
//         isPause = true;
//       });
//     } else {
//       setState(() {
//         isLoading = true;
//       });
//
//       setState(() {
//         isPlaying = true;
//       });
//     }
//   }
//
//   bottomshet() {
//     Get.bottomSheet(
//         backgroundColor: Colors.white,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(40), topLeft: Radius.circular(40))),
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               ListTile(
//                 leading: const Icon(
//                   Icons.camera_alt,
//                 ),
//                 title: const Text('Camera',
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.w500)),
//                 onTap: () {
//                   cam();
//                   Get.back();
//                   // pickImage(ImageSource!.camera,);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.image,
//                   // color: colors.primary,
//                 ),
//                 title: const Text('Gallary',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w500, color: Colors.black)),
//                 onTap: () {
//                   gall();
//                   Get.back();
//                   // pickImage(ImageSource!.gallery);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.video_collection_outlined,
//                   // color: colors.primary,
//                 ),
//                 title: const Text('Videos',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w500, color: Colors.black)),
//                 onTap: () {
//                   videos();
//                   Get.back();
//                   // pickImage(ImageSource!.gallery);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.mic,
//                 ),
//                 title: const Text('Audio',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w500, color: Colors.black)),
//                 onTap: () {
//                   audieo();
//                   Get.back();
//                 },
//               ),
//             ],
//           ),
//         ));
//   }
//
//   Future cam() async {
//     var image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80, );
//
//     if (image != null) {
//       chat_api. imagePath.value = image.path.toString();
//       findvideo =
//           chat_api. imagePath.split('.').last.toLowerCase();
//     }Get.to(Pickview(shopname: widget.shopname,shopid: widget.venderid,shopimage: widget.venderimage,status: widget.status,));
//   }
//
//   Future gall() async {
//     var image = await ImagePicker()
//         .pickImage(source: ImageSource.gallery, imageQuality: 80);
//     if (image != null) {
//       chat_api.imagePath.value = image.path.toString();
//       findvideo =
//           chat_api. imagePath.split('.').last.toLowerCase();
//     }Get.to(Pickview(shopname: widget.shopname,shopid: widget.venderid,shopimage: widget.venderimage,status: widget.status,));
//   }
//   Future videos() async {
//     var image = await ImagePicker().pickVideo(source: ImageSource.gallery );
//
//     if (image != null) {
//       chat_api. imagePath.value = image.path.toString();
//       controllervideo = VideoPlayerController.file( File(image.path));
//       initializeVideoPlayerFuture =
//           controllervideo.initialize().catchError((error) {
//             print("Error initializing video player: $error");
//           }).then((_) {
//             // Once video has been initialized, start playing it
//             //controllervideo.setVolume(_muted ? 0 : 1);
//             controllervideo.play();
//             controllervideo.setLooping(true);
//             setState(() {});
//
//           });
//
//       controllervideo.addListener(_videoListener);
//       findvideo =
//           chat_api. imagePath.split('.').last.toLowerCase();
//     }Get.to(Pickview(shopname: widget.shopname,shopid: widget.venderid,shopimage: widget.venderimage,status: widget.status,));
//   }
//
//
//
//
//   void _videoListener() {
//     if (controllervideo.value.isPlaying ) {
//
//     }
//   }
//
//   Future audieo() async {
//     var image = await FilePicker.platform.pickFiles(
//       type: FileType.audio, // Specify that you want to pick audio files
//     );
//     if (image != null) {
//       PlatformFile file = image.files.first;
//       chat_api.imagePath.value =file.path!.toString();
//       findvideo =
//           chat_api. imagePath.split('.').last.toLowerCase();
//     }Get.to(Pickview(shopname: widget.shopname,shopid: widget.venderid,shopimage: widget.venderimage,status: widget.status,));
//   }
// }
//
//
//
//
//
// class NewWidget extends StatelessWidget {
//   const NewWidget({
//     super.key,
//     required this.initializeVideoPlayerFuture2,
//     required this.controllervideo1,
//   });
//
//   final Future<void> initializeVideoPlayerFuture2;
//   final VideoPlayerController controllervideo1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(left: 1,
//         child: FutureBuilder(
//             future: initializeVideoPlayerFuture2,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState ==
//                   ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator(color: logocolo,)); // Show a loading indicator while the video is initializing
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot
//                     .error}'); // Show an error message if initialization fails
//               } else {
//                 return SizedBox(
//                   height: 100, width: 50,
//                   child: VideoPlayer(controllervideo1),
//                 );
//               }
//             })
//     );
//   }
// }
//
//
// final player = AudioPlayer();
// var findvideo;
// late Future<void> initializeVideoPlayerFuture;
// late VideoPlayerController controllervideo;
//
//
// class Pickview extends StatefulWidget {
//   final shopname;
//   final shopid;
//   final shopimage;
//   final int status;
//
//   const Pickview({super.key, this.shopname, this.shopid,required this.shopimage, required this.status, });
//
//   @override
//   State<Pickview> createState() => _PickviewState();
// }
//
// class _PickviewState extends State<Pickview> {
//   final chat_api = Get.put(meassage_api());
//   // final assetsAudioPlayer = AssetsAudioPlayer();
//
//
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Stack(
//         children: [
//
//           findvideo == "mp3"?
//           SizedBox(
//               height: h,width: w,
//               child: AudioPlayerScreen(urlpath: chat_api.imagePath.value,))
//
//               :
//
//           findvideo == "mp4" ||
//               findvideo == "mov" ||
//               findvideo == "avi" ||
//               findvideo == "mkv"?
//
//
//           FutureBuilder(
//               future: initializeVideoPlayerFuture,
//               builder: (context, snapshot) {
//                 return
//                   Center(
//                     child: SizedBox(
//                       height: h/2,width: w,
//                       child: VideoPlayer(controllervideo),
//                     ),
//                   );}
//           )
//               :
//
//           Obx(() =>
//               Container(
//                 width: w,height: h,
//                 decoration: BoxDecoration(image: DecorationImage(
//                     image:
//                     FileImage(File(
//                         chat_api.imagePath.toString())))
//                 ),
//               )),
//
//
//           Positioned(
//               left: 5,top: h/30,
//               child:
//               IconButton(onPressed: (){
//                 chat_api.imagePath.value="";
//                 Get.back();
//               }, icon:  const Icon(Icons.cancel_outlined,color: logocolo,size: 40,))),
//           Positioned(bottom: 1,right: 5,left: 5,
//             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(decoration: BoxDecoration(color: logocolo,borderRadius: BorderRadius.circular(15),),child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("${widget.shopname}",style: const TextStyle(color: Colors.white)),
//                 )),
//
//                 Obx(() =>
//                 chat_api.loading==true?
//                 const Center(child: CircularProgressIndicator(color: logocolo),):
//                 IconButton(onPressed: ()async{
//                   await   chat_api.chatimageapi(widget.shopid,chat_api.imagePath.value.toString(),widget.shopname,widget.shopimage, widget.status);
//
//                 }, icon: const Icon(Icons.send,color: logocolo,size: 40,))
//                 )
//
//               ],
//             ),
//           )
//
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
// class AudioPlayerScreen extends StatefulWidget {
//   final urlpath;
//   const AudioPlayerScreen({super.key, this.urlpath, });
//   @override
//   _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
// }
//
// class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
//   late AudioPlayer _audioPlayer;
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;
//   bool _isPlaying = false;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//     //_audioPlayer.setSourceDeviceFile(widget.urlpath);
//     _audioPlayer.play(DeviceFileSource(widget.urlpath.toString()),position: const Duration(seconds: 10));
//     _audioPlayer.onDurationChanged.listen((Duration duration) {
//       setState(() {
//         _duration = duration;
//       });
//     });
//
//     // Start a timer to periodically update the current position
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       _audioPlayer.getCurrentPosition().then((Duration? position) {
//         setState(() {
//           _position = position ?? Duration.zero;
//         });
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel(); // Cancel the timer when disposing the screen
//     _audioPlayer.dispose();
//     super.dispose();
//   }
//
//   void _changeSeek(double value) {
//     final newPosition = Duration(seconds: value.toInt());
//     _audioPlayer.seek(newPosition);
//   }
//
//   void _playPause() {
//     if (_isPlaying) {
//       _audioPlayer.pause();
//     } else {
//       _audioPlayer.resume();
//     }
//     setState(() {
//       _isPlaying = !_isPlaying;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Scaffold(backgroundColor: Colors.black,
//
//       body: Center(
//         child: Container(width: w,height: h/3,color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 50.0),
//             child: Column(
//               children: [
//
//                 const Center(child: Icon(Icons.audiotrack_outlined,size: 30),),
//                 Center(child:
//                 _isPlaying ?
//                 IconButton(onPressed: (){
//                   _playPause();
//                 }, icon: const Icon(Icons.play_arrow))
//                     :
//                 IconButton(onPressed: (){
//                   setState(() {
//                     _playPause() ;
//                   });
//                 }, icon: const Icon(Icons.pause))
//                   ,),
//                 // Display seek bar/slider and current position/duration
//
//                 Slider(
//                   value: _position.inSeconds.toDouble(),
//                   inactiveColor: Colors.grey,
//                   onChanged: _changeSeek,
//                   autofocus: true,activeColor: logocolo,
//                   min: 0.0,
//                   max: _duration.inSeconds.toDouble(),
//                 ),
//                 Text('${_position.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_position.inSeconds.remainder(60).toString().padLeft(2, '0')} / ${_duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_duration.inSeconds.remainder(60).toString().padLeft(2, '0')}'),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//
//     );
//   }
// }
//
//
//
//
//
//
//
// // ui in chat
// class VideoWithImagePlaceholder extends StatefulWidget {
//   final String videoUrl;
//   final no;
//   const VideoWithImagePlaceholder({super.key,
//     required this.videoUrl,required this.no,});
//
//   @override
//   _VideoWithImagePlaceholderState createState() =>
//       _VideoWithImagePlaceholderState();
// }
//
// class _VideoWithImagePlaceholderState extends State<VideoWithImagePlaceholder> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl);
//     _initializeVideoPlayerFuture = _controller.initialize().then((value) {
//       _controller.pause();
//       setState(() {});
//       controllervideo.addListener(_videoListener);
//
//     });
//   }
//
//   void _videoListener() {
//     if (controllervideo.value.isPlaying ) {
//       controllervideo.pause();
//     }
//   }
//   @override
//   void dispose() {
//     super.dispose();
//     controllervideo.pause();
//     controllervideo.dispose();}
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         widget.no ==1?
//         FutureBuilder(
//           future: _initializeVideoPlayerFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return Padding(
//                 padding: const EdgeInsets.only(left:  15.0,bottom: 15),
//                 child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
//                   width: 200,height: 150,
//                   child: Stack(
//                     children: [
//                       ClipRRect(borderRadius: BorderRadius.circular(15), child: VideoPlayer(_controller)),
//
//                       GestureDetector(
//                         onTap: (){
//                           Get.to(Videospalyerinmessage(videoslink: widget.videoUrl,));
//                         },
//                         child: Center(
//                           child: Container(decoration: const BoxDecoration(shape: BoxShape.circle,color: logocolo),height: 35,width: 35,
//                             child: Center(
//                               child: Icon(
//                                 _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.white,size: 30,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//               );
//             }
//             else if(snapshot.hasError){
//               print("snapshot${snapshot.error}");
//               return const Text("");
//             }
//             else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         )
//             :
//         FutureBuilder(
//           future: _initializeVideoPlayerFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return Padding(
//                 padding: const EdgeInsets.only(left:  200.0,bottom: 15,right: 15),
//                 child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
//                   width: 200,height: 150,
//                   child: Stack(
//                     children: [
//                       ClipRRect(borderRadius: BorderRadius.circular(15), child: VideoPlayer(_controller)),
//
//                       GestureDetector(
//                         onTap: (){
//                           Get.to(Videospalyerinmessage(videoslink: widget.videoUrl,));
//                         },
//                         child: Center(
//                           child: Container(decoration: const BoxDecoration(shape: BoxShape.circle,color: logocolo),height: 35,width: 35,
//                             child: Center(
//                               child: Icon(
//                                 _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.white,size: 30,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//               );
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
//
//
//
// // paly videos in chat
// class Videospalyerinmessage extends StatefulWidget {
//   final videoslink;
//   const Videospalyerinmessage({super.key, this.videoslink});
//
//   @override
//   State<Videospalyerinmessage> createState() => _VideospalyerinmessageState();
// }
//
// class _VideospalyerinmessageState extends State<Videospalyerinmessage> {
//   late VideoPlayerController _controller1;
//   late Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller1 = VideoPlayerController.network(widget.videoslink);
//     _initializeVideoPlayerFuture = _controller1.initialize().then((value) {
//       _controller1.play();
//
//       setState(() {});
//       controllervideo.addListener(_videoListener);
//
//     });
//   }
//
//   void _videoListener() {
//     if (controllervideo.value.isPlaying ) {
//
//     }
//   }
//   @override
//   void dispose() {
//     super.dispose();
//
//     controllervideo.pause();
//     controllervideo.dispose();}
//
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Scaffold(backgroundColor: Colors.black,
//       appBar: AppBar(),
//       body: FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Center(
//               child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
//                 width:w ,height: h/3,
//                 child: VideoPlayer(_controller1),
//               ),
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
//
//
//
