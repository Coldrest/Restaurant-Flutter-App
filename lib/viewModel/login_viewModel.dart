import 'package:flutter/material.dart';
import 'package:food_order_ui/admin/admin_authentication.dart';
import 'package:food_order_ui/bottom_navigation/bottom_navigation_view.dart';
import 'package:food_order_ui/user/user_authentication.dart';
import '../admin/admin_page.dart';

class AdminLoginPageViewModel with ChangeNotifier {
  final AuthServiceAdmin _authenticationService = AuthServiceAdmin();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInAdmin(BuildContext context) async {
    String? result = await _authenticationService.signInAdmin(
      email: emailController.text,
      password: passwordController.text,
    );

    if (result != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminPage()));
    } else {}
  }
}

class UserLoginPageViewModel with ChangeNotifier {
  final AuthServiceUser _authenticationService = AuthServiceUser();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInUser(BuildContext context) async {
    String? result = await _authenticationService.signInUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (result != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigationView()));
    } else {}
  }
}
