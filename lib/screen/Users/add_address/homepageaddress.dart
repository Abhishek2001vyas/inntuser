import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:inntuser/screen/Users/add_address/updateaddress.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:uuid/uuid.dart';

import '../../../Api/addressList_api.dart';
import '../../../Controller/controller.dart';
import '../../../main.dart';
import 'map_screen.dart';

class homepageAddAddress extends StatefulWidget {
  const homepageAddAddress({
    Key? key,
  }) : super(key: key);

  @override
  State<homepageAddAddress> createState() => _homepageAddAddressState();
}

class _homepageAddAddressState extends State<homepageAddAddress> {
  final _controllers = TextEditingController();
  var uuid = const Uuid();

  String k = "d90alvgHTQ-yYTKGJhxPch:"
      "APA91bGQCKn93TPFsEil_meZ4axhd3ywiBNAy2tijOJOtqC"
      "0EFVGJobF6hrde6DGNOEhH05CWUI-HFKfgtFI0gxIBIQ2gPmIJv"
      "8QrM8UsHE_SIIuFf84fMg_M99iurPIn6dL30XZiu84";
  List<dynamic> _placeList = [];
  String tappedPlace = "";
  final Completer<GoogleMapController> _controller = Completer();
  Timer? _debounce;
  String? address;

  @override
  void initState() {
    super.initState();
    _controllers.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      getSuggestion(_controllers.text);
    });
  }

  void getSuggestion(String input) async {
    try {
      String kplacesApiKey =
          "AIzaSyDg64HvMk1LYbkHcnBMzndPu4EuHRjefAQ&libraries=places";
      //   "AIzaSyBL-NPdBE4Mmcr7l5qaA5GwEs2w-yQcjEM&libraries=places";
      String type = '(regions)';
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$kplacesApiKey&sessiontoken=$k';
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        print("jjfdjdojfod${response.body}");
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
        print("oiioefdshih$_placeList");
      } else {
        print(
            'Failed to load predictions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getLocationFromPlaceName(String placeName) async {
    try {
      print("ppp");
      var locations = await locationFromAddress(placeName);
      print("po");
      if (locations.isNotEmpty) {
        Location location = locations.first;
        double latitude = location.latitude;
        double longitude = location.longitude;
        print('lll$location');
        Get.to(() => MapScreen(
              lat: latitude,
              lon: longitude,
            ));
      } else {
        print('No results found for the provided place name.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  final GetxControllers controller = Get.put(GetxControllers());
  final Address_api addressList = Get.put(Address_api());

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: logocolo,
        centerTitle: true,
        title: const Text("Address"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _controllers,
                  decoration: InputDecoration(
                    hintText: "search location",
                    focusColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    suffixIcon: _controllers.text.toString().isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _controllers.clear();
                            },
                          )
                        : null,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  print("ppp");
                  Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );

                  double latitude = position.latitude;
                  double longitude = position.longitude;
                  print("poooo$position");
                  Get.to(() => MapScreen(
                        lat: latitude,
                        lon: longitude,
                      ));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.green.shade700,
                    ),
                    Text(
                      "Use my current location",
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  final place = _placeList[index];

                  return ListTile(
                    title: InkWell(
                      onTap: () async {
                        final placeName = place["description"];
                        if (placeName != null && placeName.isNotEmpty) {
                          await getLocationFromPlaceName(placeName);
                        } else {
                          print("Invalid place name");
                        }
                      },
                      child: Text(
                        place["description"],
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: h / 40,
            ),
            FutureBuilder(
              future: addressList.getAddressListApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: logocolo,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Obx(() => addressList.addressList.isEmpty
                      ? const Center(
                          child: Text(
                          "NO DATA",
                          style: TextStyle(color: Colors.black),
                        ))
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: addressList.addressList[0].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: darkomdee.darkomde == true
                                        ? Colors.black
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: darkomdee.darkomde == true
                                            ? Colors.white
                                            : Colors.grey,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: w / 70,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            addressList.addressList.value[0]
                                                [index]["place_type"],
                                            style: TextStyle(
                                              color: darkomdee.darkomde == true
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontFamily: "Ember",
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            width: w / 1.8,
                                            child: Text(
                                              "${addressList.addressList.value[0][index]["building_no"]} ${addressList.addressList.value[0][index]["village_name"]}${addressList.addressList.value[0][index]["city_name"]},  ${addressList.addressList.value[0][index]["landmark"]} ${addressList.addressList.value[0][index]["state"]}, ${addressList.addressList.value[0][index]["pin_code"]}",
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color:
                                                    darkomdee.darkomde == true
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontFamily: "Ember",
                                                fontSize: 15,
                                              ),
                                              maxLines: 3,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      PopupMenuButton(
                                        color: Colors.white,
                                        icon: Icon(Icons.more_vert_outlined,
                                            color: darkomdee.darkomde == true
                                                ? Colors.white
                                                : logocolo),
                                        onSelected: (value) {},
                                        itemBuilder: (_) {
                                          return <PopupMenuEntry<String>>[
                                            PopupMenuItem<String>(
                                              onTap: () {
                                                Get.to(() =>
                                                    updateAddressDetails(
                                                      lat: addressList
                                                                  .addressList[0]
                                                              [
                                                              index]["location"]
                                                          ["coordinates"][1],
                                                      lon: addressList
                                                                  .addressList[0]
                                                              [
                                                              index]["location"]
                                                          ["coordinates"][0],
                                                      addid: addressList
                                                              .addressList[0]
                                                          [index]["_id"],
                                                      iindex: index,
                                                    ));
                                              },
                                              height: h / 25,
                                              child: const Row(
                                                children: [
                                                  Text("Edit"),
                                                  Spacer(),
                                                  Icon(
                                                    Icons.edit,
                                                    size: 20,
                                                    color: Colors.black,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const PopupMenuDivider(),
                                            PopupMenuItem(
                                              onTap: () {
                                                addressList
                                                    .setdeafultaddressApi(
                                                        addressList
                                                                .addressList[0]
                                                            [index]["_id"]);
                                              },
                                              child: const Row(
                                                children: [
                                                  Text("Set as default"),
                                                  Spacer(),
                                                  Icon(
                                                    Icons.check,
                                                    size: 20,
                                                    color: Colors.black,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const PopupMenuDivider(),
                                            PopupMenuItem(
                                              onTap: () {
                                                addressList
                                                    .deleteAddressListApi(
                                                        addressList
                                                                .addressList[0]
                                                            [index]["_id"]);
                                              },
                                              child: const Row(
                                                children: [
                                                  Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                    color: Colors.red,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ];
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
