import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget reusableText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.sp,
    ),
  );
}

Widget middleText(String text) {
  return Text(
    text,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14.sp,
        color: CupertinoColors.systemGrey,overflow: TextOverflow.ellipsis,),
  );
}

Widget forgetPassword(String text) {
  return Text(text,style: TextStyle(decoration: TextDecoration.underline,decorationColor: Colors.blue),);
}

Widget reusableButton(String title) {
  return Container(
    height: 37.h,
    width: 155.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: CupertinoColors.systemGrey2,width: 1)
    ),
    child: Center(child: Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),),),
  );
}

Widget session(String name) {
  return Text(name);
}