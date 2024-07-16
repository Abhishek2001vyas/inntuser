import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Api/addressList_api.dart';
import '../../../Controller/text2.dart';
import '../../../ulits/constant.dart';

class updateAddressDetails extends StatefulWidget {
  final double lat;
  final double lon;
  final addid;
  final iindex;

  const updateAddressDetails({
    super.key,
    required this.lat,
    required this.lon,
    this.addid,
    this.iindex,
  });

  @override
  State<updateAddressDetails> createState() => _updateAddressDetailsState();
}

class _updateAddressDetailsState extends State<updateAddressDetails> {
  final addaddress = Get.put(Address_api());
  final Address_api addressList = Get.put(Address_api());
  LatLng? _center;
  var tagcolor = 0;
  late var tag;
  @override
  void initState() {
    setState(() {
      _center = LatLng(widget.lat, widget.lon);
      print("ifdihdsifjh${widget.lon}");

      addressList.addressList.value[0][widget.iindex]["place_type"] == "Home"
          ? tagcolor = 0
          : addressList.addressList.value[0][widget.iindex]["place_type"] ==
                  "Office"
              ? tagcolor = 1
              : tagcolor = 2;

      addressList.addressList.value[0][widget.iindex]["place_type"] == "Home"
          ? tag = "Home"
          : addressList.addressList.value[0][widget.iindex]["place_type"] ==
                  "Office"
              ? tag = "Office"
              : tag = "other";
    });
    super.initState();
  }

  LatLng? _currentLocation;

  late GoogleMapController _controller;

  //TextEditingController tagController = TextEditingController();
  late TextEditingController villageController = TextEditingController(
      text: addressList.addressList.value[0][widget.iindex]["village_name"]);
  late TextEditingController buildingNoController = TextEditingController(
      text: addressList.addressList.value[0][widget.iindex]["building_no"]);
  late TextEditingController cityNameController = TextEditingController(
      text: addressList.addressList.value[0][widget.iindex]["city_name"]);
  late TextEditingController howtoreachController = TextEditingController(
      text: addressList.addressList.value[0][widget.iindex]["landmark"]);
  late TextEditingController stateController = TextEditingController(
      text: addressList.addressList.value[0][widget.iindex]["state"]);
  late TextEditingController pincodeController = TextEditingController(
      text: addressList.addressList.value[0][widget.iindex]["pin_code"]);

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
                      labelText: '*Building No.', // Placeholder text
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
                      labelText: '*Address', // Placeholder text
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
                      labelText: '*City Name', // Placeholder text
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
                    controller: howtoreachController,
                    decoration: const InputDecoration(
                      labelText: 'How to reach (Optional)', // Placeholder text
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
                      labelText: '*State',
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
                      labelText: '*Pin Code', // Placeholder text
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
              print("dhthytf$tag");
              addaddress.updateeAddaddressapi(
                  cityNameController.text.toString(),
                  buildingNoController.text.toString(),
                  howtoreachController.text.toString(),
                  tag.toString(),
                  stateController.text.toString(),
                  pincodeController.text.toString(),
                  villageController.text.toString(),
                  _center!.latitude.toString(),
                  _center!.longitude.toString(),
                  widget.addid.toString());
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
