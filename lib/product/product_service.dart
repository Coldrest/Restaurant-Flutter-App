// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_order_ui/product/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future createProduct(Products product, File? productPhoto) async {
    try {
      CollectionReference productsCollection =
          _firestore.collection('Products');

      DocumentReference userRef = await productsCollection.add(product.toMap());
      String uid = userRef.id;

      if (productPhoto != null) {
        String photoURL = await uploadProductPhoto(uid, productPhoto);
        await userRef.update({'productPhoto': photoURL});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateProduct(Products user, File? newProductPhoto) async {
    try {
      String uid = _auth.currentUser!.uid;
      await _firestore.collection('Products').doc(uid).update(user.toMap());

      if (newProductPhoto != null) {
        String photoURL = await uploadProductPhoto(uid, newProductPhoto);
        await _firestore
            .collection('Products')
            .doc(uid)
            .update({'productPhoto': photoURL});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteProduct(String userID) async {
    try {
      await _firestore.collection('Products').doc(userID).delete();
      await deleteProductPhoto(userID);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Products>> getProducts() async {
    try {
      QuerySnapshot query =
          await _firestore.collectionGroup('Products').orderBy('name').get();
      List<Products> products = query.docs
          .map((doc) => Products.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return products;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<String> uploadProductPhoto(String userID, File photo) async {
    try {
      Reference ref = _storage
          .ref()
          .child('Products')
          .child(userID)
          .child('productPhoto.jpg');

      UploadTask task = ref.putFile(photo);
      await task.whenComplete(() {});

      String photoURL = await ref.getDownloadURL();
      return photoURL;
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to upload profile photo.');
    }
  }

  Future<void> deleteProductPhoto(String userID) async {
    try {
      Reference ref = _storage
          .ref()
          .child('Products')
          .child(userID)
          .child('productPhoto.jpg');
      await ref.delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Products>> getAllProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Products').get();

      List<Products> products = querySnapshot.docs
          .map((doc) => Products.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return products;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}
