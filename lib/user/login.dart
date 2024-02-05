import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order_ui/bottom_navigation/bottom_navigation_viewmodel.dart';
import 'package:food_order_ui/user/user_authentication.dart';
import '../animation/FadeAnimation.dart';
import '../viewModel/login_viewModel.dart';

class GirisEkrani extends StatefulWidget {
  GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  final _widht = double.infinity;
  var _minwidth = double.infinity;

  UserLoginPageViewModel viewModel = UserLoginPageViewModel();
  AuthServiceUser authserviceadmin = AuthServiceUser();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: _widht,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    FadeAnimation(
                      1,
                      Text(
                        "Giriş",
                        style: GirisStil.girisStyle,
                      ),
                    ),
                    FadeAnimation(
                      1.2,
                      Text(
                        "Hesabınıza Giriş Yapın",
                        style: GirisStil.aciklamaStyle,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(children: [
                    FadeAnimation(
                      1.2,
                      makeInput(
                        label: "Email",
                        controller: viewModel.emailController,
                      ),
                    ),
                    FadeAnimation(
                      1.3,
                      makeInput(
                        label: "Şifre",
                        obscureText: _isObscure,
                        controller: viewModel.passwordController,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                FadeAnimation(
                  1.4,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: MaterialButton(
                        minWidth: _minwidth,
                        height: 60,
                        color: Colors.greenAccent,
                        elevation: 0,
                        onPressed: () {
                          BottomNavigationModel().navigateToHomePage();
                          viewModel.signInUser(context);
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Giriş Yap",
                          style: GirisStil.metarialButtonStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget makeInput({
  label,
  obscureText = false,
  required TextEditingController controller,
  Widget? suffixIcon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GirisStil.inputStyle,
      ),
      TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType:
            label == "Email" ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
      SizedBox(
        height: 30,
      ),
    ],
  );
}

class GirisStil {
  static const rowStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 15);
  static const girisStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 30);
  static const aciklamaStyle = TextStyle(color: Colors.grey, fontSize: 15);
  static const inputStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87);
  static const metarialButtonStyle =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 18);
}
