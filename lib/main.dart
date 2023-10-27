import 'dart:io';

import 'package:emart/consts/consts.dart';
import 'package:emart/views/auth_screen/login_screen.dart';
import 'package:emart/views/auth_screen/signup_screen.dart';
import 'package:emart/views/home_screen/home.dart';
import 'package:emart/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyDYvP2ojKt6UfzSv1Zl89RrbpyPDtf8JUg",
            appId: "1:648029453661:android:2aabeb1b266df1055afcb4",
            messagingSenderId: "648029453661",
            projectId: "e-mart-6396e",
            storageBucket: "e-mart-6396e.appspot.com",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: darkFontGrey),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          fontFamily: regular,
        ),
        home: SplashScreen(),
        routes: {
          'login': (context) => const LoginScreen(),
          'signup': (context) => const SignUpScreen(),
          'home': (context) => const Home(),
        });
  }
}
