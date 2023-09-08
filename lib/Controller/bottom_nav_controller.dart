

import 'dart:ffi';

import 'package:get/get.dart';

class BottomBarController extends GetxController{
  RxInt index = 0.obs;

  void counterIncrement(int value) {
    index.value = value;
  }
}