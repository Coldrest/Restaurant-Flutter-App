class Products {
  String? productID;
  String name;
  String category;
  int price;
  String? productPhoto;

  Products(
      {this.productID,
      required this.name,
      required this.category,
      required this.price,
      this.productPhoto});

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'name': name,
      'category': category,
      'price': price,
      'productPhoto': productPhoto
    };
  }

  Products.fromMap(Map<String, dynamic> map)
      : productID = map['productID'],
        name = map['name'],
        category = map['category'],
        price = map['price'],
        productPhoto = map['productPhoto'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Products &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          productID == other.productID &&
          price == other.price &&
          productPhoto == other.productPhoto;

  @override
  int get hashCode => name.hashCode;
}
