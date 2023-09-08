

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {

  Rx<TextEditingController> nameController = TextEditingController().obs;
  String get name => nameController.value.text;
  final CollectionReference _reference = FirebaseFirestore.instance.collection('Users');
   Future<String> getUpdate(bio,link,nameController) async{
     try{
       await _reference.doc(FirebaseAuth.instance.currentUser!.uid).update({
         'name' : nameController,
         'bio' : bio,
         'link' : link,
       }).then((value) {
         Get.snackbar('Success', 'Updated');
       }).onError((error, stackTrace) {
         Get.snackbar('Failed', error.toString());
       });
     }catch(e) {
       print(e.toString());
     }
     return 'Error';
   }

   // Future<String> uploadBioAndLink() async{
   //   String uid = FirebaseAuth.instance.currentUser!.uid;
   //   var update = FirebaseFirestore.instance.collection("Users");
   //   try{
   //     update.add({
   //
   //     });
   //   }catch(e) {
   //     Get.snackbar('Failed', e.toString());
   //   }
   //   return 'Error';
   // }
}