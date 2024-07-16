import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';
import '../../Api/addressList_api.dart';
import '../../Api/orderplaced_api.dart';
import '../../Controller/button.dart';
import '../../Controller/controller.dart';
import '../../Controller/text2.dart';
import '../../ulits/utils.dart';
import 'add_address/add_address.dart';
import 'checkout_screen.dart';
import '../../../main.dart';

class Selectedaddress extends StatefulWidget {
  const Selectedaddress({super.key,   this.totalamount,  this.paltformfee});
final totalamount;
final paltformfee;

  @override
  State<Selectedaddress> createState() => _SelectedaddressState();
}

class _SelectedaddressState extends State<Selectedaddress> {
  final GetxControllers controller = Get.put(GetxControllers());
  final Address_api addressList = Get.put(Address_api());
  final chekoutt=Get.put(orderplaced());


  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size .width;
    final h = MediaQuery .of(context).size.height;
    return Scaffold(
        backgroundColor:
        darkomdee.darkomde==true?
        Colors.black:
        Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title:const Text("Select Address"),
      ),
    body: SingleChildScrollView(
child:Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color:
              darkomdee.darkomde==true?
              Colors.black:
              Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 1)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Bag",
                    style: A_style_medium,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.black,
                      ))
                ],
              ),
              FutureBuilder(future: chekoutt.checkoutlist_api(), builder: (context, snapshot) {
                print( "hh${chekoutt.checkoutcartlistt}");
                return
                  snapshot.connectionState==ConnectionState.waiting?
                  const Center(child: CircularProgressIndicator(color: logocolo),):
                  chekoutt.checkoutcartlistt.isEmpty?
                  const Text("no product"):

                  SizedBox(height: h/5,
                    child: ListView.builder(
                      itemCount: chekoutt.checkoutcartlistt.elementAt(0).data!.products!.length ,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Material(elevation:1 ,borderRadius: BorderRadius.circular(5),color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    "$image_url${chekoutt.checkoutcartlistt.elementAt(0).data!.products!.elementAt(index).image}",
                                    height: 70,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        );
                      },),
                  )


                ;
              },)
              ,SizedBox(
                height: h / 70,
              ),



            ],
          ),
        ),
        SizedBox(
          height: h / 70,
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 1)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery options",
                style: A_style_text,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => Checkbox(
                    shape: const CircleBorder(),
                    value: chekoutt.isAddress.value==false?true:false,
                    activeColor: const Color(0xff1455ac),
                    onChanged: (newBool) {
                      // setState(() {
                      chekoutt.isAddress.value = false;
                      // });
                    },
                  ))
                  ,
                  Text("Self pick up", style: A_style_medium),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => Checkbox(
                    shape: const CircleBorder(),
                    value: chekoutt.isAddress.value==true?true:false,
                    activeColor: const Color(0xff1455ac),
                    onChanged: (newBool) {
                      // setState(() {
                      chekoutt.isAddress.value = true;
                     // Get.to(orderaddress());
                      // });
                    },
                  ))
                  ,
                  Text("My address", style: A_style_medium),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: h / 70,
        ),
        Obx(() =>
        chekoutt.isAddress.value==true?
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
                addressList.addressList[0].isEmpty?
                GestureDetector(
                  onTap: (){
                    Get.to(const AddAddress());
                  },
                  child: SizedBox(
                      height: h/15,width: w,
                      child: const Center(child: Text("+ Add Address",style: TextStyle(color: Colors.black),))),
                )
                    :
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: addressList.addressList[0].length,
                  itemBuilder: (BuildContext context, int index) {
                    // print("kkkjjjj");
                    // chekoutt.addressId.value =addressList.addressList.value[0][0]["_id"];
                    // print("kkkjjjj${addressList.addressList.value[0][0]
                    // ["_id"].toString()}");
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
        ):const SizedBox()),
        SizedBox(
          height: h / 70,
        ),
        ElevatedButton(
            style: buttonPrimary,
            onPressed: () async{
              print("jgijggj ${ chekoutt.addressIds} ");
    if(  chekoutt.isAddress.value==true && chekoutt.addressIds==""){
      Utils().sendMassage('Please selecte address or add address');
    }

           else if( chekoutt.isAddress.value==true){
             await chekoutt.takeUserAddress();
              Get.to( CheckOutScreen(addressid:  chekoutt.addressIds,deliveryfee:0 , totalamount: widget.totalamount, paltformfee: widget.paltformfee,));

            }
            else{
             Get.to( CheckOutScreen(addressid:  chekoutt.addressIds,deliveryfee:0 , totalamount: widget.totalamount, paltformfee: widget.paltformfee,));
            }},
            child:  Text("Continue", style: A_style_text_inside_button)),



      ]),
)


    )


    );
  }
}

