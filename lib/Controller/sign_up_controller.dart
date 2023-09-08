
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads/Models/user_model.dart';

class SignUpController extends GetxController{

  // var image = Rx<XFile?>(null);
  late Rx<File?> _image;
  File? get profilePhoto => _image.value;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> username = TextEditingController().obs;
  XFile? pickedImage;
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<void> getImage(ImageSource source) async{
    final ImagePicker imagePicker = ImagePicker();
    pickedImage = await imagePicker.pickImage(source: source);
    if(pickedImage != null) {
      Get.snackbar('Image Selected', "Success");
      _image = Rx<File?>(File(pickedImage!.path));
    }
  }

  Future<void> signUpUser() async {
    try{
    _isLoading.value = true;
      String downloadUrl = await uploadProfile(profilePhoto!.absolute);
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.value.text, password: password.value.text).then((value) {
        Get.snackbar('Success', 'User Created');
        _isLoading.value = false;
      }).onError((error, stackTrace) {
        Get.snackbar('Error', error.toString());
        _isLoading.value = false;
      });
      String uid = FirebaseAuth.instance.currentUser!.uid;
      var user = UserModel(
          dateTime: DateTime.now(),
          password: password.value.text,
          uid: uid,
          link: 'Attach link',
          bio: 'Enter bio',
          email: email.value.text, name: username.value.text, profilePhoto: downloadUrl);
      await FirebaseFirestore.instance.collection('Users').doc(uid).set(user.toJson());

    }catch(e) {
      print(e.toString());
      Get.snackbar('Failed', e.toString());
      _isLoading.value = false;
    }
  }
  Future<String> uploadProfile(File image) async{
    Reference storage = FirebaseStorage.instance.ref().child('profilePic').child(DateTime.now().toString());
    UploadTask uploadTask = storage.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

// class SignUpData extends GetxController {
//
//   late Rx<File> _image;
//   File? get profileImage => _image.value;
//
//   Future<void> getImage() async{
//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if(pickedImage != null) {
//       _image = Rx<File>(File(pickedImage!.path));
//     }else{
//       Get.snackbar('No Image Selected', 'Please select image to proceed');
//     }
//   }
//
//   Future<String> uploadImage() async {
//     Reference storage = await FirebaseStorage.instance.ref().child('profilePic').child(DateTime.timestamp().toString());
//     UploadTask uploadTask = storage.putFile(profileImage!.absolute);
//     TaskSnapshot taskSnapshot = await uploadTask;
//     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }
//
//   Future<void> signUpUser(BuildContext context) async {
//
//     if(username.value.text.isEmpty || email.value.text.isEmpty || password.value.text.isEmpty) {
//        Get.snackbar('Empty Credentials', 'Please fill all the sections');
//     }
//
//     try{
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.value.text, password: password.value.text).then((value) {
//         Get.snackbar('Success', 'User Registered');
//         Navigator.of(context).pushNamedAndRemoveUntil('/dashboard', (route) => false);
//       });
//     }on FirebaseAuthException catch(e) {
//             Get.snackbar('Error', e.toString());
//     }
//   }
//
//   Rx<TextEditingController> username = TextEditingController().obs;
//   Rx<TextEditingController> password = TextEditingController().obs;
//   Rx<TextEditingController> email = TextEditingController().obs;
//   Future<void> setData() async {
//     DatabaseReference reference = FirebaseDatabase.instance.ref('Users');
//     var uid = DateTime.fromMillisecondsSinceEpoch.toString();
//     int index = 0;
//     var user = UserModel(
//         dateTime: DateTime.now(),
//         password: password.value.text, email: email.value.text, uid: 'uid', name: username.value.text, profilePhoto: uploadImage().toString());
//     await reference.child('uid').set(user.toJson());
//   }
// }