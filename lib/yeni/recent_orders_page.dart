import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_ui/product/order_model.dart';

class RecentOrdersPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userID;

  RecentOrdersPage({required this.userID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Geçmiş Siparişler',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.deepPurple, size: 30),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('Orders')
            .where('customerID', isEqualTo: userID)
            .where('delivery', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return Center(child: Text('Daha Önce Sipariş Vermemişsiniz'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order =
                  Orders.fromMap(orders[index].data() as Map<String, dynamic>);
              return Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    'Toplam: ${order.totalprice}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var item in order.items)
                        ListTile(
                          title: Text(
                            '${item.productName}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Adet: ${item.quantity}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          leading: item.productPhoto.isNotEmpty
                              ? Image.network(
                                  item.productPhoto,
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 50,
                                )
                              : Placeholder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: -16),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
