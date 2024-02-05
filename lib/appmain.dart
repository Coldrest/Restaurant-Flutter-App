import 'package:flutter/material.dart';
import 'package:food_order_ui/admin/admin_login.dart';
import 'animation/FadeAnimation.dart';
import 'user/login.dart';
import 'user/singup.dart';

class UygulamaAnaSayfasi extends StatelessWidget {
  const UygulamaAnaSayfasi({super.key});
  final _width = double.infinity;
  final _minwidth = double.infinity;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
            child: Container(
          width: _width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    FadeAnimation(
                        1,
                        Text(
                          "Hoşgeldiniz",
                          style: ProjeStil.welcomestyle,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                      1.2,
                      Text(
                        "Bugün Ne Yemek İstersiniz ?",
                        textAlign: TextAlign.center,
                        style: ProjeStil.aciklamastyle,
                      ),
                    )
                  ],
                ),
                FadeAnimation(
                  1.4,
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image:
                          AssetImage('asset/images/${ImageItems().names}.png'),
                    )),
                  ),
                ),
                Column(
                  children: [
                    FadeAnimation(
                      1.6,
                      Container(
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
                          color: Colors.greenAccent,
                          elevation: 0,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GirisEkrani()));
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Giriş",
                            style: ProjeStil.metarialButtonStyle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      1.6,
                      Container(
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
                          color: const Color.fromARGB(255, 219, 59, 48),
                          elevation: 0,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KayitEkrani()));
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Kayıt Ol",
                            style: ProjeStil.metarialButtonStyle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      1.6,
                      Container(
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
                          color: Color.fromARGB(255, 103, 30, 162),
                          elevation: 0,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminGiris()));
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Admin",
                            style: ProjeStil.metarialButtonStyle1,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
        )),
      ),
    );
  }
}

class ProjeStil {
  static const welcomestyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 30);
  static const aciklamastyle = TextStyle(color: Colors.grey, fontSize: 15);
  static const metarialButtonStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static const metarialButtonStyle1 =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white);
}

class ImageItems {
  final String names = "waitergirls";
}
