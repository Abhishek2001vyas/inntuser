import 'package:flutter/material.dart';

//http://157.66.191.24:3038/user/api/
//https://backend.innt.bf/user/api/
var base_url = "https://backend.innt.bf/user/api/";
const image_url = "https://backend.innt.bf/uploads/";

const logocolo = Color(0xff004bad);
const secondryColor = Color(0xff00EFAD);
const black = Colors.black;
const white = Colors.white;
const button_red_color = Color(0xfff58300);

List categorieslist = [
  "assets/images/innt_vibe.png",
  "assets/images/restaurant-cutlery-circular-symbol-of-a-spoon-and-a-fork-in-a-circle.png",
  "assets/images/friends.png",
  "assets/images/wallet.png",
  "assets/images/cam1.png",
  "assets/images/qr-code.png",
  "assets/images/trasaction.png",
  "assets/images/fav.png",
  "assets/images/help.png",
];

List categoriesInntlist = [
  "settings",
  "inntout",
  "friends",
  "mywallet",
  "scan",
  "receive",
  "transfer",
  "favoriteshops",
  "needhelp",
];
List categoriesInntOutlist = [
  "Food and Beverages",
  "Restaurants",
  "Supermarkets",
  "Epiceries",
  "Wine shops / afterwork",
  "Bars / night clubs",
];

List<dynamic> new_arrivalimage = [
  "assets/images/sofa.png",
  "assets/images/tv.png",
  "assets/images/shrits.png",
  "assets/images/toys.png",
  "assets/images/toys.png",
  "assets/images/toys.png",
  "assets/images/toys.png",
];

List new_arrivalname = [
  "Sizzling Glittering Women Neckless",
  "LG Tv",
  "Toys",
  "Toys",
  "LG Tv",
  "Toys",
  "Toys",
];
List productlistimage = [
  "assets/images/shirts.png",
  "assets/images/jeans1.png",
  "assets/images/jeans1.png",
];

List iconimage = [
  "assets/images/fast-delivery.png",
  "assets/images/secure-payment.png",
  "assets/images/exchange.png",
  "assets/images/medal.png"
];

List iconname = [
  "Fast delivery",
  "Secure payment",
  "7 Days Return Policy",
  "100% Authentic Products"
];
final A_style_order_status = TextStyle(
    color: Colors.grey.shade700,
    overflow: TextOverflow.ellipsis,
    fontFamily: "Amazon_med",
    fontSize: 13);
const A_style_order_status_blue = TextStyle(
    color: Color(0xff1455ac),
    overflow: TextOverflow.ellipsis,
    fontFamily: "Amazon_med",
    fontSize: 13);

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: Colors.black87,
  minimumSize: const Size(78, 16),
  padding: const EdgeInsets.symmetric(horizontal: 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);
