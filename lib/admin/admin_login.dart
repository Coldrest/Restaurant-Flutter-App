import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order_ui/viewModel/login_viewModel.dart';
import 'admin_authentication.dart';
import '../animation/FadeAnimation.dart';

class AdminGiris extends StatefulWidget {
  AdminGiris({super.key});

  @override
  State<AdminGiris> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<AdminGiris> {
  final _widht = double.infinity;

  var _minwidth = double.infinity;

  AdminLoginPageViewModel viewModel = AdminLoginPageViewModel();

  AuthServiceAdmin authserviceadmin = AuthServiceAdmin();
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
                        "Admin Giriş",
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(children: [
                    FadeAnimation(
                        1.2,
                        makeInput(
                            label: "E-Mail Adresi",
                            controller: viewModel.emailController)),
                    FadeAnimation(
                        1.3,
                        makeInput(
                            label: "Şifre",
                            obscureText: true,
                            controller: viewModel.passwordController)),
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
                          )),
                      child: MaterialButton(
                        minWidth: _minwidth,
                        height: 60,
                        color: const Color.fromARGB(255, 103, 30, 162),
                        elevation: 0,
                        onPressed: () {
                          viewModel.signInAdmin(context);
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
                SizedBox(
                  height: 20,
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

Widget makeInput(
    {label, obscureText = false, required TextEditingController controller}) {
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
      TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white);
}
