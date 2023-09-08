import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String name, profilePhoto, email, password, uid,link, bio;
  DateTime dateTime;

  UserModel(
      {
        required this.bio,
        required this.link,
        required this.dateTime,
      required this.password,
      required this.email,
        required this.uid,
      required this.name,
      required this.profilePhoto});

  Map<String, dynamic> toJson() => {
        'name': name,
        'profilePhoto': profilePhoto,
        'dateTime': dateTime,
        'password': password,
        'email': email,
        'uid': uid,
        'link': link,
        'bio': bio,
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        dateTime: snapshot['dateTime'],
        password: snapshot['password'],
        email: snapshot['email'],
        name: snapshot['name'],
        uid: snapshot['uid'],
        profilePhoto: snapshot['profilePhoto'],
        link: snapshot['link'],
        bio: snapshot['bio'],
    );
  }
}
