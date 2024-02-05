import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_order_ui/product/product_model.dart';
import 'package:food_order_ui/product/product_service.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    home: AddProductPage(),
  ));
}

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  File? _selectedPhotos;

  Future<void> _getImage() async {
    final XFile? pickedImages =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImages != null) {
      File selectedPhotos = File(pickedImages.path);
      setState(() {
        _selectedPhotos = selectedPhotos;
      });
    }
  }

  Future<void> _createProduct() async {
    if (_selectedPhotos == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen en az bir fotoğraf seçiniz')),
      );
      return;
    }

    print('_selectedPhotos: $_selectedPhotos');
    String newProductID = DateTime.now().millisecondsSinceEpoch.toString();
    print('newProductID: $newProductID');

    Products products = Products(
      productID: newProductID,
      name: _productNameController.text,
      category: _categoryController.text,
      price: int.parse(_priceController.text),
      productPhoto: null,
    );
    print('products: $products');

    ProductService service = ProductService();

    try {
      await service.createProduct(products, _selectedPhotos);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('İlan oluşturma başarılı')),
      );
      _resetForm();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('İlan oluşturma başarısız')),
      );
      print(e.toString());
    }
  }

  void _resetForm() {
    _productNameController.clear();
    _categoryController.clear();
    _priceController.clear();
    setState(() {
      _selectedPhotos = null;
    });
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ürün Ekle',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.indigo],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildLabel('Ürün Adı:'),
                _buildTextField(_productNameController),
                SizedBox(height: 16),
                _buildLabel('Kategori:'),
                _buildTextField(_categoryController),
                SizedBox(height: 16),
                _buildLabel('Fiyat:'),
                _buildTextField(_priceController,
                    keyboardType: TextInputType.number),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: _getImage,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fotoğraf',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                      SizedBox(height: 8.0),
                      _selectedPhotos == null
                          ? Icon(Icons.image, size: 48.0, color: Colors.white)
                          : Image.file(
                              _selectedPhotos!,
                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.cover,
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 32.0),
                _buildGradientButton('Ürün Ekle', _createProduct),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildTextField(TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 16.0, 8.0),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: Colors.deepPurple),
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12.0),
            ),
            contentPadding: EdgeInsets.all(16.0),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.indigo],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
