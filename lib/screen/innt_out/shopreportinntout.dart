import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Api/productlistbysubsubcat.dart';
import '../../ulits/utils.dart';

class shopReportinntout extends StatefulWidget {
  final shopid;
  final productid;
  final status;
  const shopReportinntout(
      {super.key, this.shopid, this.productid, this.status});

  @override
  State<shopReportinntout> createState() => _shopReportinntoutState();
}

class _shopReportinntoutState extends State<shopReportinntout> {
  final prodreport = Get.put(fetchInntsubsubCategoryproductList());
  TextEditingController title = TextEditingController();
  TextEditingController text = TextEditingController();
  List titlee = ["Suspicious activity", "Product quality", "Delivery", "Other"];
  var titleee = "Product quality";
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondryColor,
        centerTitle: true,
        title: const Text("Shop Report"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Title",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              SizedBox(
                height: h / 50,
              ),
              // TextFormField(
              //   controller: title,
              //   decoration: InputDecoration(
              //       focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(5)),
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(5))),
              // ),
              Container(
                padding: const EdgeInsets.only(left: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 1)),
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(5),
                  isExpanded: true,
                  underline: const SizedBox(),
                  value: titleee,
                  items: titlee.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      titleee = newValue!.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: h / 30,
              ),
              const Text(
                "Message",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              SizedBox(
                height: h / 40,
              ),
              TextFormField(
                controller: text,
                maxLines: null,
                minLines: 5,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(
                height: h / 40,
              ),
              SizedBox(
                  width: w,
                  height: h / 15,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(secondryColor)),
                      onPressed: () {
                        if (title.text.isEmpty || text.text.isEmpty) {
                          Utils().sendMassage('Please all field');
                        } else {
                          prodreport.productreport(
                              widget.productid,
                              widget.shopid,
                              titleee.toString(),
                              text.text.toString(),
                              widget.status);
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
