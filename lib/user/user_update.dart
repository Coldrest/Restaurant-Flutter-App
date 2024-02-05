import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class UpdateUserInfoPage extends StatefulWidget {
  @override
  _UpdateUserInfoPageState createState() => _UpdateUserInfoPageState();
}

class _UpdateUserInfoPageState extends State<UpdateUserInfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserInformation();
  }

  Future<void> fetchCurrentUserInformation() async {
    try {
      var currentUser = _auth.currentUser;
      var userDocument =
          await _firestore.collection('Users').doc(currentUser!.uid).get();

      Users user = Users.fromMap(userDocument.data() as Map<String, dynamic>);

      setState(() {
        nameController.text = user.namesurname;
        emailController.text = user.email;
        phoneController.text = user.phoneNumber;
        passwordController.text = user.password;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateUser() async {
    var currentUser = _auth.currentUser;

    if (currentUser != null) {
      Users updatedUser = Users(
        userID: currentUser.uid,
        namesurname: nameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        password: passwordController.text,
      );

      try {
        await _firestore
            .collection('Users')
            .doc(currentUser.uid)
            .update(updatedUser.toMap());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bilgileriniz Güncellendi!'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bilgilerinizi Güncelleyin',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.indigo],
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildLabel('İsim-Soyisim:'),
                  _buildTextField(nameController),
                  SizedBox(height: 16),
                  _buildLabel('E-Mail:'),
                  _buildTextField(emailController),
                  SizedBox(height: 16),
                  _buildLabel('Telefon Numarası:'),
                  _buildTextField(phoneController),
                  SizedBox(height: 16),
                  _buildLabel('Şifre:'),
                  _buildTextField(passwordController, isPassword: false),
                  SizedBox(height: 32),
                  _buildGradientButton('Güncelle', updateUser),
                ],
              ),
            ),
          ],
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
      {bool isPassword = false}) {
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
          obscureText: isPassword,
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
            offset: Offset(0, 8),
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
