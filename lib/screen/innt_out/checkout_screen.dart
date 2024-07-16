import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';
import '../../Api/addressList_api.dart';
import '../../Api/orderplaced_api.dart';
import '../../Controller/text2.dart';
import '../Users/order_success.dart';

class inntoutCheckOutScreen extends StatefulWidget {
  const inntoutCheckOutScreen({super.key,required this.deliveryfee,required this.totalamount,required this.paltformfee, this.addressid});
  final deliveryfee;
  final totalamount;
  final paltformfee;
  final addressid;

  @override
  State<inntoutCheckOutScreen> createState() => _inntoutCheckOutScreenState();
}

class _inntoutCheckOutScreenState extends State<inntoutCheckOutScreen> {
  // bool _isAddress = true;
  final bool _isChecked = false;
  final bool _isWallet = true;
  final bool _isMoney = false;
  final bool _isOthers = false;
  final bool _isDelivery = false;
  final bool _isStore = true;
  final bool _isLoading = false;

  final Address_api addressList = Get.put(Address_api());
  late var index;

  gg(){
    index =   addressList.addressList[0].indexWhere((element) =>element["_id"].toString() == widget.addressid.toString(),);
  }

  final chekoutt=Get.put(orderplaced());
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    gg();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: secondryColor,
        title: const Text("CheckOut"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  FutureBuilder(future: chekoutt.inntoutcheckoutlist_api(), builder: (context, snapshot) {
                    print( "hh${chekoutt.checkoutcartlisttinntout}");
                    return
                      snapshot.connectionState==ConnectionState.waiting?
                      const Center(child: CircularProgressIndicator(color: logocolo),):
                      chekoutt.checkoutcartlisttinntout.isEmpty?
                      const Text("no product"):

                      SizedBox(height: h/5,
                        child: ListView.builder(
                          itemCount: chekoutt.checkoutcartlisttinntout.elementAt(0).data!.products!.length ,
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
                                        "$image_url${chekoutt.checkoutcartlisttinntout.elementAt(0).data!.products!.elementAt(index).image}",
                                        height: 70,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                            );
                          },),
                      )

                    // :Center(child: CircularProgressIndicator(color: logocolo),)
                        ;
                  },)

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Promo code / Gift cards",
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
                      Checkbox(
                        shape: const CircleBorder(),
                        value: true,
                        activeColor: const Color(0xff1455ac),
                        onChanged: (newBool) {
                          // setState(() {

                          // });
                        },
                      )
                      ,
                      Obx(
                            () =>
                        chekoutt.isAddress.value==true?
                        Text("My address", style: A_style_medium):  Text("Self pick up", style: A_style_medium),)
                    ],
                  ),
                  Obx(
                          () =>
                      chekoutt.isAddress.value==true?
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0,bottom: 8),
                        child: Column(
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
                      ):const SizedBox())
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
                    "Pay now",
                    style: A_style_text,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                        shape: const CircleBorder(),
                        value: chekoutt.pay.value==1?true:false,
                        activeColor: const Color(0xff1455ac),
                        onChanged: (newBool) {
                          chekoutt.pay.value=1;  chekoutt.payTypes.value="wallet";
                          print('kkkll${chekoutt.payTypes.value}');
                        },
                      )),
                      Text("My wallet", style: A_style_medium),
                      SizedBox(
                        width: w / 80,
                      ),
                      Image.asset(
                        "assets/images/wallet_check.png",
                        height: h / 13,
                        width: w / 13,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                        shape: const CircleBorder(),
                        value: chekoutt.pay.value==2?true:false,
                        activeColor: const Color(0xff1455ac),
                        onChanged: (newBool) {
                          chekoutt.pay.value=2;  chekoutt.payTypes.value="Orange money";
                          print('kkkll${chekoutt.payTypes.value}'); },
                      )),
                      Text("Orange money", style: A_style_medium),
                      SizedBox(
                        width: w / 80,
                      ),
                      Image.asset(
                        "assets/images/orange_money.png",
                        height: 15,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                        shape: const CircleBorder(),
                        value: chekoutt.pay.value==3?true:false,
                        activeColor: const Color(0xff1455ac),
                        onChanged: (newBool) {
                          chekoutt.pay.value=3;
                          chekoutt.payTypes.value="other";print('kkkll${chekoutt.payTypes.value}');
                        },
                      )),
                      Text("Others", style: A_style_medium),
                      Image.asset(
                        "assets/images/visa.png",
                        height: h / 10,
                        width: w / 10,
                      ),
                      SizedBox(
                        width: w / 80,
                      ),
                      Image.asset(
                        "assets/images/master_card.png",
                        height: h / 10,
                        width: w / 10,
                      ),
                      SizedBox(
                        width: w / 80,
                      ),
                      Image.asset(
                        "assets/images/paypal.png",
                        height: h / 15,
                        width: w / 15,
                      )
                    ],
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
                    "Pay later",
                    style: A_style_text,
                  ),
                Obx(() => chekoutt.isAddress==true?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                        shape: const CircleBorder(),
                        value: chekoutt.pay.value==0?true:false,
                        activeColor: const Color(0xff1455ac),
                        onChanged: (newBool) {
                          chekoutt.pay.value=0;
                        },
                      )),
                      Text("Pay on delivery", style: A_style_medium),
                      Image.asset(
                        "assets/images/delivery.png",
                        height: h / 13,
                        width: w / 13,
                      )
                    ],
                  )
                  :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                        shape: const CircleBorder(),
                        value: chekoutt.pay.value==0?true:false,
                        activeColor: const Color(0xff1455ac),
                        onChanged: (newBool) {
                          chekoutt.pay.value=0;
                        },
                      )),
                      Text("Pay at the store", style: A_style_medium),
                      const Icon(Icons.location_on, color: Colors.black)
                    ],
                  )),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Promo code / Gift cards",
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
                ],
              ),
            ),
            SizedBox(
              height: h / 70,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0,left: 8,bottom: 15,top: 15),
              child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Sub Total"),
                        SizedBox(height: h/50,),
                        const Text("Promo code"), SizedBox(height: h/50,),
                        Obx(() => chekoutt.isAddress.value==true?   const Text("Delivery fee"):const SizedBox()), SizedBox(height: h/50,),
                        const Text("Paltform fee"), SizedBox(height: h/50,),
                        const Text("Total"),
                      ],),
                    Column(crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${widget.totalamount.toStringAsFixed(2)}"), SizedBox(height: h/50,),
                        const Text("apply"), SizedBox(height: h/50,),
                        Obx(() => chekoutt.isAddress.value==true?   Text("${widget.deliveryfee}"):const SizedBox()), SizedBox(height: h/50,),
                        Text("${widget.paltformfee}"), SizedBox(height: h/50,),
                        Text("${(widget.totalamount+widget.paltformfee).toStringAsFixed(2)}"),
                      ],)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: h / 70,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(400, 50),
                    backgroundColor: secondryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                onPressed: () async{
                  var rtr=widget.totalamount+widget.paltformfee;
               await   chekoutt.orderpalceinntout(
                      rtr,
                  );
                  Get.to(const OrderSuccess());
                },
                
                child:  Text("Confirm order", style: A_style_text_inside_button)),
          ],
        ),
      ),
    );
  }
}
