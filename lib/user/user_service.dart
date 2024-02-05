import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_order_ui/user/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createUser(Users user) async {
    try {
      String uid =
          _auth.currentUser!.uid; // Ev sahibi kimliğini Firebase Auth'tan al
      DocumentReference userRef = _firestore
          .collection('Users')
          .doc(uid); // Belge referansını Ev sahibi kimliği ile oluştur
      await userRef.set(user.toMap()); // Belgeyi veritabanına kaydet
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateUser(Users user) async {
    try {
      String uid = _auth.currentUser!.uid;
      await _firestore.collection('Users').doc(uid).update(user.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteUser(String userID) async {
    try {
      await _firestore.collection('Users').doc(userID).delete();
    } catch (e) {
      print(e.toString());
    }
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

  Future<List<Users>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Users').get();

      List<Users> users = querySnapshot.docs
          .map((doc) => Users.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return users;
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }
}
