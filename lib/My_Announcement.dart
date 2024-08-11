import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'controllers/NewannouncementController.dart';
import 'model/Newannouncement_model.dart';

class MyAnnouncementPage extends StatelessWidget {
  final AnnouncementController announcementController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Obx(() {
              if (announcementController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: announcementController.myAnnouncements.length,
                      itemBuilder: (context, index) {
                        var announcement = announcementController.myAnnouncements[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                          child: IntrinsicHeight(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: Color(0xFFDBC6FC),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          announcement.title,
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Flexible(
                                          child: Text(
                                            announcement.description,
                                            style: TextStyle(fontSize: 16),
                                            overflow: TextOverflow.visible,
                                            maxLines: null,
                                          ),
                                        ),
                                        Text("Service ID: ${announcement.serviceID}"),
                                        Text("User ID: ${announcement.userID}"),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap:() {
                                          _showEditDialog(context, announcement);
                                          },
                                          child: SvgPicture.asset('assets/icon/edit.svg')
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // void _showEditDialog(BuildContext context, Announcement announcement) {
  //   final titleController = TextEditingController(text: announcement.title);
  //   final descriptionController = TextEditingController(text: announcement.description);
  //   final serviceIDController = TextEditingController(text: announcement.serviceID.toString());
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Edit Announcement'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: titleController,
  //               decoration: InputDecoration(labelText: 'Title'),
  //             ),
  //             TextField(
  //               controller: descriptionController,
  //               decoration: InputDecoration(labelText: 'Description'),
  //             ),
  //             TextField(
  //               controller: serviceIDController,
  //               decoration: InputDecoration(labelText: 'Service ID'),
  //               keyboardType: TextInputType.number,
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               announcementController.updateAnnouncement(
  //                 announcement.id,
  //                 titleController.text,
  //                 descriptionController.text,
  //                 int.parse(serviceIDController.text),
  //               );
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Save'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  void _showEditDialog(BuildContext context, Announcement announcement) {
    final titleController = TextEditingController(text: announcement.title);
    final descriptionController = TextEditingController(text: announcement.description);
    final serviceIDController = TextEditingController(text: announcement.serviceID.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Announcement'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: serviceIDController,
                decoration: InputDecoration(labelText: 'Service ID'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty || descriptionController.text.isNotEmpty) {
                  announcementController.updateAnnouncement(
                    announcement.id,
                    titleController.text.isNotEmpty ? titleController.text : null,
                    descriptionController.text.isNotEmpty ? descriptionController.text : null,
                    serviceIDController.text.isNotEmpty ? int.parse(serviceIDController.text) : null,
                  );
                  Navigator.of(context).pop();
                } else {
                  // يمكن عرض رسالة خطأ هنا
                  print('you have to fill one at least');
                }
              },
              child: Text('Update'),
            )

          ],
        );
      },
    );
  }
}
