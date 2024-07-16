// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:image_picker/image_picker.dart';
//
// class PaymentQrScanner extends StatefulWidget {
//   const PaymentQrScanner({Key? key}) : super(key: key);
//
//   @override
//   State<PaymentQrScanner> createState() => _PaymentQrScannerState();
// }
//
// class _PaymentQrScannerState extends State<PaymentQrScanner> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;
//   bool isFlashOn = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _handle();
//     super.initState();
//   }
//   _handle() async {
//     final sstatus = await Permission.camera.request();
//     var status = await Permission.camera.status;
//     Permission.camera.onDeniedCallback(() =>  Permission.camera.request());
//   }
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 800,
//                   child: QRView(
//                     key: qrKey,
//                     onQRViewCreated: _onQRViewCreated,
//                     overlay: QrScannerOverlayShape(
//                       borderColor: Colors.red,
//                       borderRadius: 10,
//                       borderLength: 30,
//                       borderWidth: 10,
//                       cutOutSize: size.width * 0.6,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 16,
//                   right: 16,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       IconButton(
//                         icon: Icon(
//                           isFlashOn ? Icons.flash_on : Icons.flash_off,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             isFlashOn = !isFlashOn;
//                             controller?.toggleFlash();
//                           });
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.add_a_photo_outlined,
//                           color: Colors.white,
//                         ),
//                         onPressed: _pickImage,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 16,
//                   left: 10,
//                   right: 10,
//                   child: Column(
//                     children: [
//                       if (result != null) ...[
//                         SizedBox(height: 20),
//                         Container(
//                           color: Colors.grey[200],
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Payment Details  ${result!.format}',
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                 'Amount: ${result!.code}',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                 'Recipient: John Doe',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                 'Description: Payment for goods',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//         // Handle payment details here
//         // Example: parsePaymentData(result.code);
//       });
//     });
//   }
//
//   Future<void> _pickImage() async {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       // Decode QR code from the picked image
//       try {
//         // Handle pickedImage as required, you might need to use pickedImage.path to get the file path
//         // final String qrCode = await QrCodeToolsPlugin.decodeFrom(pickedImage.path);
//         // setState(() {
//         //   result = Barcode(qrCode, BarcodeFormat.qr);
//         // });
//       } catch (e) {
//         print('Error decoding image: $e');
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
