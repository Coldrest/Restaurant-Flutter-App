import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../product/order_model.dart';
import '../user/user_model.dart';

class CartPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CartController cartController = Get.put(CartController());
  final List<Orders> ordersList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<CartController>(
                builder: (controller) {
                  if (controller.cartItems.isEmpty) {
                    return Center(
                      child: Text(
                        'Sepetiniz Boş',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      var cartItem = controller.cartItems[index];
                      return Card(
                        elevation: 2.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            '${cartItem.product.name}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fiyat: ${cartItem.product.price}₺',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Adet: ${cartItem.quantity}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircleAvatar(
                              backgroundImage: cartItem.product.productPhoto !=
                                      null
                                  ? NetworkImage(cartItem.product.productPhoto!)
                                  : null,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.removeProduct(cartItem.product);
                                  controller.update();
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child:
                                        Icon(Icons.remove, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '${cartItem.quantity}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              InkWell(
                                onTap: () {
                                  controller.addProduct(cartItem.product);
                                  controller.update();
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: Center(
                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            GetBuilder<CartController>(
              builder: (controller) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Toplam:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${controller.total}₺',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            GetBuilder<CartController>(
              builder: (controller) => ElevatedButton(
                onPressed: () async {
                  Users? user = await getUser();
                  if (user != null) {
                    if (cartController.cartItems.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sepetiniz Boş'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      String orderID =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      String? customerID = user.userID;
                      String customernamesurname = user.namesurname;
                      String totalprice = cartController.total.toString();

                      List<OrderItem> orderItems = cartController.cartItems
                          .map((cartItem) => OrderItem(
                                productName: cartItem.product.name,
                                productPhoto:
                                    cartItem.product.productPhoto ?? '',
                                quantity: cartItem.quantity,
                              ))
                          .toList();

                      Orders order = Orders(
                        orderID: orderID,
                        customerID: customerID!,
                        customernamesurname: customernamesurname,
                        totalprice: totalprice,
                        delivery: false,
                        items: orderItems,
                      );

                      await _firestore
                          .collection('Orders')
                          .doc(orderID)
                          .set(order.toMap());

                      ordersList.add(order);
                      cartController.clearCart();
                      controller.update();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sipariş Verildi'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  } else {
                    print('Error loading user data.');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Siparişi Tamamla',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Users?> getUser() async {
    try {
      String uid = _auth.currentUser!.uid;

      DocumentSnapshot doc =
          await _firestore.collection('Users').doc(uid).get();

      if (doc.exists) {
        Users user = Users.fromMap(doc.data() as Map<String, dynamic>);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
