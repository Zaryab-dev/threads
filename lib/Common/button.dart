
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:threads/Common/reusable_text.dart';

class ReusableButton extends StatelessWidget {
  String title;
  Color textColor, bgColor;
  VoidCallback onPress;
  ReusableButton({super.key,required this.onPress, required this.title, required this.textColor, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 45.h,
        width: 325.w,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: CupertinoColors.systemGrey3,width: 1)
        ),
        child: Center(child: Text(title, style: TextStyle(color: textColor, fontSize: 16.sp, fontWeight: FontWeight.bold),),),
      ),
    );
  }
}
