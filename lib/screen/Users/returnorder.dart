import 'package:flutter/material.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Controller/text2.dart';
import 'order_details.dart';

class Return extends StatefulWidget {
  final shopid;
  final orderid;
  final productid;

  const Return({super.key, this.shopid, this.orderid, this.productid});

  @override
  State<Return> createState() => _ReturnState();
}

class _ReturnState extends State<Return> {
  TextEditingController reason = TextEditingController();
  var returnservice;
  var returnservicetype;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Return Order"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please write the reason you’d like to return the product",
                style: A_style_text_head2,
              ),
              SizedBox(
                height: h / 50,
              ),
              TextFormField(
                minLines: 5,
                maxLines: null,
                controller: reason,
                decoration: InputDecoration(
                    enabled: true,
                    hintText: "Please write reason",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(
                height: h / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    shape: const CircleBorder(),
                    value: returnservice == 0 ? true : false,
                    activeColor: const Color(0xff1455ac),
                    onChanged: (newBool) {
                      returnservice = 0;
                      returnservicetype = "innt delivery service";
                      print('kkkll${returnservice}');
                    },
                  ),
                  Text("innt delivery service", style: A_style_medium),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    shape: const CircleBorder(),
                    value: returnservice == 1 ? true : false,
                    activeColor: const Color(0xff1455ac),
                    onChanged: (newBool) {
                      returnservice = 1;
                      returnservicetype =
                          "Other delivery service / I return it myself";
                      print('kkkll${returnservice}');
                    },
                  ),
                  Text("Other delivery service / I return it myself",
                      style: A_style_medium),
                ],
              ),
              SizedBox(
                height: h / 20,
              ),
              SizedBox(
                  height: h / 15,
                  width: w,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(logocolo)),
                      onPressed: () {
                        orderlist.orderreturn(
                            widget.productid,
                            widget.orderid,
                            widget.shopid,
                            reason.text,
                            returnservicetype.toString(),
                            context);
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
