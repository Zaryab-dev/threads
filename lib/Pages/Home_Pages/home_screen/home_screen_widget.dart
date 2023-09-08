import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:threads/Common/reusable_text.dart';

class HomeScreenWidgets extends StatefulWidget {
  const HomeScreenWidgets({super.key});

  @override
  State<HomeScreenWidgets> createState() => _HomeScreenWidgetsState();
}

class _HomeScreenWidgetsState extends State<HomeScreenWidgets> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        return Container(
          height: MediaQuery.of(context).size.height * 1,
          child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey)
                      ),
                      height: MediaQuery.of(context).size.height* 0.7,
                      width: MediaQuery.of(context).size.width* 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.645,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 50.h,
                                          width: 50.w,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.deepOrange,
                                            // radius: 17,
                                            backgroundImage: NetworkImage(snapshot.data!.docs[index]['profilePhoto']),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                                margin: EdgeInsets.only(top: 33,left: 33),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Icon(CupertinoIcons.add_circled,size: 20,),
                                                )
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.53,
                                          width: 2,
                                          color: CupertinoColors.systemGrey4,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.deepOrange,
                                                  borderRadius: BorderRadius.circular(50),
                                                  image: DecorationImage(image: NetworkImage(snapshot.data!.docs[index]['profilePhoto']), fit: BoxFit.cover)
                                              ),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.deepOrange,
                                                  borderRadius: BorderRadius.circular(50),
                                                  image: DecorationImage(image: NetworkImage(snapshot.data!.docs[index]['profilePhoto']), fit: BoxFit.cover)
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 15.w,),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 330,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            reusableText(snapshot.data!.docs[index]['name']),
                                            Row(
                                              children: [
                                                middleText(DateFormat.jm().format(snapshot.data!.docs[index]['uploadDate'].toDate())),
                                                SizedBox(width: 5.w,),
                                                Icon(Icons.more_horiz),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.7,
                                        child: Text(snapshot.data!.docs[index]['description'],
                                          overflow: TextOverflow.fade,
                                          maxLines: 4,
                                        ),
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                      Container(
                                        height: MediaQuery.of(context).size.height*0.45,
                                        width: MediaQuery.of(context).size.width*0.75,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(12),
                                          color: CupertinoColors.systemGrey6,
                                          // image: DecorationImage(image: NetworkImage(snapshot.data!.docs[index]['photoUrl']),fit: BoxFit.cover),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data!.docs[index]['photoUrl'],fit: BoxFit.cover,),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(CupertinoIcons.heart),
                                          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.chat_bubble,)),
                                          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.arrow_2_squarepath,)),
                                          IconButton(onPressed: () {}, icon: Icon(Icons.send)),
                                        ],
                                      ),
                                      Text('4 replies - 215 likes', style: TextStyle(color: Colors.grey,fontSize: 15.sp),),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 15.h,),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: CupertinoColors.systemGrey4,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      }
    );
  }
}
