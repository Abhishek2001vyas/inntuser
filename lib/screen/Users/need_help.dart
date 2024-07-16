import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:inntuser/Api/need_help.dart';
import 'package:inntuser/ulits/constant.dart';

import '../../Controller/controller.dart';

class NeedHelp extends StatefulWidget {
  const NeedHelp({super.key});

  @override
  State<NeedHelp> createState() => _NeedHelpState();
}

class _NeedHelpState extends State<NeedHelp> {
  GetxControllers controller = Get.put(GetxControllers());
  final getneed_help = Get.put(fetchNeedHelp());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true, title: const Text("Need Help")),
      body: FutureBuilder(
          future: getneed_help.need_Help(),
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
                itemCount: getneed_help.needHelp.elementAt(0).length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Theme(
                        data: theme,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ExpansionTile(
                            iconColor: Colors.black,
                            collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            collapsedBackgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            title:
                            Text(
                              getneed_help.needHelp[0][index]["title"],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            onExpansionChanged: (value) {

                            },
                            backgroundColor: Colors.white,
                            childrenPadding: const EdgeInsets.all(10),
                            children: <Widget>[

                              Html(
                                  data:
                                  getneed_help.needHelp[0][index]["text"].toString(),
                                  style: {
                                    "text-align":Style(textAlign:  TextAlign.justify),
                                    "h1": Style(
                                      border: const Border(
                                          bottom: BorderSide(color: Colors.grey)),
                                    ),
                                  }),
                              ],
                          ),
                        ),
                      ),
                      
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}
