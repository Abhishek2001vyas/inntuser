import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../screen/innt_out/marker.dart';
import '../ulits/constant.dart';

class Inntoutshopmap extends GetxController {
  List Inntoutshopmapslist = [];

  Set<Marker> marker = {};

  final List<Marker> _list = const [
    // List of Markers Added on Google Map
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 80.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),

    Marker(
        markerId: MarkerId('2'),
        position: LatLng(25.42796133580664, 80.885749655962),
        infoWindow: InfoWindow(
          title: 'Location 1',
        )),

    Marker(
        markerId: MarkerId('3'),
        position: LatLng(20.42796133580664, 73.885749655962),
        infoWindow: InfoWindow(
          title: 'Location 2',
        )),
  ];

  bool isContainerVisible = false;
  //late LatLng containerPosition;
  LatLng? selectedLatLng;
  Offset? containerPosition;
  bool showContainer = false;
  Future InntoutshopmapList() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(' lat long  ${position.longitude} ${position.latitude}');

    final response =
        await http.post(Uri.parse('${base_url}inntOutShop_list'), body: {
      "longitude": position.longitude.toString(),
      "latitude": position.latitude.toString()
    });
    var decodedData = json.decode(response.body);
    // List privacypolicy = decodedData['data'];
    if (response.statusCode == 200) {
      marker.clear();
      Inntoutshopmapslist.clear();
      Inntoutshopmapslist.add(decodedData);
      List<Marker> customMarkers = [];
      List<MapMarker> markerWidgets() {
        return decodedData["data"]
            .map((l) => MapMarker(l["shop_name"]))
            .toList();
      }

      for (int i = 0; i < decodedData["data"].length; i++) {
        String imgurl =
            "${image_url}${decodedData["data"][i]["upload_frontId"].toString()}";
        Uint8List bytes =
            (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
                .buffer
                .asUint8List();

        marker.add(
          Marker(
            icon: BytesMapBitmap(
              bytes,
              height: 50,
              width: 50,
            ),
            onTap: () {
              print("lkkkmap");
            },
            markerId: MarkerId(decodedData["data"][i]["_id"].toString()),
            position: LatLng(
                double.parse(decodedData["data"][i]["location"]["coordinates"]
                        [1]
                    .toString()),
                double.parse(decodedData["data"][i]["location"]["coordinates"]
                        [0]
                    .toString())),
            infoWindow: InfoWindow(
              title: decodedData["data"][i]["shop_name"].toString(),
            ),
          ),
        );
      }

      print("listt  $marker");
      return Inntoutshopmapslist;

      // return data.map((json) => InntCategoryList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load innt category list');
    }
  }
}
