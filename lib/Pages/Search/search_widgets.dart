
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget search(String url, title,) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 6,horizontal: 1),
    elevation: 5,
    shape: StadiumBorder(),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.deepOrange,
        backgroundImage: NetworkImage(url),
      ),
      title: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),),
      trailing: Container(
        height: 30,
        width: 80,
        decoration: BoxDecoration(
          color: CupertinoColors.systemBlue,
          borderRadius: BorderRadius.circular(50)
        ),
        child: Center(child: Text("Follow",style: TextStyle(fontSize: 12.sp,color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
    ),
  );
}