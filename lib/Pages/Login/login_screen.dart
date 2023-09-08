import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:threads/Common/button.dart';
import 'package:threads/Common/reusable_text.dart';
import 'package:threads/Common/text_input_field.dart';
import 'package:threads/Controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginController controller = Get.put(LoginController());

  @override
  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: reusableText('Login'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h,),
                  Center(child: reusableText('Welcome to threads')),
                  SizedBox(height: 60.h,),
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
                  forgetPassword('forget password?'),
                  SizedBox(height: 60.h,),
                  ReusableButton(
                      onPress: () {
                        controller.loginUser(context);
                        // controller.password.value.clear();
                        // controller.email.value.clear();
                      },
                      title: 'Login', textColor: Colors.white, bgColor: Colors.deepOrange),
                  SizedBox(height: 20.h,),
                  ReusableButton(
                      onPress: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      title: 'Sign Up', textColor: Colors.deepOrange, bgColor: Colors.white)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
