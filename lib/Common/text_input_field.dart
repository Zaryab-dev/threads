import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInputFields extends StatelessWidget {
  String hintText;
  TextInputAction action;
  TextInputType type;
  TextEditingController controller;
  TextInputFields({super.key,required this.controller, required this.hintText, required this.action, required this.type});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345.w,
        height: 45.h,
        child: TextFormField(
          controller: controller,
          textInputAction: action,
          keyboardType: type,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: CupertinoColors.systemGrey5,
            filled: true,
          ),
        ));
  }
}
