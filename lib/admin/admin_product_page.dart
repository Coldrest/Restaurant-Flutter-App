import 'package:flutter/material.dart';
import 'package:food_order_ui/controllers/product_controller.dart';
import 'package:food_order_ui/product/product_model.dart';
import 'package:get/get.dart';

class ProductProfilePage extends StatefulWidget {
  @override
  _ProductProfilePageState createState() => _ProductProfilePageState();
}

class _ProductProfilePageState extends State<ProductProfilePage> {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ürünler',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.indigo],
          ),
        ),
        child: FutureBuilder<List<Products>>(
          future: productController.fetchAllProducts(),
          builder: (context, snapshot) {
            try {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else {
                List<Products> products = snapshot.data ?? [];
                return ListView(
                  padding: EdgeInsets.all(16),
                  children: products
                      .map(
                        (product) => Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Stack(
                            children: [
                              if (product.productPhoto != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.7),
                                      BlendMode.srcOver,
                                    ),
                                    child: Image.network(
                                      product.productPhoto!,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              Container(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 35),
                                    Text(
                                      '${product.name}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${product.category}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${product.price}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 75,
                                right: 0,
                                child: Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        if (product.productID != null) {
                                          productController
                                              .deleteProduct(product.productID);
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            refreshUI();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text('Ürün silindi'),
                                                duration: Duration(seconds: 1),
                                              ),
                                            );
                                          });
                                        } else {
                                          print('Error: User ID is null.');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              }
            } catch (e) {
              print('Error in FutureBuilder: $e');
              return Center(
                child: Text(
                  'An unexpected error occurred.',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void refreshUI() {
    setState(() {});
  }
}
