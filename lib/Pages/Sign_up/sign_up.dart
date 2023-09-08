import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads/Common/button.dart';
import 'package:threads/Common/reusable_text.dart';
import 'package:threads/Common/text_input_field.dart';
import 'package:threads/Controller/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  SignUpController controller = Get.put(SignUpController());

  // SignUpData signUpController = Get.put(SignUpData());
  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return Obx( () {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: reusableText('Sign Up'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40.h,),
                          Center(child: reusableText('Please Sign Up to threads')),
                          SizedBox(height: 20.h,),
                          Stack(
                                    children: [
                                      Center(
                                        child: controller.pickedImage == null ?  CircleAvatar(
                                          // backgroundImage: ,
                                          backgroundColor: Colors.deepOrange,
                                          radius: 50,child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: Colors.white, width: 2)
                                          ),
                                          margin: EdgeInsets.only(top: 60.h, left: 70),
                                          child: GestureDetector(
                                              onTap: () async {
                                                // signUpController.getImage();
                                                await controller.getImage(ImageSource.gallery);
                                              },
                                              child: const Icon(CupertinoIcons.add_circled,color: Colors.deepOrange,)),
                                        ),
                                        ) :  Container(
                                              height: 120.h,
                                              width: 120.w,
                                              decoration: BoxDecoration(
                                                color: Colors.deepOrange,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(image: FileImage(File(controller.profilePhoto!.path),),fit: BoxFit.cover)
                                              ),
                                        ),
                                      ),
                                    ],
                           ),
                          SizedBox(height: 20.h,),
                          middleText('Username'),
                          SizedBox(height: 5.h,),
                          TextInputFields(
                            controller: controller.username.value,
                            hintText: 'Enter Username',action: TextInputAction.next,type: TextInputType.emailAddress,),
                          SizedBox(height: 20.h,),
                          middleText('Email'),
                          SizedBox(height: 5.h,),
                          TextInputFields(
                            controller: controller.email.value,
                            hintText: 'Enter Email address',action: TextInputAction.next,type: TextInputType.emailAddress,),
                          SizedBox(height: 20.h,),
                          middleText('Password'),
                          SizedBox(height: 5.h,),
                          TextInputFields(
                            controller: controller.password.value,
                            hintText: 'Enter Password',action: TextInputAction.done,type: TextInputType.visiblePassword,),
                          SizedBox(height: 11.h,),
                          Text('by signing up with our app you have agree with our terms and conditions',
                            style: TextStyle(color: CupertinoColors.systemGrey2,fontSize: 12.sp),),
                          SizedBox(height: 60.h,),
                          controller.isLoading == true ? Center(child: CircularProgressIndicator()): ReusableButton(
                                  onPress: () {
                                    controller.signUpUser();
                                  },
                                  title: 'Sign Up', textColor: Colors.white, bgColor: Colors.deepOrange)
                        ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
