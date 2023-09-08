import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:threads/Pages/Home_Pages/dash_board.dart';
import 'package:threads/Pages/Sign_up/sign_up.dart';
import 'package:threads/Pages/splash_screen/splash_services.dart';

import '../Login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      if(FirebaseAuth.instance.currentUser != null) {
        Navigator.of(context).pushNamedAndRemoveUntil('/dashboard', (route) => false);
      }else{
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: Center(child: Image(
        width: 275,
        height: 300,
        image: AssetImage('assets/threads.png'),fit: BoxFit.fill,),),
    );
  }
}
