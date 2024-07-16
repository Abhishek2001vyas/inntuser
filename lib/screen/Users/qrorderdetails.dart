import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api/qrsannerafter.dart';
import '../../ulits/constant.dart';

class Qrorderdetails extends StatefulWidget {
  const Qrorderdetails({super.key});

  @override
  State<Qrorderdetails> createState() => _QrorderdetailsState();
}

class _QrorderdetailsState extends State<Qrorderdetails> {


  final qrorderdetailss=Get.put(Getdatafromqr_api());
 var amount = 0.0;


@override
  void initState() {
  amountfunction();

  // TODO: implement initState
    super.initState();
  }

  void amountfunction() {
  for(int i=0;i< qrorderdetailss.profiledata[0]["data"]['products'].length ;i++){
 var   indexx= qrorderdetailss.profiledata[0]["data"]['products'][i];
var aa=indexx["total"]?? 0;
   print("olokoj ${indexx["total"] }");
    amount += double.parse(aa.toString());
  }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Id : ${qrorderdetailss.profiledata[0]["data"]['orderId']}",style: const TextStyle(fontSize: 14),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h/50,),
              Text("Product Details", style: TextStyle(
                //letterSpacing: 2.5,
                //color: Colors.white,
                  color:  Colors.grey.shade900,
                  fontFamily: "Amazon_bold",
                  fontSize: 20)),

              ListView.builder(
                itemCount: qrorderdetailss.profiledata[0]["data"]['products'].length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var dataa= qrorderdetailss.profiledata[0]["data"]['products'][index];
                return   Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200, blurRadius: 5)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          "$image_url${ dataa["image"]}",
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: w/2,
                                      child: Text("${dataa["product_name"]}",
                                          style:    TextStyle(color:  Colors.black, fontSize: 18, fontWeight: FontWeight.w600))),


                                  Text(
                                    "Qty:${dataa["qty"]} ",
                                    style:  TextStyle(
                                      //letterSpacing: 1.5,
                                      //color: Colors.white,
                                        color:  Colors.grey.shade700,
                                        fontFamily: "Amazon_med",
                                        fontSize: 14),
                                  ),
                                  SizedBox(width: w/3,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: dataa["attributes"].length,
                                      itemBuilder: (context, indext) {
                                        return Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            "${ dataa["attributes"][indext]["name"]}: ${dataa["attributes"][indext]["value"]} ",
                                            style:  TextStyle(
                                              //letterSpacing: 1.5,
                                              //color: Colors.white,
                                                color:  Colors.grey.shade700,
                                                fontFamily: "Amazon_med",
                                                fontSize: 14),
                                          ),
                                        );
                                      },),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },),

              SizedBox(
                height: h/50,
              ),
              Text("Order details", style: TextStyle(
                //letterSpacing: 2.5,
                //color: Colors.white,
                  color:  Colors.grey.shade900,
                  fontFamily: "Amazon_bold",
                  fontSize: 20)),

              SizedBox(
                height: h/50,
              ),

              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200, blurRadius: 5)
                    ]),

                child:Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("Total"),
                          SizedBox(
                            height: h/50,
                          ),
                          Text("Shop"), SizedBox(
                            height: h/50,
                          ),
                          Text("Date"), SizedBox(
                            height: h/50,
                          ),
                          Text("Status"),
                        ],
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${amount.toString()} CFA"),
                          SizedBox(
                            height: h/50,
                          ),
                          Text("${qrorderdetailss.profiledata[0]["data"]['shop_name']}"), SizedBox(
                            height: h/50,
                          ),
                          Text("${qrorderdetailss.profiledata[0]["data"]['createdAt'].toString().substring(0,10)}"), SizedBox(
                            height: h/50,
                          ),
                          Text(
                              qrorderdetailss.profiledata[0]["data"]['order_status'].toString()=="0"?
                                  "Ordered":
                              qrorderdetailss.profiledata[0]["data"]['order_status'].toString()=="2"?
                              "Confirmed":
                              qrorderdetailss.profiledata[0]["data"]['order_status'].toString()=="4"?
                              "Packing":
                              qrorderdetailss.profiledata[0]["data"]['order_status'].toString()=="6"?
                              "Shipped":
                              qrorderdetailss.profiledata[0]["data"]['order_status'].toString()=="5"?
                              "Delivered":
                              qrorderdetailss.profiledata[0]["data"]['order_status'].toString()=="1"?
                              "Cancelled":
                             ""


                          ),
                        ],
                      ),
                    ],
                  ),
                ) ,
              )
            ],
          ),
        ),
      ),
    );
  }


}
