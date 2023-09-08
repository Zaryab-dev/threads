import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:threads/Pages/Home_Pages/dash_board.dart';
import 'package:threads/Pages/Login/login_screen.dart';
import 'package:threads/Pages/Search/search_screen.dart';
import 'package:threads/Pages/Sign_up/sign_up.dart';

import 'Pages/splash_screen/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
        routes: {
          '/login' : (context) => LoginScreen(),
          '/signup' : (context) => SignUpScreen(),
          '/dashboard' : (context) => const DashBoardScreen(),
          '/search' : (context) => const SearchScreen(),
        },
      );
    });
  }
}

