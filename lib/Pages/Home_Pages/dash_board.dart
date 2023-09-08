import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads/Pages/Home_Pages/home_widgets.dart';

import '../../Controller/bottom_nav_controller.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  BottomBarController controller = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Obx( () {
        return Scaffold(
          body: bottomTabs[controller.index.value],
          bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                controller.counterIncrement(value);
              },
              currentIndex: controller.index.value,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled,), label: 'Home',activeIcon: Icon(Icons.home_filled,color: Colors.black,)),
            BottomNavigationBarItem(icon: Icon(Icons.search,), label: 'Search',activeIcon: Icon(Icons.search,color: Colors.black,)),
            BottomNavigationBarItem(icon: Icon(Icons.post_add_sharp,), label: 'Post',activeIcon: Icon(Icons.post_add_sharp,color: Colors.black,)),
            BottomNavigationBarItem(icon: Icon(Icons.heart_broken,), label: 'Notification',activeIcon: Icon(Icons.heart_broken,color: Colors.black,)),
            BottomNavigationBarItem(icon: Icon(Icons.person,), label: 'Profile',activeIcon: Icon(Icons.person,color: Colors.black,)),
          ]),
        );
      }
    );
  }
}
