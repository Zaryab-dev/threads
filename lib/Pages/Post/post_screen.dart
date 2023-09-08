import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:threads/Common/reusable_text.dart';
import 'package:threads/Controller/post_controller.dart';

class PostScreen extends StatefulWidget {
  PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  PostController controller = Get.put(PostController());
  final TextEditingController _descriptionController = TextEditingController();
  var userData = {};
  bool isLoading = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isLoading ? Center(child: CircularProgressIndicator(),) : Obx(() {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.multiply,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(onPressed: () {
                controller.uploadData(userData['name'],userData['profilePhoto'],_descriptionController.text.toString(), context);
                setState(() {

                });
              }, child: controller.isLoading == true ? const Center(child: CircularProgressIndicator()): Text('Post', style: TextStyle(color: CupertinoColors.activeBlue,fontWeight: FontWeight.bold, fontSize: 16.sp),))
            ],
            title: reusableText(
              'New Thread',
            ),
            centerTitle: false,
          ),
          body:  Row(
                children: [
                  Container(
                    width: size.width * 0.2,
                    child:  Column(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.deepOrange,
                          backgroundImage: NetworkImage(userData['profilePhoto']),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: Container(
                            width: 3,
                            height: controller.pickedImage == null ? size.height * 0.085: size.height * 0.4,
                            color: CupertinoColors.systemGrey3,
                          ),
                        ),
                        Container(
                          height: 25.h,
                          width: 25.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.deepOrange,
                            image: DecorationImage(image: NetworkImage(userData['profilePhoto']),fit: BoxFit.cover)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 17.0),
                      child:  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reusableText(userData['name']),
                              SizedBox(height: size.height*0.005,),
                              TextFormField(
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                  hintText: 'Start a thread',
                                  filled: true,
                                  fillColor: CupertinoColors.systemGrey6,
                                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)
                                  )
                                ),
                              ),
                              SizedBox(height: size.height*0.02,),
                              controller.pickedImage == null ? IconButton(onPressed: () async{
                                await controller.getImage();
                                setState(() {

                                });
                              }, icon: const Icon(Icons.attach_file)) :  Container(
                                    height: size.height * 0.37,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: CupertinoColors.systemGrey4,width: 1,),
                                      image: DecorationImage(image: FileImage(File(controller.image!.path)),fit: BoxFit.cover),
                                    ),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          controller.pickedImage = null;
                                          setState(() {

                                          });
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.7),
                                              borderRadius: BorderRadius.circular(50)
                                            ),
                                            child: const Icon(CupertinoIcons.multiply,size: 26,color: Colors.white,)),
                                      ),
                                    )),
                              ),
                              SizedBox(height: size.height*0.02,),
                              middleText('Add to thread'),
                            ],
                      ),
                    ),
                  ),
                ],
              )
        );
      }
    );
  }
  getData() async{
    setState(() {
      isLoading = true;
    });
    try{
      var snap = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      userData = snap.data()!;
      setState(() {

      });
    }catch(e) {
      Get.snackbar('Failed', e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }
}
