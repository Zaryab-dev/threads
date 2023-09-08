

import 'package:flutter/cupertino.dart';
import 'package:threads/Pages/Home_Pages/home_screen/home_screen.dart';
import 'package:threads/Pages/Post/post_screen.dart';
import 'package:threads/Pages/Profile/profile_screen.dart';

import '../Search/search_screen.dart';

List<Widget> bottomTabs = [
  HomeScreen(),
  SearchScreen(),
  PostScreen(),
  Center(child: Text('Notification'),),
  ProfileScreen()
];