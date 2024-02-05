import 'package:food_order_ui/product/product_model.dart';
import 'package:get/get.dart';

import '../product/order_model.dart';

class CartItem {
  Products product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  OrderItem toOrderItem() {
    return OrderItem(
      productName: product.name,
      productPhoto: product.productPhoto ?? '',
      quantity: quantity,
    );
  }
}

class CartController extends GetxController {
  var _cartItems = <CartItem>[].obs;

  void addProduct(Products product) {
    var index = _cartItems.indexWhere((item) => item.product == product);
    if (index != -1) {
      _cartItems[index].quantity += 1;
    } else {
      _cartItems.add(CartItem(product: product, quantity: 1));
    }
  }

  void removeProduct(Products product) {
    var index = _cartItems.indexWhere((item) => item.product == product);
    if (index != -1 && _cartItems[index].quantity == 1) {
      _cartItems.removeAt(index);
    } else {
      _cartItems[index].quantity -= 1;
    }
  }

  void clearCart() {
    _cartItems.clear();
  }

  List<CartItem> get cartItems => _cartItems;

  List<OrderItem> get orderItems =>
      _cartItems.map((item) => item.toOrderItem()).toList();

  num get total {
    if (_cartItems.isEmpty) {
      return 0.0;
    }

    return _cartItems
        .map((item) => item.product.price * item.quantity)
        .fold<num>(0, (previous, element) => previous + element);
  }
}
