import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../consts/firebase_const.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(Get.context!, msg: e.toString());
    }
    return userCredential;
  }

  //signup

  Future<UserCredential?> singupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(Get.context!, msg: e.toString());
    }
    return userCredential;
  }

  //stoing data
  storeUserData(
      {required String email,
      required String password,
      required String name}) async {
    DocumentReference store =
        await firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'email': email,
      'password': password,
      'imageURL': '',
      'id': currentUser!.uid,
      'cart_count': 00,
      'wishlist_count': 00,
      'order_count': 00,
    });
  }

  singoutMethod(Future? offAll, {context, email, password}) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(Get.context!, msg: e.toString());
    }
  }
}
