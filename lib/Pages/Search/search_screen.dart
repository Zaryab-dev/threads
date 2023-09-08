import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:threads/Common/reusable_text.dart';
import 'package:threads/Pages/Search/search_widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: reusableText('Search Users'),centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.95,
                    height: size.height * 0.7,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index) {
                      return search(snapshot.data!.docs[index]['profilePhoto'], snapshot.data!.docs[index]['name']);
                    }),
                  )
                ],
              ),
            );
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}
