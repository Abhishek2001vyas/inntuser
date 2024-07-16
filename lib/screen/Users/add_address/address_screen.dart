import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/Api/addressList_api.dart';
import 'package:inntuser/screen/Users/add_address/add_address.dart';
import 'package:inntuser/screen/Users/add_address/updateaddress.dart';

import '../../../Controller/controller.dart';
import '../../../main.dart';
import '../../../ulits/constant.dart';
import '../Navgationbar.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final GetxControllers controller = Get.put(GetxControllers());
  final Address_api addressList = Get.put(Address_api());
  TextEditingController addressearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              setState(() {
                currentTab = 4;
              });
              Get.off(const DashBoardScreen());
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 17.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const AddAddress());
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          )
        ],
        title: const Text("Address"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 12.0, left: 12, top: 12),
        child: Column(
          children: [
            SizedBox(
              height: h / 20,
              width: w,
              child: TextFormField(
                controller: addressearch,
                onChanged: (value) {
                  addressList.searchaddress(value);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  fillColor: const Color(0xffeef1f5),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
            SizedBox(height: h / 90),
            Obx(() => addressList.addresssearchlisttt.isEmpty &&
                    addressearch.text.isNotEmpty
                ? const Text("No address")
                : addressList.addresssearchlisttt.isNotEmpty &&
                        addressearch.text.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: addressList.addresssearchlisttt.length,
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
                                          addressList.addresssearchlisttt[index]
                                              ["place_type"],
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
                                            "${addressList.addresssearchlisttt[index]["building_no"]} ${addressList.addresssearchlisttt[index]["village_name"]}${addressList.addresssearchlisttt[index]["city_name"]},  ${addressList.addresssearchlisttt[index]["landmark"]} ${addressList.addresssearchlisttt[index]["state"]}, ${addressList.addresssearchlisttt[index]["pin_code"]}",
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: darkomdee.darkomde == true
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
                                              Get.to(() => updateAddressDetails(
                                                    lat: addressList
                                                                .addresssearchlisttt[
                                                            index]["location"]
                                                        ["coordinates"][1],
                                                    lon: addressList
                                                                .addresssearchlisttt[
                                                            index]["location"]
                                                        ["coordinates"][0],
                                                    addid: addressList
                                                            .addresssearchlisttt[
                                                        index]["_id"],
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
                                            onTap: () {},
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
                                              addressList.deleteAddressListApi(
                                                  addressList
                                                          .addresssearchlisttt[
                                                      index]["_id"]);
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
                      )
                    : FutureBuilder(
                        future: addressList.getAddressListApi(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        addressList.addressList[0].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Material(
                                          elevation: 1,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colors.white,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            margin: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: darkomdee.darkomde == true
                                                  ? Colors.black
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color:
                                                      darkomdee.darkomde == true
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
                                                      addressList.addressList
                                                              .value[0][index]
                                                          ["place_type"],
                                                      style: TextStyle(
                                                        color: darkomdee
                                                                    .darkomde ==
                                                                true
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: darkomdee
                                                                      .darkomde ==
                                                                  true
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
                                                  icon: Icon(
                                                      Icons.more_vert_outlined,
                                                      color:
                                                          darkomdee.darkomde ==
                                                                  true
                                                              ? Colors.white
                                                              : logocolo),
                                                  onSelected: (value) {},
                                                  itemBuilder: (_) {
                                                    return <PopupMenuEntry<
                                                        String>>[
                                                      PopupMenuItem<String>(
                                                        onTap: () {
                                                          Get.to(() =>
                                                              updateAddressDetails(
                                                                lat: addressList.addressList[0]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "location"]
                                                                    [
                                                                    "coordinates"][1],
                                                                lon: addressList.addressList[0]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "location"]
                                                                    [
                                                                    "coordinates"][0],
                                                                addid: addressList
                                                                        .addressList[0]
                                                                    [
                                                                    index]["_id"],
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
                                                              color:
                                                                  Colors.black,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const PopupMenuDivider(),
                                                      PopupMenuItem(
                                                        onTap: () {
                                                          addressList
                                                              .setdeafultaddressApi(
                                                                  addressList.addressList[0]
                                                                          [
                                                                          index]
                                                                      ["_id"]);
                                                        },
                                                        child: const Row(
                                                          children: [
                                                            Text(
                                                                "Set as default"),
                                                            Spacer(),
                                                            Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const PopupMenuDivider(),
                                                      PopupMenuItem(
                                                        onTap: () {
                                                          addressList
                                                              .deleteAddressListApi(
                                                                  addressList.addressList[0]
                                                                          [
                                                                          index]
                                                                      ["_id"]);
                                                        },
                                                        child: const Row(
                                                          children: [
                                                            Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
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
                      )),
          ],
        ),
      ),
    );
  }
}
