import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../product/product_model.dart';

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  final ProductController productController = Get.put(ProductController());
  final CartController cartcontroller = Get.put(CartController());

  int selectedCategoryIndex = 0;

  void updateCategoryIndex(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  List<Products> filterProductsByCategory(
      List<Products> allProducts, String category) {
    return allProducts
        .where((product) => product.category == category)
        .toList();
  }

  Widget buildCategoryCard(
      String categoryName, String imagePath, Function()? onPressed) {
    return Card(
      elevation: selectedCategoryIndex == categoryNames.indexOf(categoryName)
          ? 8.0
          : 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: selectedCategoryIndex == categoryNames.indexOf(categoryName)
          ? Colors.deepPurple
          : null,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 55,
                width: 90,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 4),
              Text(
                categoryName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selectedCategoryIndex ==
                          categoryNames.indexOf(categoryName)
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: selectedCategoryIndex ==
                          categoryNames.indexOf(categoryName)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> categoryNames = [
    'Tüm Ürünler',
    'Hamburgerler',
    'Pizzalar',
    'İçecekler'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Hoşgeldiniz!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('asset/images/logo.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            categorySection(),
            promotions(),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Ürünler",
                style: TextStyle(fontSize: 20, color: Colors.deepPurple),
              ),
            ),
            FutureBuilder<List<Products>>(
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
                    List<Products> allProducts = snapshot.data ?? [];
                    List<Products> filteredProducts;

                    switch (selectedCategoryIndex) {
                      case 1:
                        filteredProducts =
                            filterProductsByCategory(allProducts, 'Hamburger');
                        break;
                      case 2:
                        filteredProducts =
                            filterProductsByCategory(allProducts, 'Pizza');
                        break;
                      case 3:
                        filteredProducts =
                            filterProductsByCategory(allProducts, 'İçecek');
                        break;
                      default:
                        filteredProducts = allProducts;
                        break;
                    }

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      padding: EdgeInsets.all(16),
                      itemCount: filteredProducts.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        Products product = filteredProducts[index];
                        return Card(
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
                                      Colors.black.withOpacity(0.0),
                                      BlendMode.srcOver,
                                    ),
                                    child: Image.network(
                                      product.productPhoto!,
                                      width: double.infinity,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              Container(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 89),
                                    Text(
                                      '${product.name}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '${product.price} ₺',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.indigo,
                                  ),
                                  onPressed: () {
                                    cartcontroller.addProduct(product);
                                  },
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
          ],
        ),
      ),
    );
  }

  Widget categorySection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      constraints: BoxConstraints(maxHeight: 120),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          buildCategoryCard('Tüm Ürünler', 'asset/images/logo.png', () {
            updateCategoryIndex(0);
          }),
          SizedBox(width: 10),
          buildCategoryCard('Hamburgerler', 'asset/images/3.png', () {
            updateCategoryIndex(1);
          }),
          SizedBox(width: 10),
          buildCategoryCard('Pizzalar', 'asset/images/2.png', () {
            updateCategoryIndex(2);
          }),
          SizedBox(width: 10),
          buildCategoryCard('İçecekler', 'asset/images/1.png', () {
            updateCategoryIndex(3);
          }),
        ],
      ),
    );
  }

  Widget promotions() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            height: 160,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.indigo],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Ağzınıza Layık',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Bir Sepet Patates',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'İster Misiniz?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Image.asset(
                  'asset/images/fries.png',
                  height: 110,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
