import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inntuser/Controller/text2.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:scan/scan.dart';

import '../../Api/qrsannerafter.dart';
import '../../main.dart';
import 'MyQR.dart';
import 'Receive.dart';
import 'loading.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final qrcodedata = Get.put(Getdatafromqr_api());

  // Barcode? result;
  // QRViewController? controller;
  bool isFlashOn = false;

  @override
  void initState() {
    ff();
    // openCamera();
    // TODO: implement initState
    super.initState();
  }

  ff() async {
    // To read barcode from camera image directly
    await zx.startCameraProcessing();
  }

  static const MethodChannel _channel = MethodChannel(
      'com.google.zxing.client.android.camera.open.OpenCameraInterface');

  static Future<void> openCamera() async {
    final Map<String, dynamic> result = await _channel.invokeMethod('open');
    if (result['camera'] != null) {
      Get.to(const ScanScreen());
      // Use the camera object
    } else {
      // Handle error
    }
  }

  ffff() async {
    // To read barcode from camera image directly
    zx.stopCameraProcessing();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ffff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h / 10,
            ),
            GestureDetector(
              onTap: () {
                //  Get.to(() => SignInScreen());
              },
              child: Center(
                child: DottedBorder(
                  // PathBuilder
                  color: logocolo,
                  dashPattern: const [8, 4],
                  strokeWidth: 2,
                  child: Container(
                    height: h / 1.5,
                    width: w,
                    color: Colors.white.withAlpha(20),
                    child: ReaderWidget(
                      showGallery: false,
                      tryHarder: true,
                      resolution: ResolutionPreset.high,
                      onScanFailure: (p0) {
                        print("ttrrtgreyge" + p0.text.toString());
                      },
                      onScan: (result) async {
                        // Do something with the result

                        print("resultww   ${result.text.toString()}");
                        qrcodedata.qrscannerr(result.text.toString());
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h / 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    await _pickImage();
                    Get.to(Loadingg(
                      code: resulttttt.toString(),
                    ));
                    //   if(resulttttt !=null){ qrcodedata.qrscannerr(resulttttt.toString());}
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        child: Image.asset(
                          fit: BoxFit.fill,
                          "assets/images/album.png",
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: h / 100,
                      ),
                      Text(
                        "Album",
                        style: A_style_medium,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(const MyQr());
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        child: Padding(
                          padding: const EdgeInsets.all(2.5),
                          child: Image.asset(
                            fit: BoxFit.fill,
                            "assets/images/payment.png",
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h / 100,
                      ),
                      Text(
                        "My QR code",
                        style: A_style_medium,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(const MyQrReceive());
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            fit: BoxFit.fill,
                            "assets/images/qr-code.png",
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h / 100,
                      ),
                      Text(
                        "Receive",
                        style: A_style_medium,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  var resulttttt;
  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // Decode QR code from the picked image
      try {
        print("gggghh ${pickedImage.path.runtimeType}");
        print("gggghh1 ${pickedImage.path}");
        XFile xFile = XFile(pickedImage.path);
        print("kkkkkkk ${xFile.path}");
        String path = pickedImage.path.toString();
        print("kkkkkkk ${path}");
        resulttttt = await Scan.parse(path);
        print("jjfhh ${resulttttt}");

        // Future.delayed(Duration(seconds: 10));
        //  Code? resultFromXFile = await zx.readBarcodeImagePathString(path);
        //
        //  print("imageqrcode  ${resultFromXFile.text}");
        //
        //  setState(() {
        //
        //  });
        // Handle pickedImage as required, you might need to use pickedImage.path to get the file path
        // final String qrCode = await QrCodeToolsPlugin.decodeFrom(pickedImage.path);
        // setState(() {
        //   result = Barcode(qrCode, BarcodeFormat.qr);
        // });
      } catch (e) {
        print('Error decoding image: $e');
      }
    }
  }
}
