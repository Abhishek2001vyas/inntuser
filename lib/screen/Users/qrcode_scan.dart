import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../Controller/text2.dart';

class QRCodeScan extends StatefulWidget {
  final qrcode;
  final qrname;

  const QRCodeScan({super.key, this.qrcode, this.qrname});

  @override
  State<QRCodeScan> createState() => _QRCodeScanState();
}

class _QRCodeScanState extends State<QRCodeScan> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "QR Codes",
        ),
        actions: [
          IconButton(
              onPressed: () {
                //  Get.to(() => CreateQRCode());
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h / 15,
            ),

            Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: const Color(0xD7E2F1FF),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Order Id: ${widget.qrname}",
                  style: TextStyle(
                      color: const Color(0xff1455ac),
                      fontSize: 17,
                      overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                )),
            SizedBox(
              height: h / 50,
            ),
            GestureDetector(
              onTap: () {
                //  Get.to(() => SignInScreen());
              },
              child: Container(
                width: w / 1.3,
                child: PrettyQrView.data(
                    data: '${widget.qrcode ?? "0.0"}',
                    decoration: const PrettyQrDecoration(
                        shape: PrettyQrSmoothSymbol(roundFactor: 0))
                    // decoration:  PrettyQrDecoration(
                    //   image: PrettyQrDecorationImage(
                    //     image: AssetImage('assets/images/th-_1_.jpg'),
                    //   ),
                    // ),
                    ),
              ),
            ),
            // SizedBox(
            //   height: h / 40,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(1),
            //     border: Border.all(color: Colors.black),
            //   ),
            //   child: Text(
            //     "${widget.qrname}",
            //     style: A_style_medium,
            //   ),
            // ),
            SizedBox(
              height: h / 3.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    _shareQrCodesaveimage(w, h, widget.qrname);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/download.png",
                        height: 42,
                        width: 42,
                      ),
                      SizedBox(
                        height: h / 100,
                      ),
                      Text(
                        "Save",
                        style: A_style_medium,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _shareQrCode(w, h);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/share.png",
                        height: 42,
                        width: 42,
                      ),
                      SizedBox(
                        height: h / 100,
                      ),
                      Text(
                        "Share",
                        style: A_style_medium,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _shareQrCodesaveimage(w, h, name) async {
    Screenshot(
      controller: screenshotController,
      child: Container(
        color: Colors.white,
        width: w,
        height: h / 2,
        child: Column(
          children: [
            Text("Innt"),
            SizedBox(
              height: h / 40,
            ),
            Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: const Color(0xD7E2F1FF),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Order Id: ${widget.qrname}",
                  style: TextStyle(
                      color: const Color(0xff1455ac),
                      fontSize: 17,
                      overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                )),
            SizedBox(
              height: h / 50,
            ),
            GestureDetector(
              onTap: () {
                //  Get.to(() => SignInScreen());
              },
              child: Container(
                width: w / 1.3,
                child: PrettyQrView.data(
                    data: '${widget.qrcode ?? "0.0"}',
                    decoration: const PrettyQrDecoration(
                        shape: PrettyQrSmoothSymbol(roundFactor: 0))
                    // decoration:  PrettyQrDecoration(
                    //   image: PrettyQrDecorationImage(
                    //     image: AssetImage('assets/images/th-_1_.jpg'),
                    //   ),
                    // ),
                    ),
              ),
            ),
            SizedBox(
              height: h / 50,
            ),
          ],
        ),
      ),
    );

    print("kkkk333");
    final directory = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    print("dddd $directory");
    try {
      final image = await screenshotController.captureAndSave(directory);
      if (image != null) {
        print("image $image");

        // Now you can proceed with the rest of your code
        String fileName = DateTime.now().microsecondsSinceEpoch.toString();
        final imagePath = await File('$directory/$fileName.png').create();
        if (imagePath != null) {
          print("imagePath: $imagePath");
          // await imagePath.writeAsBytes(image);
          // Share.shareXFiles([XFile(imagePath.path) ]);
        }
      } else {
        print("Error: Image is null");
      }
    } catch (error) {
      print('Error33 --->> $error');
    }
    //     .then((image) async {
    //   print("image $image");
    //   // if (image != null) {
    //   //   try {
    //   //     String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    //   //     final imagePath = await File('$directory/$fileName.png').create();
    //   //     if (imagePath != null) {
    //   //       print("image !${imagePath}");
    //   //       // await imagePath.writeAsBytes(image);
    //   //       // Share.shareXFiles([XFile(imagePath.path) ]);
    //   //     }
    //   //   } catch (error) {
    //   //     print("errrrr333 ${error}");
    //   //   }
    //   // }
    // }).catchError((onError) {
    //   print('Error33 --->> $onError');
    // }
    // );
  }

  _shareQrCode(w, h) async {
    print("kkkk");
    final directory = (await getApplicationDocumentsDirectory()).path;
    await screenshotController
        .captureFromWidget(Container(
      color: Colors.white,
      width: w,
      height: h / 2,
      child: Column(
        children: [
          Text("Innt", style: TextStyle(color: Colors.black)),
          SizedBox(
            height: h / 40,
          ),
          Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: const Color(0xD7E2F1FF),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                "Order Id: ${widget.qrname}",
                style: TextStyle(
                    color: const Color(0xff1455ac),
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis),
                maxLines: 2,
              )),
          SizedBox(
            height: h / 50,
          ),
          GestureDetector(
            onTap: () {
              //  Get.to(() => SignInScreen());
            },
            child: Container(
              width: w / 2,
              child: PrettyQrView.data(
                  data: '${widget.qrcode ?? "0.0"}',
                  decoration: const PrettyQrDecoration(
                      shape: PrettyQrSmoothSymbol(roundFactor: 0))
                  // decoration:  PrettyQrDecoration(
                  //   image: PrettyQrDecorationImage(
                  //     image: AssetImage('assets/images/th-_1_.jpg'),
                  //   ),
                  // ),
                  ),
            ),
          ),
          SizedBox(
            height: h / 50,
          ),
        ],
      ),
    ))
        .then((image) async {
      print("image $image");
      if (image != null) {
        try {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.png').create();
          if (imagePath != null) {
            await imagePath.writeAsBytes(image);
            Share.shareXFiles([XFile(imagePath.path)]);
          }
        } catch (error) {
          print("errrrr ${error}");
        }
      }
    }).catchError((onError) {
      print('Error --->> $onError');
    });
  }

// Future<void> _captureAndSharePng() async {
//   try {
//     RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
//     var image = await boundary.toImage();
//     ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
//     Uint8List pngBytes = byteData.buffer.asUint8List();       final tempDir = await getTemporaryDirectory();
//     final file = await new File('${tempDir.path}/image.png').create();
//     await file.writeAsBytes(pngBytes);
//     final channel = const MethodChannel('channel:me.alfian.share/share');
//     channel.invokeMethod('shareFile', 'image.png');
//   } catch(e) {
//     print(e.toString());
//   }
// }
}
