import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/inntoutshoplistmap.dart';

class Locationinntout extends StatefulWidget {
  const Locationinntout({super.key});

  @override
  State<Locationinntout> createState() => _LocationinntoutState();
}

class _LocationinntoutState extends State<Locationinntout> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    geoclocation();
    // _marker.addAll(_list);
  }

  final shopmapss = Get.put(Inntoutshopmap());
  void geoclocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 12,
      );
    });
  }

  late CameraPosition _kGooglePlex;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondryColor,
        title: const Text("Innt out shops"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            initialCameraPosition: _kGooglePlex,
            // mapType: MapType.normal,
            // on below line setting user location enabled.
            myLocationEnabled: true, markers: shopmapss.marker,
            // on below line setting compass enabled.
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ],
      ),
    );
  }

  Future<Offset?> getScreenCoordinate(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    ScreenCoordinate screenCoordinate =
        await controller.getScreenCoordinate(latLng);
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      return renderBox.globalToLocal(
          Offset(screenCoordinate.x.toDouble(), screenCoordinate.y.toDouble()));
    }
    return null;
  }
}
