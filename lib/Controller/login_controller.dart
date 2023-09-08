
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads/Pages/Home_Pages/dash_board.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Future<void> loginUser(BuildContext context) async{
    try{
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.value.text, password: password.value.text);
        Get.delete<LoginController>();
      if(credential.user != null) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashBoardScreen()));
        Get.delete();
      }
    }catch(e) {
      print(e.toString());
    }
  }
}
