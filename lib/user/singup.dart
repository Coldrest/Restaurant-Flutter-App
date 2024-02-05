import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../animation/FadeAnimation.dart';
import '../viewModel/register_viewModel.dart';

class KayitEkrani extends StatefulWidget {
  KayitEkrani({Key? key}) : super(key: key);

  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  UserRegisterPageViewModel viewModel = UserRegisterPageViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    FadeAnimation(
                      1,
                      Text(
                        "Kayıt",
                        style: GirisStil.girisStyle,
                      ),
                    ),
                    FadeAnimation(
                      1.2,
                      Text(
                        "Hesap Oluşturun",
                        style: GirisStil.aciklamaStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  FadeAnimation(
                      1.2,
                      makeInput(
                          label: "Ad Soyad",
                          controller: viewModel.namesurnameController)),
                  FadeAnimation(
                      1.3,
                      makeInput(
                          label: "Email",
                          controller: viewModel.emailController)),
                  FadeAnimation(
                      1.4,
                      makeInput(
                          label: "Telefon Numarası",
                          controller: viewModel.phoneNumberController)),
                  FadeAnimation(
                    1.5,
                    makeInput(
                        label: "Şifre",
                        obscureText: true,
                        controller: viewModel.passwordController),
                  ),
                ],
              ),
              Column(
                children: [
                  FadeAnimation(
                    1.7,
                    Container(
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
                        minWidth: double.infinity,
                        height: 60,
                        color: const Color.fromARGB(255, 219, 59, 48),
                        elevation: 0,
                        onPressed: () {
                          viewModel.signUpUser(context);
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Kayıt Ol",
                          style: GirisStil.metarialButtonStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
        keyboardType: label == "Email"
            ? TextInputType.emailAddress
            : label == "Telefon Numarası"
                ? TextInputType.phone
                : TextInputType.text,
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
  static const rowStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 18);
  static const girisStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 30);
  static const aciklamaStyle = TextStyle(color: Colors.grey, fontSize: 15);
  static const inputStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87);
  static const metarialButtonStyle =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 18);
}
