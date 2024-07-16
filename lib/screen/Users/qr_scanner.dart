// import 'package:inntuser/ulits/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
// class QrScreen extends StatefulWidget {
//   const QrScreen({super.key});
//
//   @override
//   State<QrScreen> createState() => _QrScreenState();
// }
//
// class _QrScreenState extends State<QrScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   bool qrCodeScanned = false;
//
//   @override
//   Widget build(BuildContext context) {
//     //  final serviceProvider = Provider.of<Services>(context, listen: false);
//     final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Stack(children: [
//         QRView(
//           key: qrKey,
//           onQRViewCreated: (controller) {
//             controller.scannedDataStream.listen((scanData) {
//               print('Scanned Data: ${scanData.code}');
//               setState(() {
//                 result = scanData;
//                 qrCodeScanned = true;
//                 //serviceProvider.makeApiCall(context, scanData.code!);
//               });
//             });
//           },
//           overlay: QrScannerOverlayShape(
//             borderColor: logocolo,
//             borderRadius: 10,
//             borderLength: 30,
//             borderWidth: 10,
//             cutOutSize: 300,
//           ),
//         ),
//         // Positioned(
//         //   bottom: 80,
//         //   child: Align(
//         //     alignment: Alignment.bottomCenter,
//         //     child: Padding(
//         //       padding: const EdgeInsets.all(5.0),
//         //       child: Container(
//         //         width: w,
//         //         child: Text(
//         //           textAlign: TextAlign.center,
//         //           "Scan the QR code of the your favorite store to get associated for delivery service by the store",
//         //           style: TextStyle(color: Colors.white),
//         //         ),
//         //       ),
//         //     ),
//         //   ),
//         // )
//       ]),
//     );
//   }
// }
