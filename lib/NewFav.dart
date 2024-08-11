//تخبيص
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'controllers/FavoriteCategory.dart';
//
// class SavedSubjectPage extends StatelessWidget {
//   final FavoriteController favoriteController = Get.put(FavoriteController());
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
//               if (favoriteController.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (favoriteController.favoriteSubjects.isEmpty) {
//                 return Center(
//                     child: Text('No favorite subjects found',
//                         style: TextStyle(color: Colors.white)));
//               } else {
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount:
//                         favoriteController.favoriteSubjects.length,
//                         itemBuilder: (context, index) {
//                           var favoriteSubject =
//                           favoriteController.favoriteSubjects[index];
//                           var subject = favoriteSubject.subject;
//                           return Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 20, right: 30, left: 30),
//                             child: Container(
//                               width: 50,
//                               height: 150,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: Color(0xFFFEE2D7),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Stack(
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           subject.serviceName,
//                                           style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         SizedBox(height: 10),
//                                         ...subject.children
//                                             .map((child) => Text(
//                                             child.serviceName))
//                                             .toList(),
//                                       ],
//                                     ),
//                                     Align(
//                                       alignment: Alignment.topRight,
//                                       child: IconButton(
//                                         icon: Icon(
//                                           Icons.star,
//                                           color: Color(0xffFFB924),
//                                         ),
//                                         onPressed: () {
//                                           favoriteController.unfavoriteSubject(
//                                               favoriteSubject.id);
//                                         },
//                                       ),
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
//           ],
//         ),
//       ),
//     );
//   }
// }

/*import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'controllers/FavoriteCategory.dart';


class SavedSubjectPage extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());

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
              if (favoriteController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (favoriteController.favoriteSubjects.isEmpty) {
                return Center(child: Text('No favorite subjects found', style: TextStyle(color: Colors.white)));
              } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: favoriteController.favoriteSubjects.length,
                      itemBuilder: (context, index) {
                        var favoriteSubject = favoriteController.favoriteSubjects[index];
                        var subject = favoriteSubject.subject;
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                          child: Container(
                            width: 50,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFFEE2D7),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        subject.serviceName,
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      ...subject.children.map((child) => Text(child.serviceName)).toList(),
                                    ],
                                  ),

                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: Icon(Icons.star,color: Color(0xffFFB924),),
                                      onPressed: () {
                                        favoriteController.unfavoriteSubject(favoriteSubject.id);
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
              );}
            }),

          ],
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'controllers/FavoriteCategory.dart';
import 'controllers/ServiceController.dart';
import 'Advanceduser_session_view.dart';

class SavedSubjectPage extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final ServiceController serviceController = Get.put(ServiceController());

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
              if (favoriteController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (favoriteController.favoriteSubjects.isEmpty) {
                return Center(child: Text('No favorite subjects found', style: TextStyle(color: Colors.white)));
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() => ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: favoriteController.favoriteSubjects.length,
                        itemBuilder: (context, index) {
                          var favoriteSubject = favoriteController.favoriteSubjects[index];
                          var subject = favoriteSubject.subject;
                          bool hasChildren = subject.children != null && subject.children.isNotEmpty;

                          return Padding(
                            padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFFFEE2D7),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        hasChildren
                                            ? ExpansionTile(
                                          title: Text(
                                            subject.serviceName,
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          children: subject.children.map<Widget>((child) {
                                            return ListTile(
                                              title: Text(child.serviceName),
                                              onTap: () {
                                                int serviceId = child.id;
                                                serviceController.fetch_general_Sessions(serviceId);
                                                Get.to(() => Advanced_session_view(), arguments: serviceId);
                                              },
                                            );
                                          }).toList(),
                                        )
                                            : ListTile(
                                          title: Text(
                                            subject.serviceName,
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          onTap: () {
                                            int serviceId = subject.id;
                                            serviceController.fetch_general_Sessions(serviceId);
                                            Get.to(() => Advanced_session_view(), arguments: serviceId);
                                          },
                                        ),


                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        icon: Icon(Icons.star, color: Color(0xffFFB924)),
                                        onPressed: () {
                                          favoriteController.unfavoriteSubject(favoriteSubject.id);
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
              }
            }),
          ],
        ),
      ),
    );
  }
}

