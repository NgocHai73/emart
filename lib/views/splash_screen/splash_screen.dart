import 'dart:ffi';

import 'package:emart/consts/consts.dart';
import 'package:emart/widgets_common/appLogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.pushReplacementNamed(context, 'login');

      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Navigator.pushReplacementNamed(context, 'login');
        } else {
          Navigator.pushReplacementNamed(context, 'home');
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: redColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(icSplashBg, width: 300),
              ),
              20.heightBox,
              appLogoWidget(),
              10.heightBox,
              appname.text.fontFamily(bold).size(22).make(),
              5.heightBox,
              appversion.text.white.make(),
              const Spacer(),
              credits.text.white.fontFamily(semibold).make(),
              30.heightBox,
            ],
          ),
        ));
  }
}
