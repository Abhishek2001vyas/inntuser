import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'address_details.dart';
import 'address_screen.dart';

class MapScreen extends StatefulWidget {
  final double lat;
  final double lon;

  const MapScreen({super.key, required this.lat, required this.lon});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Save the address to SharedPreferences
  void saveAddressToSharedPreferences(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', address);
  }

  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  LatLng? showLocation;
  String address = "Address not found ";
  Timer? _debounce;
  final _controller1 = TextEditingController();
  var uuid = const Uuid();
  String k = "d90alvgHTQ-yYTKGJhxPch:"
      "APA91bGQCKn93TPFsEil_meZ4axhd3ywiBNAy2tijOJOtqC"
      "0EFVGJobF6hrde6DGNOEhH05CWUI-HFKfgtFI0gxIBIQ2gPmIJv"
      "8QrM8UsHE_SIIuFf84fMg_M99iurPIn6dL30XZiu84";
  final List<dynamic> _placeList = [];
  String tappedPlace = "";

  String? saveduserid;

  @override
  void initState() {
    super.initState();
    showLocation = LatLng(widget.lat, widget.lon);
    print("ppppppp$showLocation");
    //useSavedLocation();
    //_getTappedPlace();
  }

  _onChanged() {
    // if (k == null) {
    //   setState(() {
    //     k = uuid.v4();
    //   });
    // }
    //if (debounce?.isActive ?? false) debounce!.cancel();
    //  _debounce = Timer(const Duration(milliseconds: 500), () {
    // getSuggestion(_controller1.text);
    //  });
  }

  // void getSuggestion(String input) async {
  //   try {
  //     String kPLACES_API_KEY =
  //         "AIzaSyC85iTCGYU-pIeS9fp1agTcHYWjS5XgaxY&libraries=places";
  //     String type = '(regions)';
  //     String baseURL =
  //         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  //     String request =
  //         '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$k';
  //     var response = await http.get(Uri.parse(request)); // Use Uri.parse here
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         _placeList = json.decode(response.body)['predictions'];
  //       });
  //     } else {
  //       print(
  //           'Failed to load predictions. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  // _getTappedPlace() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     tappedPlace = prefs.getString('tappedPlace') ?? "";
  //   });
  // }

  // _setTappedPlace(String value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('tappedPlace', value);
  // }

  Widget _location() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _currentLocation();
          });
        },
        child: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: ClipOval(
            child: Image.asset(
              "assets/images/delivery.png",
              fit: BoxFit.cover,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getLocationFromPlaceName(String placeName) async {
    try {
      List<Location> locations = await locationFromAddress(placeName);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        double latitude = location.latitude;
        double longitude = location.longitude;

        final GoogleMapController controller = await _controller.future;
        await controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(latitude, longitude), zoom: 16)));

        setState(() {
          showLocation = LatLng(latitude, longitude);
        });
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setDouble('latitude', latitude);
        // await prefs.setDouble('longitude', longitude);
        print("kkm;jm${showLocation.toString()}");
        print('Latitudegmapc: $latitude, Longitudegmapc: $longitude');
      } else {
        print('No results found for the provided place name.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(children: [
                GoogleMap(
                  zoomControlsEnabled: false,

                  buildingsEnabled: true,
                  //myLocationEnabled: true,
                  compassEnabled: true,

                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onCameraMove: (CameraPosition? position) {
                    if (showLocation != position!.target) {
                      print("${showLocation}cghcfghfg");
                      setState(() {
                        showLocation = position.target;
                      });
                    }
                  },

                  onCameraIdle: () {
                    showBottomSheet();
                  },
                  initialCameraPosition: CameraPosition(
                    target: showLocation!,
                    zoom: 15.0,
                  ),

                  // markers: markers,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _placeList.length,
                  itemBuilder: (context, index) {
                    final place = _placeList[index];

                    return Container(
                      color: Colors.white,
                      child: ListTile(
                          title: InkWell(
                        onTap: () async {
                          final description = place["description"];
                          print('Tapped place..... $description');
                          try {
                            await getLocationFromPlaceName(description);
                            setState(() {
                              tappedPlace = description;
                              //  _setTappedPlace(description);
                              showBottomSheet();
                              _controller1.clear();
                            });

                            // _setTappedPlace(tappedPlace);
                            getLocationFromPlaceName(tappedPlace);
                          } catch (e) {
                            print('Error: $e');
                          }
                        },
                        child: Text(place["description"]),
                      )),
                    );
                  },
                ),
                _controller1.text.toString() != ""
                    ? const Text("")
                    : Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: _getMarker(),
                        ),
                      ),
                Positioned(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: _location(),
                  ),
                ),
              ]),
            ),
            _controller1.text.toString() != ""
                ? const Text("")
                : Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  address,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            address,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () async {
                                print(
                                    "jkhfjkhdsjkhfihsd${showLocation!.longitude},${showLocation!.latitude}");
                                Get.to(() => AddressDetails(
                                      lon: showLocation!.longitude,
                                      lat: showLocation!.latitude,
                                    ));
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString(
                                    "currentAddress", address);

                                await prefs.setDouble(
                                    'latitude', showLocation!.latitude);
                                await prefs.setDouble(
                                    'longitude', showLocation!.longitude);
                                //   Get.to(() => AddAddress());
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => AddAddress();));
                                // Add your button click functionality here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('Confirm Location',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _getMarker() {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
          // color: Colors.white,
          //borderRadius: BorderRadius.circular(100),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     offset: Offset(0, 3),
          //     spreadRadius: 4,
          //     blurRadius: 6,
          //   ),
          // ],
          ),
      child: ClipOval(
        child: Image.asset(
          "assets/images/delivery.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void showBottomSheet() async {
    if (showLocation != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          showLocation!.latitude, showLocation!.longitude);

      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        setState(() {
          // ${placemark.street},
          widget.lon != showLocation!.longitude;
          widget.lat != showLocation!.latitude;

          address = "${placemark.subLocality}, ${placemark.locality},"
              " ${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}";
          saveAddressToSharedPreferences(address); // Save the address
        });
      }
      // final GoogleMapController controller = await _controller.future;
      // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      //     target: LatLng(showLocation!.latitude, showLocation!.longitude),
      //     zoom: 15)));
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          address,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          height: 35,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setDouble(
                                  'latitude', showLocation!.latitude);
                              await prefs.setDouble(
                                  'longitude', showLocation!.longitude);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddressScreen(),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.green,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text("Change"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    address,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.to(()=>AddressDetails());

                        //  Get.back();
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => AdmApp(),));
                        // Add your button click functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: logocolo,
                      ),
                      child: const Text('Confirm Location'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

      // Automatically close the bottom sheet after 1 second
      Future.delayed(const Duration(milliseconds: 1), () {
        Navigator.of(context).pop(); // Close the bottom sheet
      });
    }
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 15)));
  }
}
