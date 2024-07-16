import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/Api/addressList_api.dart';
import '../../../Controller/controller.dart';
import '../../../ulits/constant.dart';
import '../../Api/orderplaced_api.dart';

class orderaddress extends StatefulWidget {
  const orderaddress({
    Key? key,
  }) : super(key: key);

  @override
  State<orderaddress> createState() => _orderaddressState();
}

class _orderaddressState extends State<orderaddress> {
  final GetxControllers controller = Get.put(GetxControllers());
  final Address_api addressList = Get.put(Address_api());
  final chekoutt=Get.put(orderplaced());
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Row(
          children: [
            Text("select Address"),

          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 12.0, left: 12, top: 12),
        child:
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
              return
                Obx(() =>
                addressList.addressList.isEmpty?
                const Center(child: Text("Add Address",style: TextStyle(color: Colors.black),))
                    :
                ListView.builder(
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [

                              Obx(() =>
                                  Checkbox(
                                    focusColor: logocolo,
                                    activeColor: logocolo,
                                    checkColor: Colors.white,
                                    value: chekoutt.addressIds.value==addressList.addressList[0][index]["_id"].toString()?true:false,
                                    onChanged: (newValue) {
                                      final selectedAddressId = addressList.addressList[0][index]["_id"].toString();
                                      chekoutt.addressIds.value = selectedAddressId;
                                      print(chekoutt.addressIds.value);
                                                                        },
                                  )
                              )
                              ,
                              SizedBox(
                                width: w / 70,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    addressList.addressList[0][index]
                                    ["place_type"],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Ember",
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: w / 3,
                                    child: Text(
                                      "${addressList.addressList[0][index]["building_no"]} ${addressList.addressList[0][index]["village_name"]}${addressList.addressList[0][index]["city_name"]},  ${addressList.addressList[0][index]["landmark"]} ${addressList.addressList[0][index]["state"]}, ${addressList.addressList[0][index]["pin_code"]}",
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black,
                                        fontFamily: "Ember",
                                        fontSize: 15,
                                      ),
                                      maxLines: 4,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ))
              ;
            }
          },
        ),
      ),
    );
  }
}