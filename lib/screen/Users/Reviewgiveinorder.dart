import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../Api/orderplaced_api.dart';
import '../../Controller/text2.dart';
import '../../ulits/constant.dart';



class Reviewgive extends StatefulWidget {
  final orderid;
  final orderno;
  final shopid;
  final productid;
  const Reviewgive({super.key, this.orderid, this.orderno, this.productid, this.shopid});

  @override
  State<Reviewgive> createState() => _ReviewgiveState();
}

class _ReviewgiveState extends State<Reviewgive> {

  final orderlist=Get.put(orderplaced());
  final TextEditingController comment=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        "Review",
      ),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h/50,),

              Text("Rate Product", style: A_style_text_head2),SizedBox(height: h/50,),
              Container(width: w,height:h/1.5,decoration: const BoxDecoration(color: Colors.white),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h/50,),
                    Center(
                      child:
                      RatingBar.builder(
                        itemSize: 40,
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                        const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.yellow.shade800,
                        ),
                        onRatingUpdate: (rating1) {

                          orderlist.rating.value =rating1.toString();

                          print(orderlist.rating);
                        },
                      ),
                    ), SizedBox(height: h/50,),
                    Text("Please Write your review", style: A_style_text_head2),
                    SizedBox(height: h/50,),
                    TextFormField(
                      controller: comment,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        hintText: "Tell......",
                      ),
                    ),

                  ],
                ),
              ),SizedBox(height: h/50,),
            ],
          ),
        ),

      ),
bottomNavigationBar: Container(
  padding:
  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  height: h / 13,
  decoration: const BoxDecoration(color: Colors.white),
  child: InkWell(
    onTap: () async{
     await orderlist.Revie_api(widget.productid, orderlist.rating.value.toString(), widget.shopid, comment.text.toString());
      },
    child: Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: logocolo, borderRadius: BorderRadius.circular(5)),
      child:
      Center(
        child: Text(
          "Submit",
          style: A_style_text_inside_button,
        ),
      ),
    ),
  ),
) ,
    );
  }
}
