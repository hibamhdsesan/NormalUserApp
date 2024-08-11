
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Qr/AdvancedQrScreen.dart';
import 'Qr/AttendanceOfOneSession.dart';
import 'addsession.dart';
import 'controllers/ServiceController.dart';
import 'edit_session.dart';
import 'globals.dart';

class Advanced_session_view extends StatelessWidget {
  final ServiceController serviceController = Get.put(ServiceController());
  final List<String> colors = [
    '#FF8B3A',
    '#BFB9FD',
    '#77B8A1',
  ];

  @override
  Widget build(BuildContext context) {
    final int serviceId = Get.arguments;

    return Scaffold(
      body: Obx(() {
        if (serviceController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (serviceController.sessions.isEmpty) {
          return Stack(
            children: [
              Center(child: Text('No Sessions Found')),
              Positioned(
                bottom: 30,
                right: 30,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.to(() => AddSessionView(), arguments: serviceId);
                  },
                  backgroundColor: Color(0xFF292D3D),
                  child: Icon(Icons.add),
                ),
              ),
            ],
          );
        } else {
          return Stack(
            children: [
              ListView.builder(
                itemCount: serviceController.sessions.length,
                itemBuilder: (context, index) {
                  var session = serviceController.sessions[index];
                  Color containerColor = Color(int.parse(colors[index % 3].substring(1, 7), radix: 16) + 0xFF000000);
                  Color intersectColor = containerColor.withOpacity(0.7);
                  Color lighterColor = intersectColor.withOpacity(0.8);
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => UserNamesView(sessionId: session.id));
                    },
                    child: Padding(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 30, top: 15),
                                    child: Text(
                                      session.id.toString(),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text(
                                      session.status,
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
                              SizedBox(width: 50),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        session.sessionName,
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                        ),
                                      ),
                                      Text(
                                        session.sessionDescription,
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: GestureDetector(
                                  onTap: () async {
                                    // استرجاع accessToken من SharedPreferences
                                    final prefs = await SharedPreferences.getInstance();
                                    final String? accessToken = prefs.getString('accessToken');

                                    // التحقق من وجود accessToken
                                    if (accessToken == null) {
                                      Get.snackbar('Error', 'Access token is not set');
                                      return;
                                    }

                                    // إرسال الطلب عبر HTTP GET
                                    try {
                                      final response = await http.get(
                                        Uri.parse('$baseURL/api/attendance/showSessionQr/${session.id}'),
                                        headers: <String, String>{
                                          'Content-Type': 'application/json; charset=UTF-8',
                                          'Authorization': 'Bearer $accessToken',
                                        },
                                      );

                                      if (response.statusCode == 200) {
                                        final Map<String, dynamic> responseBody = jsonDecode(response.body);
                                        if (responseBody.containsKey('message')) {
                                          Get.snackbar('Error', responseBody['message']);
                                        } else if (responseBody.containsKey('image')) {
                                          final base64Image = responseBody['image'];
                                          Get.to(() => QrCodeView(base64Image: base64Image, session: session, baseURL: baseURL));
                                        } else {
                                          Get.snackbar('Error', 'Unexpected response format');
                                        }
                                      } else {
                                        print(response.statusCode);
                                        Get.snackbar('Error', 'Request failed with status: ${response.statusCode}');
                                      }
                                    } catch (e) {
                                      Get.snackbar('Error', 'An error occurred: $e');
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(Icons.qr_code, size: 35, color: Colors.black),
                                  ),
                                ),
                              ),

                            ],
                          ),

                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 140),
                                child: const Text(
                                  'Date',
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 140),
                                child: Text(
                                  session.sessionDate,
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
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
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10, bottom: 20),
                                    child: Text(
                                      session.sessionStartTime,
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
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      session.sessionEndTime,
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (session.status == 'created' || session.status == 'closed') {
                                    serviceController.startSession(session.id);
                                  } else if (session.status == 'active') {
                                    serviceController.closeSession(session.id);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 210, top: 160),
                                  child: SvgPicture.asset(
                                    session.status == 'created' || session.status == 'closed'
                                        ? 'assets/icon/start.svg'
                                        : 'assets/icon/close.svg',
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                        () => EditSessionView(
                                      sessionId: session.id,
                                      initialSessionName: session.sessionName,
                                      initialSessionDescription: session.sessionDescription,
                                      initialSessionDate: session.sessionDate,
                                      initialSessionStartTime: session.sessionStartTime,
                                      initialSessionEndTime: session.sessionEndTime,
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10, top: 160),
                                  child: SvgPicture.asset(
                                    'assets/icon/edit.svg',
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  serviceController.deleteSession(session.id, serviceId);
                                  serviceController.fetch_general_Sessions(serviceId);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 160),
                                  child: SvgPicture.asset(
                                    'assets/icon/delete.svg',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 30,
                right: 30,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.to(() => AddSessionView(), arguments: serviceId);
                  },
                  backgroundColor: Color(0xFF292D3D),
                  child: Icon(Icons.add),
                ),
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
//
// import 'addsession.dart';
// import 'controllers/ServiceController.dart';
// import 'controllers/session2Controller.dart';
// import 'edit_session.dart';
//
// class Advanced_session_view extends StatelessWidget {
//   final ServiceController serviceController = Get.put(ServiceController());
//   final List<String> colors = [
//     '#FF8B3A',
//     '#BFB9FD',
//     '#77B8A1',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final int serviceId = Get.arguments; // Get the passed service ID
//
//     return Scaffold(
//       body: Obx(() {
//         if (serviceController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (serviceController.sessions.isEmpty) {
//           return Stack(
//             children: [
//               Center(child: Text('No Sessions Found')),
//               Positioned(
//                 bottom: 30,
//                 right: 30,
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     Get.to(() => AddSessionView(), arguments: serviceId);
//                   },
//                   backgroundColor: Color(0xFF292D3D),
//                   child: Icon(Icons.add),
//                 ),
//               ),
//             ],
//           );
//         } else {
//           // إذا كانت قيمة passedServiceId null، اعتمد أول service ID كـ id افتراضي
//        //   final int serviceId = passedServiceId ?? serviceController.sessions.first.id;
//           return Stack(
//             children: [
//               ListView.builder(
//                 itemCount: serviceController.sessions.length,
//                 itemBuilder: (context, index) {
//                   var session = serviceController.sessions[index];
//                   Color containerColor = Color(int.parse(colors[index % 3].substring(1, 7), radix: 16) + 0xFF000000);
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
//                                     session.id.toString(),
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
//                                     session.status,
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
//                             SizedBox(width: 50),
//                             Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     session.sessionName,
//                                     textAlign: TextAlign.left,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                     ),
//                                   ),
//                                   Text(
//                                     session.sessionDescription,
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
//                             Container(
//                               padding: EdgeInsets.only(left: 20 ,bottom:20 ),
//                               child:Icon(Icons.qr_code, color: Colors.black),
//                             ),
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
//                                 session.sessionDate,
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
//                                     session.sessionStartTime,
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
//                                     session.sessionEndTime,
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
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 if (session.status == 'created' || session.status == 'closed') {
//                                   serviceController.startSession(session.id);
//                                 } else if (session.status == 'active') {
//                                   serviceController.closeSession(session.id);
//                                 }
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.only(left: 210, top: 160),
//                                 child: SvgPicture.asset(
//                                   session.status == 'created' || session.status == 'closed'
//                                       ? 'assets/icon/start.svg'
//                                       : 'assets/icon/close.svg',
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Get.to(
//                                       () => EditSessionView(
//                                     sessionId: session.id,
//                                     initialSessionName: session.sessionName,
//                                     initialSessionDescription: session.sessionDescription,
//                                     initialSessionDate: session.sessionDate,
//                                     initialSessionStartTime: session.sessionStartTime,
//                                     initialSessionEndTime: session.sessionEndTime,
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.only(left: 10, top: 160),
//                                 child: SvgPicture.asset(
//                                   'assets/icon/edit.svg',
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             GestureDetector(
//                               onTap: () {
//                                 serviceController.deleteSession(session.id, serviceId);
//                                 serviceController.fetch_general_Sessions(serviceId);
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.only(top: 160),
//                                 child: SvgPicture.asset(
//                                   'assets/icon/delete.svg',
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               Positioned(
//                 bottom: 30,
//                 right: 30,
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     Get.to(() => AddSessionView(), arguments: serviceId);
//                   },
//                   backgroundColor: Color(0xFF292D3D),
//                   child: Icon(Icons.add),
//                 ),
//               ),
//             ],
//           );
//         }
//       }),
//     );
//   }
// }

//sedra