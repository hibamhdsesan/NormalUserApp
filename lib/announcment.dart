// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'SavedAnnouncment.dart';
// import 'controllers/AnnouncmentController.dart';
//
// class AnnouncementPage extends StatelessWidget {
//   final AnnouncementController controller = Get.put(AnnouncementController());
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
//         child: Stack(
//           children: [
//             Obx(() {
//               if (controller.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               } else {
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: controller.announcements.length,
//                         itemBuilder: (context, index) {
//                           var announcement = controller.announcements[index];
//                           bool isSaved = controller.savedAnnouncements.contains(announcement.id);
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
//                             child: Container(
//                               width: 200,
//                               height: 300,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(28),
//                                 color: Color(0xFFDBC6FC),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Stack(
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           announcement.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                         ),
//                                         SizedBox(height: 10),
//                                         Text(announcement.description),
//                                         SizedBox(height: 10),
//                                         Text("Service ID: ${announcement.serviceID}"),
//                                         Text("User ID: ${announcement.userID}"),
//                                         Text("Created at: ${announcement.createdAt}"),
//                                         Text("Updated at: ${announcement.updatedAt}"),
//                                       ],
//                                     ),
//                                     Align(
//                                       alignment: Alignment.bottomRight,
//                                       child:Obx(() {
//                                         bool isSaved = announcement.isSaved.value;
//                                         return IconButton(
//                                           icon: SvgPicture.asset(isSaved ? 'assets/icon/save.svg' : 'assets/icon/unsave.svg'),
//                                           onPressed: () {
//                                             if (isSaved) {
//                                             //  controller.unSaveAnnouncement(announcement.id);
//                                               controller.unSaveAnnouncement(announcement.id);
//                                               print('hello');
//                                               print(announcement.id);
//                                               announcement.isSaved.value = false;
//                                             } else {
//                                               controller.saveAnnouncement(announcement.id);
//                                               announcement.isSaved.value = true;
//                                             }
//                                           },
//                                         );
//                                       }
//                                     ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             }),
//             Row(
//               children: [
//                 FloatingActionButton(
//                   onPressed: () => Get.to(SavedAnnouncementsPage()),
//                   child: Icon(Icons.save),
//                 ),
//
//                 Positioned(
//                   bottom: 20,
//                   right: 20,
//                   child: FloatingActionButton(
//                     onPressed: () => _showAddAnnouncementDialog(context),
//                     child: Icon(Icons.add),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showAddAnnouncementDialog(BuildContext context) {
//     final TextEditingController titleController = TextEditingController();
//     final TextEditingController descriptionController = TextEditingController();
//     final TextEditingController serviceIDController = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add Announcement'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//               ),
//               TextField(
//                 controller: descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//               ),
//               TextField(
//                 controller: serviceIDController,
//                 decoration: InputDecoration(labelText: 'Service ID'),
//                 keyboardType: TextInputType.number,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 controller.addAnnouncement(
//                   titleController.text,
//                   descriptionController.text,
//                   int.parse(serviceIDController.text),
//                 );
//                 Navigator.of(context).pop();
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:get/get.dart';
// //
// // import 'controllers/AnnouncmentController.dart';
// //
// // class AnnouncementPage extends StatelessWidget {
// //   final AnnouncementController controller = Get.put(AnnouncementController());
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
// //         child: Stack(
// //           children: [
// //             Obx(() {
// //               if (controller.isLoading.value) {
// //                 return Center(child: CircularProgressIndicator());
// //               } else {
// //                 return SingleChildScrollView(
// //                   child: Column(
// //                     children: [
// //                       ListView.builder(
// //                         shrinkWrap: true,
// //                         physics: NeverScrollableScrollPhysics(),
// //                         itemCount: controller.announcements.length,
// //                         itemBuilder: (context, index) {
// //                           var announcement = controller.announcements[index];
// //                           return Padding(
// //                             padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
// //                             child: Container(
// //                               width: 200,
// //                               height: 300,
// //                               decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(28),
// //                                 color: Color(0xFFDBC6FC),
// //                               ),
// //                               child: Padding(
// //                                 padding: const EdgeInsets.all(16.0),
// //                                 child: Stack(
// //                                   children: [
// //                                     Column(
// //                                       crossAxisAlignment: CrossAxisAlignment.start,
// //                                       children: [
// //                                         Text(
// //                                           announcement.title,
// //                                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                                         ),
// //                                         SizedBox(height: 10),
// //                                         Text(announcement.description),
// //                                         SizedBox(height: 10),
// //                                         Text("Service ID: ${announcement.serviceID}"),
// //                                         Text("User ID: ${announcement.userID}"),
// //                                         Text("Created at: ${announcement.createdAt}"),
// //                                         Text("Updated at: ${announcement.updatedAt}"),
// //                                       ],
// //                                     ),
// //                                     Align(
// //                                       alignment: Alignment.bottomRight,
// //                                       child: SvgPicture.asset('assets/icon/unsave.svg'),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               }
// //             }),
// //             Positioned(
// //               bottom: 20,
// //               right: 20,
// //               child: FloatingActionButton(
// //                 onPressed: () => _showAddAnnouncementDialog(context),
// //                 child: Icon(Icons.add),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void _showAddAnnouncementDialog(BuildContext context) {
// //     final TextEditingController titleController = TextEditingController();
// //     final TextEditingController descriptionController = TextEditingController();
// //     final TextEditingController serviceIDController = TextEditingController();
// //
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text('Add Announcement'),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               TextField(
// //                 controller: titleController,
// //                 decoration: InputDecoration(labelText: 'Title'),
// //               ),
// //               TextField(
// //                 controller: descriptionController,
// //                 decoration: InputDecoration(labelText: 'Description'),
// //               ),
// //               TextField(
// //                 controller: serviceIDController,
// //                 decoration: InputDecoration(labelText: 'Service ID'),
// //                 keyboardType: TextInputType.number,
// //               ),
// //             ],
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text('Cancel'),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 controller.addAnnouncement(
// //                   titleController.text,
// //                   descriptionController.text,
// //                   int.parse(serviceIDController.text),
// //                 );
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text('Add'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }
