import 'package:flutter/material.dart';
import 'package:food_order_ui/controllers/cart_controller.dart';
import 'package:food_order_ui/bottom_navigation/bottom_navigation_viewmodel.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({Key? key}) : super(key: key);

  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  final BottomNavigationModel viewModel = Get.put(BottomNavigationModel());

  @override
  void initState() {
    super.initState();
    viewModel.navigateToHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => viewModel.pages[viewModel.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.transparent,
          iconSize: 26,
          elevation: 0,
          currentIndex: viewModel.currentIndex.value,
          onTap: (index) {
            viewModel.currentIndex.value = index;
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: viewModel.getIconColor(0)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: viewModel.getIconColor(1)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: viewModel.getIconColor(2)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: viewModel.getIconColor(3)),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
