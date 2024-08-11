// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// import 'controllers/AnnouncmentController.dart';
// import 'controllers/NewannouncementController.dart';
//
// class SavedAnnouncementsPage extends StatelessWidget {
//   final AnnouncementController controller = Get.find<AnnouncementController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/background.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Obx(() {
//           var savedAnnouncements = controller.announcements.where((announcement) => announcement.isSaved.value).toList();
//           if (savedAnnouncements.isEmpty) {
//             return Center(child: Text('No saved announcements'));
//           }
//           return ListView.builder(
//             itemCount: savedAnnouncements.length,
//             itemBuilder: (context, index) {
//               var announcement = savedAnnouncements[index];
//               return Padding(
//                 padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
//                 child: Container(
//                   width: 50,
//                   height: 110,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(28),
//                     color: Color(0xFFDBC6FC),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Stack(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 announcement.title,
//                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               SizedBox(height: 10),
//                               Text(announcement.description),
//                             ],
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: IconButton(
//                             icon: SvgPicture.asset('assets/icon/save.svg'),
//                             onPressed: () {
//                               _showUnsaveConfirmationDialog(context, announcement);
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }),
//       ),
//     );
//   }
//
//   void _showUnsaveConfirmationDialog(BuildContext context, var announcement) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Unsave'),
//           content: Text('Are you sure you want to unsave this announcement?'),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Unsave'),
//               onPressed: () {
//                 controller.unSaveAnnouncement(announcement.id);
//                 announcement.isSaved.value = false;
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:get/get.dart';
// // import 'controllers/AnnouncmentController.dart';
// // class SavedAnnouncementsPage extends StatelessWidget {
// //   final AnnouncementController controller = Get.find<AnnouncementController>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         decoration: BoxDecoration(
// //           image: DecorationImage(
// //             image: AssetImage('assets/images/background.png'),
// //             fit: BoxFit.cover,
// //           ),
// //         ),
// //         child: Obx(() {
// //           var savedAnnouncements = controller.announcements.where((announcement) => announcement.isSaved.value).toList();
// //           if (savedAnnouncements.isEmpty) {
// //             return Center(child: Text('No saved announcements'));
// //           }
// //           return ListView.builder(
// //             itemCount: savedAnnouncements.length,
// //             itemBuilder: (context, index) {
// //               var announcement = savedAnnouncements[index];
// //               return Padding(
// //                 padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
// //                 child: Container(
// //                   width: 50,
// //                   height: 110,
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(28),
// //                     color: Color(0xFFDBC6FC),
// //                   ),
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(10.0),
// //                     child: Stack(
// //                       children: [
// //                         Padding(
// //                           padding: const EdgeInsets.all(5.0),
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text(announcement.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
// //                               SizedBox(height: 10,),
// //                               Text(announcement.description),
// //                             ],
// //                           ),
// //                         ),
// //                         Align(
// //                           alignment: Alignment.bottomRight,
// //                           child: IconButton(
// //                             icon: SvgPicture.asset('assets/icon/save.svg'),
// //                             onPressed: () {
// //                               _showUnsaveConfirmationDialog(context, announcement);
// //                               /*controller.unSaveAnnouncement(announcement.id);
// //                               announcement.isSaved.value = false;*/
// //                             },
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         }),
// //       ),
// //     );
// //   }
// //   void _showUnsaveConfirmationDialog(BuildContext context, var announcement) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text('Confirm Unsave'),
// //           content: Text('Are you sure you want to unsave this announcement?'),
// //           actions: [
// //             TextButton(
// //               child: Text('Cancel'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //             TextButton(
// //               child: Text('Unsave'),
// //               onPressed: () {
// //                 controller.unSaveAnnouncement(announcement.id);
// //                 announcement.isSaved.value = false;
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }
// //
