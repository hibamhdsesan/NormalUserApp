// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:tired/globals.dart';
//
// class AddAnnouncementPage extends StatelessWidget {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Announcement')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(labelText: 'Title'),
//             ),
//             TextField(
//               controller: descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 var response = await http.post(
//                   Uri.parse('$baseURL/api/announcement/add/'),
//                   headers: <String, String>{
//                     'Content-Type': 'application/json; charset=UTF-8',
//                   },
//                   body: jsonEncode(<String, dynamic>{
//                     'serviceID': 18,
//                     'title': titleController.text,
//                     'description': descriptionController.text,
//                     'userID': 30,
//                   }),
//                 );
//
//                 if (response.statusCode == 200) {
//                   Get.snackbar('Success', 'Announcement added successfully');
//                 } else {
//                   Get.snackbar('Error', 'Failed to add announcement');
//                 }
//               },
//               child: Text('Add Announcement'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
