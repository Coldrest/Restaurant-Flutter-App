import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_ui/product/product_model.dart';
import 'package:food_order_ui/product/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();
  final RxList<Products> products = RxList<Products>();
  String? searchQuery;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
  }

  Future<List<Products>> fetchAllProducts([String? query]) async {
    try {
      List<Products> allProducts = await _productService.getAllProducts();

      if (query != null && query.isNotEmpty) {
        allProducts = allProducts
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }

      products.assignAll(allProducts);
      print('Number of products fetched: ${products.length}');
      return allProducts;
    } catch (e) {
      print('Error fetching all products: $e');
      return [];
    }
  }

  void searchProducts(String query) {
    fetchAllProducts(query);
  }

  Future<void> deleteProduct(String? productId) async {
    try {
      print('Deleting product: $productId');

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('productID', isEqualTo: productId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String actualDocumentId = querySnapshot.docs.first.id;
        print('Actual document ID in Firestore: $actualDocumentId');

        await FirebaseFirestore.instance
            .collection('Products')
            .doc(actualDocumentId)
            .delete();

        products.removeWhere((product) => product.productID == productId);

        update();

        print('Product deleted successfully.');
      } else {
        print('Error: Document not found in Firestore.');
      }
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}
