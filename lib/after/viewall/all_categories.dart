import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/scan_screen.dart';
import 'package:inntuser/screen/Users/sellers/sellerall.dart';
import 'package:inntuser/ulits/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api/innt_categoryList_api.dart';
import '../../Controller/controller.dart';
import '../../Controller/text2.dart';
import '../../language_constant.dart';
import '../../main.dart';
import '../../models/inntCategoryListModel.dart';
import '../../screen/Users/Favorite_shop_list.dart';
import '../../screen/Users/Receive.dart';
import '../../screen/Users/home_search.dart';
import '../../screen/Users/myfriends.dart';
import '../../screen/Users/need_help.dart';
import '../../screen/Users/setting.dart';
import '../../screen/Users/subcatebycat.dart';
import '../../screen/Users/trasferwallet.dart';
import '../../screen/Users/wallet.dart';
import '../../screen/innt_out/dashboardinntout.dart';

class allCategories extends StatefulWidget {
  const allCategories({super.key});

  @override
  State<allCategories> createState() => _CategoriesState();
}

class _CategoriesState extends State<allCategories> {
  late ExpansionTileController _expansionTileController;

  @override
  void initState() {
    super.initState();
    _expansionTileController = ExpansionTileController();
  }

  final getInntCategory_api = Get.put(fetchInntCategoryList());
  bool isSelected = false;
  GetxControllers controller = Get.put(GetxControllers());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      backgroundColor: darkomdee.darkomde == true ? Colors.black : Colors.white,
      appBar: AppBar(
        titleSpacing: 5,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            //Center(child: Text("All categories")),
            SizedBox(
              height: h / 100,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                SizedBox(
                  height: h / 20,
                  width: w / 1.2,
                  child: TextFormField(
                    onTap: () {
                      Get.to(const HomeSearch());
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: AppLocalizations.of(context)!.searchininnt,
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black),
                        fillColor: const Color(0xffeef1f5),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(7))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Text(
                AppLocalizations.of(context)!.shortcuts,
                style: A_style_medium,
              ),
            ),
            GridView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    //   print("----"+categorieslist[1]);
                    if (index == 0) {
                      Get.to(() => const Setting());
                    } else if (index == 1) {
                      Get.to(const DashboardInntOut());
                    } else if (index == 2) {
                      Get.to(const My_friends());
                    } else if (index == 3) {
                      Get.to(const Wallet());
                    } else if (index == 4) {
                      Get.to(() => const ScanScreen());
                    } else if (index == 5) {
                      Get.to(const MyQrReceive());
                    } else if (index == 6) {
                      Get.to(const Trasferwallet());
                    } else if (index == 7) {
                      Get.to(() => const Favshop());
                    } else if (index == 8) {
                      Get.to(const NeedHelp());
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 5)
                            ]),
                        child: Center(
                            child: index == 0
                                ? Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Icon(
                                      Icons.settings,
                                      color: Colors.black,
                                      size: w / 8,
                                    ),
                                  )
                                : index == 2
                                    ? Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.supervisor_account_outlined,
                                          size: w / 8,
                                          color: Colors.grey.shade800,
                                        ),
                                      )
                                    : index == 7
                                        ? Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Icon(
                                              Icons.star_border,
                                              size: w / 8,
                                              color: Colors.grey.shade800,
                                            ),
                                          )
                                        : index == 8
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Icon(
                                                  Icons.question_mark,
                                                  size: w / 8,
                                                  color: Colors.grey.shade800,
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Image.asset(
                                                  categorieslist
                                                      .elementAt(index),
                                                  width: w / 8,
                                                  height: h / 16,
                                                ),
                                              )),
                      ),
                      SizedBox(
                        height: h / 90,
                      ),
                      Center(
                        child: Text(
                            index == 0
                                ? AppLocalizations.of(context)!.setting
                                : index == 1
                                    ? AppLocalizations.of(context)!.inntout
                                    : index == 2
                                        ? AppLocalizations.of(context)!.friends
                                        : index == 3
                                            ? AppLocalizations.of(context)!
                                                .mywallet
                                            : index == 4
                                                ? AppLocalizations.of(context)!
                                                    .scan
                                                : index == 5
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .receive
                                                    : index == 6
                                                        ? AppLocalizations.of(
                                                                context)!
                                                            .transfer
                                                        : index == 7
                                                            ? AppLocalizations
                                                                    .of(
                                                                        context)!
                                                                .favoriteshops
                                                            : AppLocalizations
                                                                    .of(context)!
                                                                .needhelp,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: darkomdee.darkomde == true
                                  ? Colors.white
                                  : Colors.black,
                            )),
                      ),
                    ],
                  ),
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 7,
                childAspectRatio: (MediaQuery.of(context).size.width / 2) /
                    (MediaQuery.of(context).size.height / 3.5),
              ),
            ),
            SizedBox(
              height: h / 90,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.allcategories,
                      style: A_style_medium,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const Sellerall());
                    },
                    child: Text(
                      AppLocalizations.of(context)!.seeshops,
                      style: TextStyle(
                          //letterSpacing: 1.5,
                          //color: Colors.white,
                          color: Colors.blue,
                          fontFamily: "Amazon_med",
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<InntCategoryListModel>>(
              future: getInntCategory_api.categoryList(),
              builder: (context, snapshot) {
                lll();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while waiting for the data
                  return const Center(
                      child: CircularProgressIndicator(
                    color: logocolo,
                  ));
                } else if (snapshot.hasError) {
                  // Display an error message if the future throws an error
                  return Text('Error: ${snapshot.error}');
                } else {
                  // If the future is completed successfully, display the data

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: getInntCategory_api.inntCategory.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.4),
                    ),
                    itemBuilder: (context, index) {
                      final inntCategoryList = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the category screen when tapped
                          Get.to(Subcatby(
                            categoryId: getInntCategory_api
                                .inntCategory[index].sId
                                .toString(),
                            subcate: getInntCategory_api
                                .inntCategory[index].categoryEnglishName
                                .toString(),
                          ));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 5)
                            ],
                            image: const DecorationImage(
                              image:
                                  AssetImage("assets/images/catbackground.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    languagee == "en"
                                        ? getInntCategory_api
                                            .inntCategory[index]
                                            .categoryEnglishName
                                            .toString()
                                        : getInntCategory_api
                                            .inntCategory[index]
                                            .categoryFrenchName
                                            .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: A_style_mid_black,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                              Image.network(
                                "$image_url${getInntCategory_api.inntCategory[index].categoryImage.toString()}",
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.height / 9,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  var languagee;
  lll() async {
    print("hkhfhfff");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    languagee = prefs.get(LAGUAGE_CODE).toString();
    print("jklkljgljbgj $languagee");
  }
}
