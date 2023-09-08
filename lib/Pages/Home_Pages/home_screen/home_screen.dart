import 'package:flutter/material.dart';
import 'package:threads/Pages/Home_Pages/home_screen/home_screen_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return HomeScreenWidgets();
              }),
        ),
      ),
    );
  }
}
