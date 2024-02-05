class OrderItem {
  String productName;
  String productPhoto;
  int quantity;

  OrderItem({
    required this.productName,
    required this.productPhoto,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productPhoto': productPhoto,
      'quantity': quantity,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productName: map['productName'],
      productPhoto: map['productPhoto'],
      quantity: map['quantity'],
    );
  }
}

class Orders {
  String? orderID;
  String customerID;
  String customernamesurname;
  String totalprice;
  bool delivery;
  List<OrderItem> items;

  Orders({
    this.orderID,
    required this.customerID,
    required this.customernamesurname,
    required this.totalprice,
    required this.delivery,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderID': orderID,
      'customerID': customerID,
      'customernamesurname': customernamesurname,
      'totalprice': totalprice,
      'delivery': delivery,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  factory Orders.fromMap(Map<String, dynamic> map) {
    return Orders(
      orderID: map['orderID'],
      customerID: map['customerID'],
      customernamesurname: map['customernamesurname'],
      totalprice: map['totalprice'],
      delivery: map['delivery'],
      items: List<OrderItem>.from(
        (map['items'] as List<dynamic>).map(
          (item) => OrderItem.fromMap(item),
        ),
      ),
    );
  }
}
