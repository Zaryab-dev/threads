import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:threads/Common/reusable_text.dart';
import 'package:threads/Controller/bottom_nav_controller.dart';
import 'package:threads/Controller/login_controller.dart';
import 'package:threads/Pages/Profile/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    getUserData();
  }
  BottomBarController controller = Get.put(BottomBarController());
  var userData = {};
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            controller.index = RxInt(0);
          });
        }, icon: const Icon(Icons.sports_basketball_outlined,size: 30,)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.photo_camera)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator(),):  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ListTile(title: Text(userData['name'],style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold),),
                      subtitle: Row(children: [
                        Text(userData['email'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp),),
                        SizedBox(width: 6,),
                        Chip(
                            elevation: 1,
                            shape: StadiumBorder(),
                            side: BorderSide.none,
                            backgroundColor: CupertinoColors.systemGrey6,
                            padding: EdgeInsets.zero,
                            label: Text('threads.net',style: TextStyle(fontSize: 11.sp),))
                      ],),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 38.0),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(userData['profilePhoto']),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userData['bio'],style: TextStyle(fontSize: 15.sp),),
                    SizedBox(height: 10.h,),
                    Row(children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(image: AssetImage("assets/zaryab.jpg"),fit: BoxFit.cover)
                        ),
                      ),
                      SizedBox(width: 8.w,),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: middleText('1 follower - ${userData['link']}',)),
                    ],),
                    SizedBox(height: 30.h,),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfile()));
                            },
                            child: reusableButton('Edit profile')),
                        SizedBox(width: 30.w,),
                        reusableButton('Share profile'),
                      ],),
                    SizedBox(height: 30.h,),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(children: [
                  TabBar(
                    controller: _tabController,
                    physics: AlwaysScrollableScrollPhysics(),
                    dragStartBehavior: DragStartBehavior.start,
                    indicatorColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 1,
                    unselectedLabelColor: CupertinoColors.systemGrey,
                    labelColor: Colors.black,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                    tabs: [
                      Tab(child: reusableText('Threads'),),
                      Tab(child: reusableText('Replies'),),
                    ],),
                  Expanded(child: TabBarView(
                      controller: _tabController,
                      children: [
                        Text('data'),
                        Text('data2'),
                      ]))
                ],),
              )
            ],
          ));
  }

  getUserData() async {
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
