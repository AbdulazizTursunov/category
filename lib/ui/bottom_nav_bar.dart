
import 'package:category/ui/all_product/product_screen.dart';
import 'package:category/ui/category_screen/category_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> screens = [];
  int selectIndex =0;
  @override
  void initState() {
    screens = [
      AllProduct(),
      CategoryScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        onTap: (v){
          setState(() {
            selectIndex = v;
          });
        },
          items:const [
        BottomNavigationBarItem(icon: Icon(Icons.production_quantity_limits_rounded),label: "product"),
        BottomNavigationBarItem(icon: Icon(Icons.category_outlined),label: "category"),
      ]),
    );
  }
}
