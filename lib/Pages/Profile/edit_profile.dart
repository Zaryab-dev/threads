import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:threads/Common/reusable_text.dart';
import 'package:threads/Controller/edit_profile_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileController controller = Get.put(EditProfileController());
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final linkController = TextEditingController();
  var userData = {};
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Center(child: CircularProgressIndicator(),) : Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(CupertinoIcons.multiply)),
        title: reusableText('Edit Profile'),
        actions: [
          GestureDetector(
              onTap: () {
                controller.getUpdate(
                  bioController.text == '' ? userData['bio'] : bioController.text,
                  linkController.text == '' ? userData['link'] : linkController.text,
                  nameController.text == '' ? userData['name'] : nameController.text,
                );
                // controller.uploadBioAndLink(bioController.text, linkController.text);
                Navigator.of(context).pop();
              },
              child: _reusableText('Done')),
          SizedBox(width: 20.w,),

        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 0.86,
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey4),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      child: _reusableText('Name',),
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.lock),
                      title: TextFormField(
                        controller: nameController,
                        maxLength: 15,
                        decoration: InputDecoration(
                          hintText: userData['name'],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: CupertinoColors.systemGrey3),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: CupertinoColors.destructiveRed),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      trailing: Column(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundImage: NetworkImage(userData['profilePhoto'],
                          ),
                          )],
                      ),
                    ),
                    const Divider(endIndent: 80,indent: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _reusableText('Bio'),
                          TextFormField(
                            controller: bioController,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLength: 25,
                            decoration: InputDecoration(
                              hintText: userData['bio'],
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: CupertinoColors.systemGrey3),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: CupertinoColors.destructiveRed),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                          SizedBox(height: 12.h,),
                          Divider(),
                          SizedBox(height: 12.h,),
                          _reusableText('Link'),
                          TextFormField(
                            controller: linkController,
                            maxLength: 28,
                            maxLines: 1,

                            decoration: InputDecoration(
                              hintText: userData['link'],
                              hintStyle: TextStyle(overflow: TextOverflow.fade),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: CupertinoColors.systemGrey3),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: CupertinoColors.destructiveRed),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },),
    );
  }

  getData() async{
    setState(() {
      isLoading = true;
    });
   try{
     var snap = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();
     userData = snap.data()!;
   }catch(e) {
     Get.snackbar('Failed', e.toString());
   }
    setState(() {
      isLoading = false;
    });
  }
}

Widget _reusableText(String text) {
  return Text(text,maxLines: 1 , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp,overflow: TextOverflow.fade,letterSpacing: 1),);
}
Widget reusableTextFormField(String hintText,TextEditingController controller) {
  return TextFormField(
    decoration: InputDecoration(
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CupertinoColors.systemGrey3),
        borderRadius: BorderRadius.circular(50),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CupertinoColors.destructiveRed),
        borderRadius: BorderRadius.circular(50),
      ),
      contentPadding: EdgeInsets.all(10),
    ),
  );
}
