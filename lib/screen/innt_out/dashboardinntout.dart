import 'package:flutter/material.dart';

import '../../ulits/constant.dart';
import 'innt_out_cart.dart';
import 'innt_out_home.dart';
import 'innt_out_order.dart';

int selectedindex = 0;
class DashboardInntOut extends StatefulWidget {
  const DashboardInntOut({Key? key}) : super(key: key);

  @override
  State<DashboardInntOut> createState() => _DashboardInntOutState();
}

class _DashboardInntOutState extends State<DashboardInntOut> {


  final List<Widget> screens = [
    const InntOutHome(),
    const InntOutCartScreen(),
    const InntOutMyOrder(),
  ];

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        if (selectedindex != 0) {
          setState(() {
            selectedindex = 0;
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
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.black,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedindex,
              onTap: (index) {
                setState(() {
                  selectedindex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: selectedindex == 0
                        ? Icon(
                            Icons.home,
                            color: selectedindex == 0
                                ? secondryColor
                                : Colors.black,
                            size: 20,
                          )
                        : Icon(
                            Icons.home_outlined,
                            color: selectedindex == 0
                                ? secondryColor
                                : Colors.black,
                            size: 20,
                          ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: selectedindex == 1
                        ? Icon(
                            Icons.shopping_cart_rounded,
                            color: selectedindex == 1
                                ? secondryColor
                                : Colors.black,
                            size: 20,
                          )
                        : Icon(
                            Icons.shopping_cart_outlined,
                            color: selectedindex == 1
                                ? secondryColor
                                : Colors.black,
                            size: 20,
                          ),
                    label: "Cart"),
                BottomNavigationBarItem(
                    icon: selectedindex == 2
                        ? Icon(
                            Icons.contact_page,
                            color: selectedindex == 2
                                ? secondryColor
                                : Colors.black,
                            size: 20,
                          )
                        : Icon(
                            Icons.contact_page_outlined,
                            color: selectedindex == 2
                                ? secondryColor
                                : Colors.black,
                            size: 20,
                          ),
                    label: "Orders"),
              ]),
          backgroundColor: Colors.white,
          body: screens[selectedindex]),
    );
  }
}
