import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_order_ui/admin/admin_model.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createAdmin(Admin admin) async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentReference userRef = _firestore.collection('Admins').doc(uid);
      await userRef.set(admin.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Admin?> getAdmin() async {
    try {
      String uid = _auth.currentUser!.uid;

      DocumentSnapshot doc =
          await _firestore.collection('Admins').doc(uid).get();

      if (doc.exists) {
        Admin admin = Admin.fromMap(doc.data() as Map<String, dynamic>);
        return admin;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
