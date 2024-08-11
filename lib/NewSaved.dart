/*import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'controllers/NewannouncementController.dart';

class SavedAnnouncementPage extends StatelessWidget {
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: announcementController.savedAnnouncements.length,
                      itemBuilder: (context, index) {
                        var savedAnnouncement = announcementController.savedAnnouncements[index];
                        var announcement = savedAnnouncement.announcement;
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                          child: Container(
                            width: 50,
                            height: 150,
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
                                        announcement.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(announcement.description),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Obx(() => IconButton(
                                      icon: SvgPicture.asset(announcement.isSaved.value ? 'assets/icon/unsave.svg' : 'assets/icon/save.svg'),
                                      onPressed: () {
                                        if (announcement.isSaved.value) {
                                          announcementController.unsaveAnnouncement(savedAnnouncement.id);
                                        } else {
                                          announcementController.saveAnnouncement(savedAnnouncement.announcementID);
                                        }
                                      },
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
*/


//saved زي العسل
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
//
// import 'controllers/NewannouncementController.dart';
//
// class SavedAnnouncementPage extends StatelessWidget {
//   final AnnouncementController announcementController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/background.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Stack(
//           children: [
//             Obx(() {
//               if (announcementController.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: announcementController.savedAnnouncements.length,
//                       itemBuilder: (context, index) {
//                         var savedAnnouncement =
//                         announcementController.savedAnnouncements[index];
//                         var announcement = savedAnnouncement.announcement;
//                         return Padding(
//                           padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
//                           child: Container(
//                             width: 50,
//                             height: 150,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(28),
//                               color: Color(0xFFDBC6FC),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Stack(
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         announcement.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(height: 10),
//                                       Text(announcement.description),
//                                       SizedBox(height: 10),
//
//
//                                     /*  ListTile(
//                                         title: Text(announcement.title),
//                                         subtitle: Text(announcement.description),
//                                         trailing: IconButton(
//                                           icon: SvgPicture.asset('assets/icon/unsave.svg'),
//                                           onPressed: () {
//                                             announcementController
//                                                 .unsaveAnnouncement(savedAnnouncement.id);
//                                           },
//                                         ),
//                                       ),*/
//                                     ],
//                                   ),
//                                   Align(
//                                     alignment: Alignment.bottomRight,
//                                     child:IconButton(
//                                       icon: SvgPicture.asset('assets/icon/save.svg'),
//                                       onPressed: () {
//                                         announcementController
//                                             .unsaveAnnouncement(savedAnnouncement.id);
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'controllers/NewannouncementController.dart';

class SavedAnnouncementPage extends StatelessWidget {
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
                      itemCount: announcementController.savedAnnouncements.length,
                      itemBuilder: (context, index) {
                        var savedAnnouncement = announcementController.savedAnnouncements[index];
                        var announcement = savedAnnouncement.announcement;
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                          child: Container(
                            width: 50,
                            height: 150,
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
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(announcement.description),
                                      SizedBox(height: 10),
                                      Text("Service ID: ${announcement.serviceID}"),
                                      Text("User ID: ${announcement.userID}"),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      icon: SvgPicture.asset('assets/icon/save.svg'),
                                      onPressed: () {
                                        announcementController.unsaveAnnouncement(savedAnnouncement.id);
                                      },
                                    ),
                                  ),
                                ],
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
}
