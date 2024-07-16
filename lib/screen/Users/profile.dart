import 'package:inntuser/screen/Users/Navgationbar.dart';
import 'package:inntuser/screen/Users/refer_earn.dart';
import 'package:inntuser/screen/Users/setting.dart';
import 'package:inntuser/screen/Users/view_profile.dart';
import 'package:inntuser/screen/Users/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inntuser/screen/Users/Social_freinds.dart';
import 'package:inntuser/screen/innt_out/dashboardinntout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api/getuserprofile.dart';
import '../../Controller/text2.dart';
import '../../firebase/googlesigin.dart';
import '../../main.dart';
import '../../ulits/constant.dart';
import '../credential/Login/login.dart';
import 'Favorite_shop_list.dart';
import 'Gift_cards.dart';
import 'add_address/address_screen.dart';
import 'contact_us.dart';
import 'coupon.dart';
import 'improvement.dart';
import 'loyalty.dart';
import 'myfriends.dart';
import 'myorder.dart';
import 'need_help.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final getprofile = Get.put(Getuserprofile_api());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:
      darkomdee.darkomde==true?
      Colors.black:
      Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(h / 5.5),
          child: FutureBuilder(
              future: getprofile.userprofile(),
              builder: (context, snapshot) {
                return Stack(children: [
                  Container(
                    height: h / 8.3,
                    color: logocolo,
                  ),
                  Positioned(
                      left: w / 25,
                      right: w / 25,
                      top: h / 15,
                      child: SizedBox(
                        width: w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                               AppLocalizations.of(context)!.profile,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Amazon_bold",
                                fontSize: 20,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const Setting());
                              },
                              child: const Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      )),
                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(
                              backgroundColor: logocolo),
                        )
                      : snapshot.hasError == 'true'
                          ? const Center(
                              child: CircularProgressIndicator(
                                  backgroundColor: logocolo),
                            )
                          : Positioned(
                              child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: h / 17,
                                  ),
                                  Container(
                                    height: h / 10, width: w / 5,
                                    padding: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "$image_url${getprofile.profiledata[0][0]["user_profile"]}"),
                                            fit: BoxFit.fill),
                                        color: logocolo,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 5,
                                        )),
                                  ),
                                  Text(
                                    "${AppLocalizations.of(context)!.hello}, ${getprofile.profiledata[0][0]["first_name"]}",
                                    style:
                                    darkomdee.darkomde==true?
                                    const TextStyle(
                                      //letterSpacing: 2,
                                      //color: Colors.white,
                                        color:
                                        Colors.white,
                                        fontFamily: "Amazon_bold",
                                        fontSize: 23):
                                    A_style_heading,
                                  )
                                ],
                              ),
                            ))
                ]);
              }
              )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color:
                  darkomdee.darkomde==true?
                  Colors.black:
                  Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade50,
                      blurRadius: 1,
                    ),
                  ]),
              child:
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const ViewProfile());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_2_outlined,
                          size: 20,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.profile_information,
                          style: TextStyle(
                              color:
                              darkomdee.darkomde==true?
                              Colors.white:
                              Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const AddressScreen());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_city,
                          size: 20,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                            AppLocalizations.of(context)!.address,
                          style: TextStyle(
                              color:  darkomdee.darkomde==true?
                              Colors.white:Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(onTap: (){
                    Get.to(const Socialfreinds());
                  },
                    child: Row(
                      children: [
                        Image.asset("assets/images/social-media.png",
                            color:  darkomdee.darkomde==true?
                            Colors.white:Colors.grey.shade800,
                            height: h / 30,
                            width: w / 19),
                        // Icon(
                        //   account,
                        //   size: 20,
                        //   color: Colors.grey.shade800,
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.socialaccount,
                          style: TextStyle(
                              color:  darkomdee.darkomde==true?
                              Colors.white:Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(onTap: () {
                    Get.to(const My_friends());
                  },
                    child: Row(
                      children: [
                        Icon(
                          Icons.supervisor_account_outlined,
                          size: 20,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.myfriends,
                          style: TextStyle(
                              color: darkomdee.darkomde==true?
                              Colors.white: Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color:  darkomdee.darkomde==true?
                  Colors.black:Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade50,
                      blurRadius: 1,
                    ),
                  ]),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const MyOrder());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 20,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.myorders,
                          style: TextStyle(
                              color: darkomdee.darkomde==true?
                              Colors.white: Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const Favshop());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_border,
                          size: 20,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.favoriteshops,
                          style: TextStyle(
                              color:  darkomdee.darkomde==true?
                              Colors.white:Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      currentTab=1;
                      Get.offAll(() => const DashBoardScreen());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 20,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.saveditems,
                          style: TextStyle(
                              color:  darkomdee.darkomde==true?
                              Colors.white:Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const Wallet());
                    },
                    child: Row(
                      children: [
                        Image.asset("assets/images/wallet.png",
                            color:  darkomdee.darkomde==true?
                            Colors.white:Colors.grey.shade800,
                            height: h / 28,
                            width: w / 15),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                            AppLocalizations.of(context)!.mywallet,
                          style: TextStyle(
                              color:  darkomdee.darkomde==true?
                              Colors.white:Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color:  darkomdee.darkomde==true?
                  Colors.black:Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade50,
                      blurRadius: 1,
                    ),
                  ]),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                       Get.to(() => const Giftcards());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.card_giftcard,
                          size: 20,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.giftcard,
                          style: TextStyle(
                              color: darkomdee.darkomde==true?
                              Colors.white: Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  Divider(color: Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const Coupon());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          size: 20,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.coupon,
                          style: TextStyle(
                              color:  darkomdee.darkomde==true?
                              Colors.white:Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const ReferEarn());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.contact_phone_outlined,
                          size: 20,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.referearn,
                          style: TextStyle(
                              color: darkomdee.darkomde==true?
                              Colors.white: Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const Loyalty());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.loyalty,
                          size: 20,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.loyaltypoints,
                          style: TextStyle(
                              color:  darkomdee.darkomde==true?
                              Colors.white:Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                  color:  darkomdee.darkomde==true?
                  Colors.black:Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade50,
                      blurRadius: 1,
                    ),
                  ]),
              child: Column(
                children: [
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const DashboardInntOut());
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/restaurant-cutlery-circular-symbol-of-a-spoon-and-a-fork-in-a-circle.png",
                          scale: 2.7,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.inntout,
                          style: TextStyle(
                              color:  darkomdee.darkomde==true?
                              Colors.white:Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),


                  const SizedBox(
                    height: 5,
                  ),

                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color:  darkomdee.darkomde==true?
                  Colors.black:Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade50,
                      blurRadius: 1,
                    ),
                  ]),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(const NeedHelp());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.question_mark,
                          size: 20,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.needhelp,
                          style: TextStyle(
                              color: darkomdee.darkomde==true?
                              Colors.white: Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(color:  darkomdee.darkomde==true?
                  Colors.white:Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      //  Get.to(Coupon());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_rate,
                          size: 20,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.rateinnt,
                          style: TextStyle(
                              color:  darkomdee.darkomde==true?
                              Colors.white:Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color:  darkomdee.darkomde==true?
                          Colors.white:Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                        Get.to(const Improvement());
                    },
                    child: Row(
                      children: [
                        Image.asset("assets/images/idea.png",
                            color: darkomdee.darkomde==true?
                            Colors.white: Colors.grey.shade800,
                            height: h / 30,
                            width: w / 19),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.anyimprovementsuggestions,
                          style: TextStyle(
                              color:  darkomdee.darkomde==true?
                              Colors.white:Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const ContactUs());
                    },
                    child: Row(
                      children: [
                        Image.asset("assets/images/operator.png",
                            color: darkomdee.darkomde==true?
                            Colors.white: Colors.grey.shade800,
                            height: h / 30,
                            width: w / 19),
                        // Icon(
                        // ,
                        //   size: 20,
                        //   color: Colors.grey.shade800,
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.contactus,
                          style: TextStyle(
                              color: darkomdee.darkomde==true?
                              Colors.white: Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(color:  darkomdee.darkomde==true?
                  Colors.white:Colors.grey.shade200),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Fir().sigOut();
                      showMyDialog(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 20,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.logout,
                          style: TextStyle(
                              color: darkomdee.darkomde==true?
                              Colors.white: Colors.grey.shade800,
                              fontSize: 16,
                              fontFamily: "Amazon_med"),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: darkomdee.darkomde==true?
                          Colors.white: Colors.grey.shade800,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showMyDialog(BuildContext context) async {
  final h = MediaQuery.of(context).size.height;
  final w = MediaQuery.of(context).size.width;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Center(
            child: Icon(Icons.login_sharp, size: 30, color: Color(0xff1455ac))),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Logout from User App?',
                style: TextStyle(
                    color: Colors.black, fontSize: 17, fontFamily: "Ember"),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: w / 5,
                decoration: BoxDecoration(
                    color: const Color(0xff1455ac),
                    borderRadius: BorderRadius.circular(8)),
                child: TextButton(
                  style: flatButtonStyle,
                  onPressed: ()async {
                    var sharedPreferences = await SharedPreferences.getInstance();
                     sharedPreferences.remove("user_id");
                    Get.offAll(() => const Login_email());
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Ember_Bold"),
                  ),
                ),
              ),
              Container(
                width: w / 5,
                decoration: BoxDecoration(
                    color: const Color(0xff1455ac),
                    borderRadius: BorderRadius.circular(8)),
                child: TextButton(
                  style: flatButtonStyle,
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Ember_Bold"),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
