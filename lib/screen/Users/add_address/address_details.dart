import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Api/addressList_api.dart';
import '../../../Controller/text2.dart';
import '../../../ulits/constant.dart';

class AddressDetails extends StatefulWidget {
  final double lat;
  final double lon;

  const AddressDetails({
    super.key,
    required this.lat,
    required this.lon,
  });

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  final addaddress = Get.put(Address_api());
  LatLng? _center;
  var tagcolor = 0;
  var tag = "Home";
  @override
  void initState() {
    super.initState();
    setState(() {
      _center = LatLng(widget.lat, widget.lon);
      print("ifdihdsifjh${widget.lon}");
    });
  }

  LatLng? _currentLocation;

  late GoogleMapController _controller;

  //TextEditingController tagController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController buildingNoController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController howtoreachController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Address Details",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h / 3,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _center!,
                  zoom: 13.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('current_location'),
                    position: _center!,
                    infoWindow: const InfoWindow(
                      title: 'Current Location',
                      snippet: 'This is your current location',
                    ),
                  ),
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: buildingNoController,
                    decoration: const InputDecoration(
                      labelText: 'Building No. (optional)', // Placeholder text
                      labelStyle: TextStyle(color: Colors.black),
                      // Placeholder text
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black)), // Border style
                      // Border style
                    ),
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                  TextField(
                    controller: villageController,
                    decoration: const InputDecoration(
                      labelText: 'Address (optional)', // Placeholder text
                      labelStyle: TextStyle(color: Colors.black),
                      // Placeholder text
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black)), // Border style
                      // Border style
                    ),
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                  TextField(
                    controller: cityNameController,
                    decoration: const InputDecoration(
                      labelText: 'City Name (optional)', // Placeholder text
                      labelStyle: TextStyle(color: Colors.black),
                      // Placeholder text
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black)), // Border style
                      // Border style
                    ),
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                  TextField(
                    controller: stateController,
                    decoration: const InputDecoration(
                      labelText: 'State (optional)',
                      labelStyle: TextStyle(color: Colors.black),
                      // Placeholder text
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black)), // Border style
                    ),
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                  TextField(
                    controller: pincodeController,
                    decoration: const InputDecoration(
                      labelText: 'Pin Code (optional)', // Placeholder text
                      labelStyle: TextStyle(color: Colors.black),
                      // Placeholder text
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black)), // Border style
                      // Border style
                    ),
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            tagcolor = 0;
                            tag = "Home";
                          });
                          //Get.to(DashBoardScreen());
                        },
                        child: Container(
                          width: w / 3.5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              color: tagcolor == 0 ? logocolo : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300, blurRadius: 3)
                              ]),
                          child: Text(
                            "Home",
                            style: TextStyle(
                                //letterSpacing: 2.5,
                                color:
                                    tagcolor == 0 ? Colors.white : Colors.black,
                                // color: Colors.grey.shade900,
                                fontFamily: "Amazon_bold",
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            tagcolor = 1;
                            tag = "Office";
                          });
                        },
                        child: Container(
                          width: w / 3.5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                              color: tagcolor == 1 ? logocolo : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300, blurRadius: 3)
                              ]),
                          child: Text(
                            "Office",
                            style: TextStyle(
                                //letterSpacing: 2.5,
                                color:
                                    tagcolor == 1 ? Colors.white : Colors.black,
                                // color: Colors.grey.shade900,
                                fontFamily: "Amazon_bold",
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            tagcolor = 2;
                            tag = "Other";
                          });
                        },
                        child: Container(
                          width: w / 3.5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                              color: tagcolor == 2 ? logocolo : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300, blurRadius: 3)
                              ]),
                          child: Text(
                            "Other",
                            style: TextStyle(
                                //letterSpacing: 2.5,
                                color:
                                    tagcolor == 2 ? Colors.white : Colors.black,
                                // color: Colors.grey.shade900,
                                fontFamily: "Amazon_bold",
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            onPressed: () async {
              addaddress.Addaddressapi(
                cityNameController.text.toString(),
                buildingNoController.text.toString(),
                howtoreachController.text.toString(),
                tag.toString(),
                stateController.text.toString(),
                pincodeController.text.toString(),
                villageController.text.toString(),
                _center!.latitude.toString(),
                _center!.longitude.toString(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: logocolo,
            ),
            child: const Text('Confirm Location', style: A_style_medium_white),
          ),
        ),
      ),
    );
  }
}
