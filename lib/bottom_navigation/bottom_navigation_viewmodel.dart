import 'package:flutter/material.dart';
import 'package:food_order_ui/yeni/homepage.dart';
import 'package:food_order_ui/yeni/userprofilepage.dart';
import 'package:food_order_ui/yeni/search_page.dart';
import 'package:food_order_ui/yeni/cart_page.dart';
import 'package:get/get.dart';

class BottomNavigationModel extends GetxController {
  RxInt currentIndex = 0.obs;

  final List<Widget> pages = [
    HomePage1(),
    SearchProductPage(),
    CartPage(),
    UserProfilePage11(),
  ];

  Color getIconColor(int index) {
    if (currentIndex.value == index) {
      return Colors.deepPurple;
    }
    return const Color.fromARGB(255, 44, 43, 43);
  }

  void navigateToHomePage() {
    currentIndex.value = 0;
  }
}
