import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_ui/product/order_model.dart';

class AdminOrdersPage extends StatefulWidget {
  @override
  _AdminOrdersPageState createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bekleyen Siparişler',
          style: TextStyle(color: Colors.deepPurple),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.deepPurple, size: 28),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('Orders')
            .where('delivery', isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return Center(
                child: Text(
              'Bekleyen Sipariş Yok',
              style: TextStyle(
                  color: Colors.deepPurple, fontWeight: FontWeight.bold),
            ));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order =
                  Orders.fromMap(orders[index].data() as Map<String, dynamic>);
              return Card(
                shadowColor: Colors.deepPurple,
                elevation: 5,
                margin: EdgeInsets.all(16),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  title: Text(
                    'Sipariş Veren: ${order.customernamesurname}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        'Tutar: ${order.totalprice}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      for (var item in order.items)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('${item.productName}'),
                          subtitle: Text('Adet: ${item.quantity}'),
                          leading: item.productPhoto.isNotEmpty
                              ? Image.network(
                                  item.productPhoto,
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                )
                              : Placeholder(),
                        ),
                      SizedBox(height: 8),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _firestore
                          .collection('Orders')
                          .doc(order.orderID)
                          .update({'delivery': true});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sipariş Onaylandı'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: Text(
                      'Onayla',
                      style: TextStyle(color: Colors.white),
                    ),
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
