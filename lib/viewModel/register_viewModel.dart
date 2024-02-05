import 'package:flutter/material.dart';
import 'package:food_order_ui/admin/admin_authentication.dart';
import 'package:food_order_ui/bottom_navigation/bottom_navigation_view.dart';
import 'package:food_order_ui/user/user_authentication.dart';
import '../admin/admin_page.dart';

class AdminRegisterPageViewModel with ChangeNotifier {
  final AuthServiceAdmin _authenticationService = AuthServiceAdmin();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUpAdmin(BuildContext context) async {
    String? result = await _authenticationService.signUpAdmin(
      email: emailController.text,
      password: passwordController.text,
    );

    if (result != null) {
      // Kayıt başarılı, işlemler devam edebilir.
      // Örneğin, ana sayfaya yönlendirme yapabilirsiniz.
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminPage()));
    } else {
      // Kayıt başarısız, kullanıcıya bir hata mesajı gösterebilirsiniz.
    }
  }
}

class UserRegisterPageViewModel with ChangeNotifier {
  final AuthServiceUser _authenticationService = AuthServiceUser();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController namesurnameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Future<void> signUpUser(BuildContext context) async {
    String? result = await _authenticationService.signUpUser(
        email: emailController.text,
        password: passwordController.text,
        namesurname: namesurnameController.text,
        phoneNumber: phoneNumberController.text);

    if (result != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigationView()));
    } else {}
  }
}
