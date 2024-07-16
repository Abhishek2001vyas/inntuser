import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../Api/term_condition_api.dart';
import '../../Controller/controller.dart';


class TermCondition extends StatefulWidget {
  const TermCondition({super.key});

  @override
  State<TermCondition> createState() => _TermConditionState();
}

class _TermConditionState extends State<TermCondition> {
  GetxControllers controller = Get.put(GetxControllers());
  final getterm_condition_api = Get.put(fetchTermCondition());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true, title: const Text("Term & Condition")),
      body: FutureBuilder(
          future: getterm_condition_api.term_Condition(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: logocolo,
              ));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount:
                    getterm_condition_api.termCondition.elementAt(0).length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Html(
                          data:
                          '${getterm_condition_api.termCondition[0][index]["title"]}',
                          style: {
                            "h1": Style(
                              border: const Border(
                                  bottom: BorderSide(color: Colors.grey)),
                            ),
                          }),
                      SizedBox(
                        height: h / 50,
                      ),
                      Html(
                          data:
                          getterm_condition_api.termCondition[0][index]["text"].toString(),
                          style: {
                            "h1": Style(
                              border: const Border(
                                  bottom: BorderSide(color: Colors.grey)),
                            ),
                          }),
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}
