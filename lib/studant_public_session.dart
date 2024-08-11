import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart'; // استيراد SharedPreferences

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'addsession.dart';
import 'controllers/ServiceController.dart';
import 'edit_session.dart';
import 'model/public_session.dart';
import 'my_activity.dart';
import 'my_exam.dart'; // استيراد PublicSession

class studant_public_session_view extends StatelessWidget {
  final ServiceController serviceController = Get.put(ServiceController());
  final List<String> colors = [
    '#FF8B3A',
    '#BFB9FD',
    '#77B8A1',
  ];

  @override
  Widget build(BuildContext context) {
    final int serviceId = Get.arguments;
    serviceController.fetchPublicSessions(serviceId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sessions'),
        backgroundColor: Color(0xFF292D3D),
        actions: [
          IconButton(
            icon: Icon(Icons.event, color: Colors.white),
            onPressed: () {
              Get.to(() => MyActivitiesPage());
            },
            tooltip: 'Show My Activities',
          ),
          IconButton(
            icon: Icon(Icons.school, color: Colors.white),
            onPressed: () {
              Get.to(() => MyExamsPage());
            },
            tooltip: 'Show My Exams',
          ),
        ],
      ),
      body: Obx(() {
        if (serviceController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (serviceController.sessions.isEmpty) {
          return Stack(
            children: [
              Center(child: Text('No Sessions Found')),
            ],
          );
        } else {
          return Stack(
            children: [
              ListView.builder(
                itemCount: serviceController.sessions.length,
                itemBuilder: (context, index) {
                  var publicSession = serviceController.sessions[index];
                  Color containerColor =
                  Color(int.parse(colors[index % 3].substring(1, 7), radix: 16) + 0xFF000000);
                  Color intersectColor = containerColor.withOpacity(0.7);
                  Color lighterColor = intersectColor.withOpacity(0.8);

                  return Padding(
                    padding: const EdgeInsets.only(left: 35, top: 15),
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Container(
                          width: 330,
                          height: 215,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: lighterColor,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: SvgPicture.asset(
                            'assets/Ellipse/Intersect.svg',
                            height: 100,
                            width: 70,
                            color: intersectColor,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 30, top: 15),
                                  child: Text(
                                    publicSession.id.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                      color: Color(0xFF292D3D),
                                      height: 1.2, // Equivalent to line height 24sp
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    publicSession.session.status,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 50),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    publicSession.session.sessionName,
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Color(0xFF292D3D),
                                      height: 1.2, // Equivalent to line height 24sp
                                    ),
                                  ),
                                  Text(
                                    publicSession.session.sessionDescription,
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Max Reservations: ${publicSession.maximumNumberOfReservations}',
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, top: 160),
                                  child: const Text(
                                    'Start',
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xFF292D3D),
                                      height: 1.2, // Equivalent to line height 24sp
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10, bottom: 20),
                                  child: Text(
                                    publicSession.session.sessionStartTime,
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 160),
                                  child: const Text(
                                    'End',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xFF292D3D),
                                      height: 1.2, // Equivalent to line height 24sp
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    publicSession.session.sessionEndTime,
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 160),
                                  child: const Text(
                                    'Date',
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xFF292D3D),
                                      height: 1.2, // Equivalent to line height 24sp
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    publicSession.session.sessionDate,
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Checkbox(
                              value: publicSession.isReserved,
                              onChanged: (bool? value) {
                                if (value != null && value) {
                                  serviceController.bookSession(publicSession);
                                } else {
                                  serviceController.cancelReservation(publicSession);
                                }
                              },
                              activeColor: Color(0xFF292D3D),
                              checkColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        }
      }),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // استيراد SharedPreferences
// import 'package:tired/Add_public_session.dart';
// import 'package:tired/Edit_public_session.dart';
//
// import 'addsession.dart';
// import 'controllers/ServiceController.dart';
// import 'edit_session.dart';
// import 'model/public_session.dart'; // استيراد PublicSession
//
// class studant_public_session_view extends StatelessWidget {
//   final ServiceController serviceController = Get.put(ServiceController());
//   final List<String> colors = [
//     '#FF8B3A',
//     '#BFB9FD',
//     '#77B8A1',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final int serviceId = Get.arguments;
//     serviceController.fetchPublicSessions(serviceId);
//
//     return Scaffold(
//       body: Obx(() {
//         if (serviceController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (serviceController.sessions.isEmpty) {
//           return Stack(
//             children: [
//               Center(child: Text('No Sessions Found')),
//
//             ],
//           );
//         } else {
//           return Stack(
//             children: [
//               ListView.builder(
//                 itemCount: serviceController.sessions.length,
//                 itemBuilder: (context, index) {
//                   var publicSession = serviceController.sessions[index];
//                   Color containerColor =
//                   Color(int.parse(colors[index % 3].substring(1, 7), radix: 16) + 0xFF000000);
//                   Color intersectColor = containerColor.withOpacity(0.7);
//                   Color lighterColor = intersectColor.withOpacity(0.8);
//
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 35, top: 15),
//                     child: Stack(
//                       alignment: AlignmentDirectional.topStart,
//                       children: [
//                         Container(
//                           width: 330,
//                           height: 215,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(28),
//                             color: lighterColor,
//                           ),
//                         ),
//                         Positioned(
//                           left: 0,
//                           top: 0,
//                           child: SvgPicture.asset(
//                             'assets/Ellipse/Intersect.svg',
//                             height: 100,
//                             width: 70,
//                             color: intersectColor,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Column(
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.only(left: 30, top: 15),
//                                   child: Text(
//                                     publicSession.id.toString(),
//                                     textAlign: TextAlign.center,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.only(left: 30),
//                                   child: Text(
//                                     publicSession.session.status,
//                                     textAlign: TextAlign.center,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(width: 50),
//                             Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     publicSession.session.sessionName,
//                                     textAlign: TextAlign.left,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                     ),
//                                   ),
//                                   Text(
//                                     publicSession.session.sessionDescription,
//                                     textAlign: TextAlign.left,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Max Reservations: ${publicSession.maximumNumberOfReservations}',
//                                     textAlign: TextAlign.left,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.only(left: 10, top: 140),
//                               child: const Text(
//                                 'Date',
//                                 textAlign: TextAlign.left,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(left: 10, top: 140),
//                               child: Text(
//                                 publicSession.session.sessionDate,
//                                 textAlign: TextAlign.left,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.only(left: 10, top: 160),
//                                   child: const Text(
//                                     'Start',
//                                     textAlign: TextAlign.left,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.only(left: 10, bottom: 20),
//                                   child: Text(
//                                     publicSession.session.sessionStartTime,
//                                     textAlign: TextAlign.left,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(width: 20),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.only(top: 160),
//                                   child: const Text(
//                                     'End',
//                                     textAlign: TextAlign.start,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.only(bottom: 20),
//                                   child: Text(
//                                     publicSession.session.sessionEndTime,
//                                     textAlign: TextAlign.left,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.visible,
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric( horizontal: 60,vertical: 10),
//                           child: Align(
//                             alignment: Alignment.topRight,
//                             child: Checkbox(
//                               value: publicSession.isReserved,
//                               onChanged: (bool? value) {
//                                 if (value != null && value) {
//                                   serviceController.bookSession(publicSession.id).then((_) {
//                                     // تحديث حالة الحجز بعد الحجز بنجاح
//                                     publicSession.isReserved = true;
//                                     // حفظ حالة الحجز في SharedPreferences
//                                     SharedPreferences.getInstance().then((prefs) {
//                                       prefs.setBool('isReserved_${publicSession.id}', true);
//                                       print(publicSession.id);
//                                       serviceController.fetchPublicSessions(serviceId);
//                                     });
//                                   });
//                                 }
//                               },
//                               activeColor:  Color(0xFF292D3D),
//                               checkColor: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//
//             ],
//           );
//         }
//       }),
//     );
//   }
// }
