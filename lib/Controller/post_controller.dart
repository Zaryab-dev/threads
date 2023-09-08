
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads/Controller/bottom_nav_controller.dart';
import 'package:threads/Models/post_model.dart';
import 'package:threads/Pages/Post/post_screen.dart';
import 'package:uuid/uuid.dart';

class PostController extends GetxController {
  late Rx<File?> _image;

  File? get image => _image.value;
  XFile? pickedImage;
  String postId = Uuid().v1();
  Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  BottomBarController controller = Get.put(BottomBarController());

  Future<void> getImage() async {
    final ImagePicker imagePicker = ImagePicker();
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 50,);
    if (pickedImage != null) {
      _image = Rx<File?>(File(pickedImage!.path));
    }
    else{
      Get.snackbar('No Image Selected', '');
    }
  }

  Future<void> uploadData(String name,profile,description, BuildContext context) async {
    try{
      _isLoading.value = true;
      var post = PostModel(
        name: name,
        description: description.toString(),
        postUrl: await uploadPostImage(),
        uid: FirebaseAuth.instance.currentUser!.uid,
        profilePhoto: profile,
        uploadDate: DateTime.now(),
        postId: postId,
        likes: [],
      );
      var uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance.collection("Posts").doc(postId).set(post.toJson()).then((value) {
        Get.snackbar('Success', 'Post uploaded successfully!');
      }).onError((error, stackTrace) {
        Get.snackbar('Failed', error.toString());
      });
      _isLoading.value = false;
    }catch(e) {
      Get.snackbar('Failed', e.toString());
      _isLoading.value = false;
    }
    _isLoading.value = false;
  }

  Future<String> uploadPostImage() async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('Posts')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(postId);
    UploadTask uploadTask = reference.putFile(image!.absolute);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
