// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:threads/Common/reusable_text.dart';
//
// class SecondHomeScreen extends StatelessWidget {
//   const SecondHomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(color: Colors.white),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Column(
//                   children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                     Container(
//                       height: 70.h,
//                       width: 70.h,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.deepOrange,
//                       ),
//                     ),
//                     SizedBox(width: 20,),
//                     Container(
//                       width: size.width* 0.68,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8.0),
//                               child: reusableText('Zaryab',),
//                             ),
//                             Container(
//                               child: Row(
//                                 children: [
//                                 middleText('9h'),
//                                 Icon(Icons.more_horiz)
//                               ],),
//                             )
//                           ],),
//                           const SizedBox(height: 10,),
//                           const Text('Today a reader, tomorrow a leader, Learn from yesterday, live for today, hope for tomorrow, live for today, hope for tomorrow, live for today, hope for tomorrow')
//                         ],
//                       ),
//                     ),
//                   ],),
//                     Row(
//                       children: [
//                         Container(
//                           height: size.height * 0.5,
//                           width: 3,
//                           color: Colors.grey,
//                         ),
//                       ],
//                     )
//                 ],),
//                 Column(children: [],),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
