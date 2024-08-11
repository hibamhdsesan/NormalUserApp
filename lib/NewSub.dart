import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'Advanceduser_session_view.dart';
import 'NewFav.dart';
import 'Qr/AttendanceOfOneService.dart';
import 'Qr/MyAttendanceOfOneService.dart';
import 'controllers/FavoriteCategory.dart';
import 'controllers/ServiceController.dart';
import 'student_session_view.dart';

class SubjectPage extends StatefulWidget {
  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final ServiceController serviceController = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.star, color: Color(0xffFFB924)),
            onPressed: () {
              Get.to(() => SavedSubjectPage());
            },
          ),
        ],
        title: Text('Subjects', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: favoriteController.subjects.length,
                      itemBuilder: (context, index) {
                        var subject = favoriteController.subjects[index];
                        bool hasChildren = subject.children != null && subject.children.isNotEmpty;

                        return Padding(
                          padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: Color(0xFFFEE2D7),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (hasChildren)
                                        ExpansionTile(
                                          title: Text(
                                            subject.serviceName,
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          children: subject.children.map((child) {
                                            return ListTile(
                                              title: Text(child.serviceName),
                                              trailing: PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    child: Text('Attendance'),
                                                    value: 'attendance',
                                                  ),
                                                ],
                                                onSelected: (value) {
                                                  if (value == 'attendance') {
                                                    Get.to(() => MyServiceAttendance(), arguments: child.id);
                                                  }
                                                },
                                              ),
                                              onTap: () {
                                                int serviceId = child.id;
                                                serviceController.fetch_general_Sessions(serviceId);
                                                Get.to(() => student_session_view(), arguments: serviceId);
                                              },
                                            );
                                          }).toList(),
                                        )
                                      else
                                        ListTile(
                                          title: Text(
                                            subject.serviceName,
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          trailing: PopupMenuButton(
                                            icon: Icon(Icons.more_vert),
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: Text('Attendance'),
                                                value: 'attendance',
                                              ),
                                            ],
                                            onSelected: (value) {
                                              if (value == 'attendance') {
                                                Get.to(() => MyServiceAttendance(), arguments: subject.id);
                                              }
                                            },
                                          ),
                                          onTap: () {
                                            int serviceId = subject.id;
                                            serviceController.fetch_general_Sessions(serviceId);
                                            Get.to(() => student_session_view(), arguments: serviceId);
                                          },
                                        ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          icon: Icon(
                                            subject.isFavorite ? Icons.star : Icons.star_border_rounded,
                                            color: subject.isFavorite ? Color(0xffFFB924) : Colors.grey,
                                          ),
                                          onPressed: () {
                                            favoriteController.toggleFavoriteSubject(index);
                                          },
                                        ),
                                      ),
                                    ],
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
//sedra
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// import 'Advanceduser_session_view.dart';
// import 'NewFav.dart';
// import 'controllers/FavoriteCategory.dart';
// import 'controllers/ServiceController.dart';
//
// class SubjectPage extends StatefulWidget {
//   @override
//   State<SubjectPage> createState() => _SubjectPageState();
// }
//
// class _SubjectPageState extends State<SubjectPage> {
//   final FavoriteController favoriteController = Get.put(FavoriteController());
//   final ServiceController serviceController = Get.put(ServiceController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.star, color: Color(0xffFFB924)),
//             onPressed: () {
//               Get.to(() => SavedSubjectPage());
//             },
//           ),
//         ],
//         title: Text('Subjects', style: TextStyle(color: Colors.white)),
//        // backgroundColor: Color(0xFF292D3D),
//         elevation: 0,
//         backgroundColor:  Colors.transparent,
//       ),
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
//               }
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: favoriteController.subjects.length,
//                       itemBuilder: (context, index) {
//                         var subject = favoriteController.subjects[index];
//                         bool hasChildren = subject.children != null && subject.children.isNotEmpty;
//
//                         return Padding(
//                           padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
//                           child: Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(28),
//                               color: Color(0xFFFEE2D7),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Stack(
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       if (hasChildren)
//                                         ExpansionTile(
//                                           title: Text(
//                                             subject.serviceName,
//                                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                           ),
//                                           children: subject.children.map((child) {
//                                             return ListTile(
//                                               title: Text(child.serviceName),
//                                               onTap: () {
//                                                 int serviceId = child.id;
//                                                 serviceController.fetch_general_Sessions(serviceId);
//                                                 Get.to(() => Advanced_session_view(), arguments: serviceId);
//                                               },
//                                             );
//                                           }).toList(),
//                                         )
//                                       else
//                                         ListTile(
//                                           title: Text(
//                                             subject.serviceName,
//                                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                           ),
//                                           onTap: () {
//                                             int serviceId = subject.id;
//                                             serviceController.fetch_general_Sessions(serviceId);
//                                             Get.to(() => Advanced_session_view(), arguments: serviceId);
//                                           },
//                                         ),
//                                       Align(
//                                         alignment: Alignment.bottomRight,
//                                         child: IconButton(
//                                           icon: Icon(
//                                             subject.isFavorite ? Icons.star : Icons.star_border_rounded,
//                                             color: subject.isFavorite ? Color(0xffFFB924) : Colors.grey,
//                                           ),
//                                           onPressed: () {
//                                             favoriteController.toggleFavoriteSubject(index);
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
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

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// import 'NewFav.dart';
// import 'controllers/FavoriteCategory.dart';
// import 'controllers/ServiceController.dart';
//
//
// class SubjectPage extends StatefulWidget {
//   @override
//   State<SubjectPage> createState() => _SubjectPageState();
// }
//
// class _SubjectPageState extends State<SubjectPage> {
//   final FavoriteController favoriteController = Get.put(FavoriteController());
//   final ServiceController serviceController = Get.put(ServiceController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.star,color: Color(0xffFFB924),),
//             onPressed: () {
//               Get.to(() => SavedSubjectPage());
//             },
//           ),
//         ],
//         title: Text('Subjects', style: TextStyle(color: Colors.white)),
//         backgroundColor: Color(0xFF292D3D),
//       ),
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
//               }
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: favoriteController.subjects.length,
//                       itemBuilder: (context, index) {
//                         var subject = favoriteController.subjects[index];
//                         return Padding(
//                           padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
//                           child: Container(
//                             width: double.infinity,
//                             height: 200,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(28),
//                               color: Color(0xFFFEE2D7),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Stack(
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       /*Text(
//                                         subject.serviceName,
//                                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(height: 10),
//                                       ...subject.children.map((child) => Text(child.serviceName)).toList(),*/
//                                       Text(
//                                         subject.serviceName,
//                                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(height: 10),
//                                       ...subject.children.map((child) => InkWell(
//                                         onTap: () {
//
//                                           print('Pressed on ${child.serviceName}');
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(vertical: 4.0),
//                                           child: Text(
//                                             child.serviceName,
//                                             style: TextStyle(
//                                               color: Colors.grey,
//                                               decoration: TextDecoration.underline,
//                                             ),
//                                           ),
//                                         ),
//                                       )).toList(),
//                                     ],
//                                   ),
//                                   Align(
//                                     alignment: Alignment.topRight,
//                                     child: IconButton(
//                                       icon: Icon(
//                                         subject.isFavorite ? Icons.star : Icons.star_border_rounded,
//                                         color:  subject.isFavorite ? Color(0xffFFB924) : Colors.grey,
//                                       ),
//                                       onPressed: () {
//                                         favoriteController.toggleFavoriteSubject(index);
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
