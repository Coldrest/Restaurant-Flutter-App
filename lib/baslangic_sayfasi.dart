import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'appmain.dart';

class SplashEkrani extends StatefulWidget {
  const SplashEkrani({super.key});

  @override
  State<SplashEkrani> createState() => _SplashEkraniState();
}

class _SplashEkraniState extends State<SplashEkrani>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => UygulamaAnaSayfasi()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 244, 54, 98)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 180,
              width: 180,
              image: AssetImage('asset/images/logo.png'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
