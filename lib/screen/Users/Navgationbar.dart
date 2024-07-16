import 'package:flutter/material.dart';
import 'package:inntuser/screen/Users/profile.dart';
import 'package:inntuser/screen/Users/wishlist/wishlist.dart';
import 'package:inntuser/ulits/constant.dart';
import '../../main.dart';
import 'cart_screen.dart';
import 'chatall.dart';
import 'home.dart';

 int currentTab = 0;
class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  // final autoSizeGroup = AutoSizeGroup();
  // to keep track of active tab index
  final List<Widget> screens = [
    const Home_Page(),
    const Wishlist(),
    const Chatall(),
    //Categories(),
    const CartScreen(),
    const Profile(),
  ];

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentTab != 0) {
          setState(() {
            currentTab = 0;
          });
          return false;
        } else {
          if (currentBackPressTime == null ||
              DateTime.now().difference(currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            currentBackPressTime = DateTime.now();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press back again to exit'),
              ),
            );
            return false;
          } else {
            return true;
          }
        }
      },
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(

              unselectedLabelStyle: TextStyle(
                  color: darkomdee.darkomde==true?
                  logocolo:Colors.black ) ,
              selectedLabelStyle: TextStyle(
                  color: darkomdee.darkomde==true?
              logocolo:Colors.black ),
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.black,
              backgroundColor:  darkomdee.darkomde==true?
              Colors.black:Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentTab,
              onTap: (index) {
                setState(() {
                  currentTab = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: currentTab == 0
                        ? Image.asset(
                            "assets/images/home_blue_logo1.png",
                            color: currentTab == 0 ? logocolo :  darkomdee.darkomde==true?
                            Colors.white:Colors.black,
                            height: 22,
                          )
                        : Image.asset(
                            "assets/images/home_blue_logo1.png",
                            color: currentTab == 0 ?  logocolo :  darkomdee.darkomde==true?
                            Colors.white:Colors.black,
                            height: 22,
                          ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: currentTab == 1
                        ? Icon(
                            Icons.favorite,
                            color: currentTab == 1 ? logocolo :  darkomdee.darkomde==true?
                            Colors.white:Colors.black,
                            size: 20,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: currentTab == 1 ? logocolo :  darkomdee.darkomde==true?
                            Colors.white: Colors.black,
                            size: 20,
                          ),
                    label: "Saved"),
                BottomNavigationBarItem(
                    icon: currentTab == 2
                        ? Icon(
                            Icons.message_outlined,
                            color: currentTab == 2 ? logocolo : darkomdee.darkomde==true?
                            Colors.white: Colors.black,
                            size: 20,
                          )
                        : Icon(
                            Icons.message_outlined,
                            color: currentTab == 2 ? logocolo :  darkomdee.darkomde==true?
                            Colors.white:Colors.black,
                            size: 20,
                          ),
                    label: "Message"),
                BottomNavigationBarItem(
                    icon: currentTab == 3
                        ? Icon(
                            Icons.shopping_bag,
                            color: currentTab == 3 ? logocolo : darkomdee.darkomde==true?
                            Colors.white: Colors.black,
                            size: 20,
                          )
                        : Icon(
                            Icons.shopping_bag_outlined,
                            color: currentTab == 3 ? logocolo :  darkomdee.darkomde==true?
                            Colors.white:Colors.black,
                            size: 20,
                          ),
                    label: "Bag"),
                BottomNavigationBarItem(
                    icon: currentTab == 4
                        ? Icon(
                            Icons.person,
                            color: currentTab == 4 ? logocolo : darkomdee.darkomde==true?
                            Colors.white: Colors.black,
                            size: 20,
                          )
                        : Icon(
                            Icons.person_outline_rounded,
                            color: currentTab == 4 ? logocolo : darkomdee.darkomde==true?
                            Colors.white: Colors.black,
                            size: 20,
                          ),
                    label: "Profile"),
              ]),
          backgroundColor: Colors.white,
          body: screens[currentTab]),
    );
  }
}
