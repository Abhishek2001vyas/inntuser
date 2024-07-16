/*
import 'package:inntuser/screen/Users/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Controller/text2.dart';
import '../../../ulits/constant.dart';
import '../cattegory_screen.dart';
import '../productdeatils.dart';
import '../sellers/sellercontroller.dart';

class SavedItem extends StatefulWidget {
  const SavedItem({super.key});

  @override
  State<SavedItem> createState() => _SavedItemState();
}

class _SavedItemState extends State<SavedItem> with TickerProviderStateMixin {
  String selectedItem = 'Move to bag';
  String selectedBagItem = 'Delete item';
  final changeviews = Get.put(Seller());
  late TabController _tabController;
  @override
  void dispose() {
    _tabController.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with the desired number of tabs
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Row(
              children: [
                Spacer(),
                Text("Saved"),
                Spacer(),
                PopupMenuButton(
                  padding: EdgeInsets.all(0),
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  initialValue: selectedBagItem,
                  child: Text(
                    "Select",
                    style: A_style_text_inside_button,
                  ),
                  itemBuilder: (_) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        height: h / 25,
                        value: 'Select multiple',
                        child: Text('Select multiple', style: A_style_medium),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<String>(
                        height: h / 25,
                        value: 'items to delete',
                        child: Text('items to delete', style: A_style_medium),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<String>(
                        height: h / 25,
                        value: 'or send to bag',
                        child: Text('or send to bag', style: A_style_medium),
                      ),
                    ];
                  },
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: h / 25,
                  width: w / 1.56,
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Search in innt",
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black),
                        fillColor: const Color(0xffeef1f5),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(7))),
                  ),
                ),
                PopupMenuButton(
                  padding: EdgeInsets.all(0),
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  initialValue: selectedBagItem,
                  icon: Icon(
                    Icons.filter_list_outlined,
                    color: white,
                  ),
                  itemBuilder: (_) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Filter by',
                        child: Text('Filter by', style: A_style_medium),
                      ),
                      PopupMenuItem<String>(
                        value: 'Most recent',
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.black,
                              size: 4,
                            ),
                            SizedBox(
                              width: w / 80,
                            ),
                            Text("Most recent"),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Least recent',
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.black,
                              size: 4,
                            ),
                            SizedBox(
                              width: w / 80,
                            ),
                            Text("Least recent", style: A_style_medium),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Price',
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.black,
                              size: 4,
                            ),
                            SizedBox(
                              width: w / 80,
                            ),
                            Text('Price', style: A_style_medium),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Shop',
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.black,
                              size: 4,
                            ),
                            SizedBox(
                              width: w / 80,
                            ),
                            Text('Shop', style: A_style_medium),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.grid_view_rounded,
                    color: white,
                  ),
                ),
                SizedBox(width: w/10),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.more_horiz,
                    color: white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child:
    Obx(
    () => changeviews.changeview.value == 0
    ? :,
      ),
    );
  }
}
*/
