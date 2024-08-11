import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'AdvancedPrivateReservationsView.dart';
import 'Edit_private_session.dart';
import 'add_private_session.dart';
import 'addsession.dart';
import 'controllers/ServiceController.dart';
import 'controllers/session2Controller.dart';
import 'edit_session.dart';

class Advanced_related_session_view extends StatelessWidget {
  final ServiceController serviceController = Get.put(ServiceController());
  final List<String> colors = [
    '#FF8B3A',
    '#BFB9FD',
    '#77B8A1',
  ];

  @override
  Widget build(BuildContext context) {
    // Check Get.arguments type
    if (Get.arguments == null || Get.arguments is! List<dynamic> || Get.arguments.length < 2) {
      return Scaffold(
        body: Center(
          child: Text('Invalid arguments passed.'),
        ),
      );
    }
    final List<dynamic> args = Get.arguments;
    final int? passedUserId = args[0];
    final int serviceId = args[1];

    return Scaffold(
      body: Obx(() {
        if (serviceController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (serviceController.privateSessions.isEmpty) {
          return Center(child: Text('No Sessions Found'));
        } else {

          final int userId = passedUserId ?? serviceController.privateSessions.first.id;

          return Stack(
            children: [
              ListView.builder(
                itemCount: serviceController.privateSessions.length,
                itemBuilder: (context, index) {
                  var privateSession = serviceController.privateSessions[index];
                  var session = privateSession.session;
                  Color containerColor =
                  Color(int.parse(colors[index % 3].substring(1, 7), radix: 16) + 0xFF000000);
                  Color intersectColor = containerColor.withOpacity(0.7);
                  Color lighterColor = intersectColor.withOpacity(0.8);

                  return GestureDetector(
                    onTap: ()
                    {
                      Get.to(()=> PrivateReservationsView(privateSessionID: privateSession.id), arguments: [serviceId, passedUserId]);
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
                                      privateSession.id.toString(),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Color(0xFF292D3D),
                                        height: 1.2, // Equivalent to line height 24sp
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
                              Padding(
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Color(0xFF292D3D),
                                        height: 1.2, // Equivalent to line height 24sp
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
                                // onTap: () {
                                //   if (session.status == 'created' || session.status == 'closed') {
                                //     serviceController.startPrivateSession(session.id);
                                //     print(session.id);
                                //   } else if (session.status == 'active') {
                                //     serviceController.closePrivateSession(session.id);
                                //   }
                                // },
                                // child: Container(
                                //   padding: EdgeInsets.only(left: 210, top: 160),
                                //   child: SvgPicture.asset(
                                //     session.status == 'created' || session.status == 'closed'
                                //         ? 'assets/icon/start.svg'
                                //         : 'assets/icon/close.svg',
                                //   ),
                                // ),
                                onTap: () {
                                  if (session?.status == 'created' || session?.status == 'closed') {
                                    serviceController.startPrivateSession(session.id);
                                    print(session.id);
                                  } else if (session?.status == 'active') {
                                    serviceController.closePrivateSession(session.id);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 210, top: 160),
                                  child: SvgPicture.asset(
                                    session?.status == 'created' || session?.status == 'closed'
                                        ? 'assets/icon/start.svg'
                                        : 'assets/icon/close.svg',
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                        () =>  EditPrivateSessionView(
                                          sessionId: privateSession.id,
                                          initialSessionName: privateSession.session.sessionName,
                                          initialSessionDescription: privateSession.session.sessionDescription,
                                          initialSessionDate: privateSession.session.sessionDate,
                                          initialSessionStartTime: privateSession.session.sessionStartTime,
                                          initialSessionEndTime: privateSession.session.sessionEndTime,
                                          initialDurationForEachReservation: privateSession.durationForEachReservation,
                                        ),arguments: [serviceId, userId]
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
                                  serviceController.deleteSession(session.id, userId);
                                  serviceController.fetchPrivateSessions(userId,serviceId);
                                  print(userId);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10, top: 160),
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
                    Get.to(() => Add_private_SessionView(), arguments: [serviceId, userId]);
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

// class Advanced_related_session_view extends StatelessWidget {
//   final ServiceController serviceController = Get.put(ServiceController());
//   final List<String> colors = [
//     '#FF8B3A',
//     '#BFB9FD',
//     '#77B8A1',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final List<int> args = Get.arguments; // Get the passed arguments
//     final int userId = args[0];
//     final int serviceId = args[1];
//
//     return Scaffold(
//       body: Obx(() {
//         if (serviceController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (serviceController.sessions.isEmpty) {
//           return Center(child: Text('No Sessions Found'));
//         } else {
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
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 35, top: 170),
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       // Implement edit button functionality
//                                     },
//                                     child: Text('Edit'),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           );
//         }
//       }),
//     );
//   }
// }

//حافظي عليه
/*class Advanced_related_session_view extends StatelessWidget {
  final ServiceController serviceController = Get.put(ServiceController());
  final List<String> colors = [
    '#FF8B3A',
    '#BFB9FD',
    '#77B8A1',
  ];

  @override
  Widget build(BuildContext context) {
    final int? passedUserId = Get.arguments; // Get the passed service ID

    return Scaffold(
      body: Obx(() {
        if (serviceController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (serviceController.sessions.isEmpty) {
          return Center(child: Text('No Sessions Found'));
        } else {
          // إذا كانت قيمة passedServiceId null، اعتمد أول service ID كـ id افتراضي
          final int userId = passedUserId ?? serviceController.sessions.first.id;

          return Stack(
            children: [
              ListView.builder(
                itemCount: serviceController.sessions.length,
                itemBuilder: (context, index) {
                  var session = serviceController.sessions[index];
                  Color containerColor = Color(int.parse(colors[index % 3].substring(1, 7), radix: 16) + 0xFF000000);
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
                            Padding(
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
                                serviceController.deleteSession(session.id, userId);
                                serviceController.fetchSessions(userId);
                                print(userId);
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
                  );
                },
              ),
              Positioned(
                bottom: 30,
                right: 30,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.to(() => AddSessionView(), arguments: userId);
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
}*/

///////////////
/*class Advanced_session_view extends StatelessWidget {
  final Session2Controller sessionController = Get.put(Session2Controller());
  final ServiceController serviceController = Get.put(ServiceController());
  final List<String> colors = [
    '#FF8B3A',
    '#BFB9FD',
    '#77B8A1',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() {
        if (sessionController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (sessionController.sessions.isEmpty) {
          return Center(child: Text('No Sessions Found'));
        } else {
          return Stack(
            children: [
              /* Positioned(
                left: 0,
                top: 0,
                child: SvgPicture.asset(
                  'assets/Ellipse/Sign_up.svg',
                 // colorBlendMode: BlendMode.srcOver,
                ),
              ),*/
              ListView.builder(
                itemCount: sessionController.sessions.length,
                itemBuilder: (context, index) {
                  var session = sessionController.sessions[index];
                  Color containerColor = Color(int.parse(colors[index % 3].substring(1, 7), radix: 16) + 0xFF000000);
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
                            Padding(
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
                                // SizedBox(width: 40),

                              ],
                            ),
                            const SizedBox(width: 20,),
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
                                //const SizedBox(width: 30),
                                Container(
                                  padding: EdgeInsets.only( bottom: 20),
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

                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 210, top: 160),
                                child:  SvgPicture.asset(
                                  'assets/icon/start.svg',
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                padding: EdgeInsets.only(left:10, top: 160 ),
                                child: SvgPicture.asset(
                                  'assets/icon/edit.svg',
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: () {


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
                  );
                },
              ),
            ],
          );
        }
      }),
    );
  }
}*/
//////////////

class LectureDoc extends StatelessWidget {
  final List<String> colors = [
    '#FF8B3A', // لون العنصر الأول
    '#BFB9FD', // لون العنصر الثاني
    '#77B8A1', // لون العنصر الثالث
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        // elevation: 0,
        leading: Icon(Icons.arrow_back),
      ),
      body: Stack(
        children: [
      Container(
      child: Positioned(
      left: 0,
        top: 0,
        child: SvgPicture.asset(
          'assets/Ellipse.svg',
          colorBlendMode: BlendMode.srcOver,
          // استخدم نفس اللون ولكن بشفافية أكبر
        ),
      ),
    ),
    ListView.builder(
    itemCount: null, // عدد العناصر غير محدد
    itemBuilder: (context, index) {
    // تحديد لون العنصر بناء على فهرسه في القائمة
    Color containerColor = Color(int.parse(colors[index % 3].substring(1, 7), radix: 16) + 0xFF000000);
    Color svgColor = containerColor.withOpacity(0.5); // زيادة شفافية اللون لجعله أفتح
    Color lighterColor = containerColor.withOpacity(0.7); // تقليل شفافية اللون لجعله أفتح بـ 3 درجات

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
    color: lighterColor, // لون العنصر أفتح بـ 3 درجات
    ),
    child: Row (children: [],),
    ),
    Container(
    child: Positioned(
    left: 0,
    top: 0,
    child: SvgPicture.asset(
    'assets/Intersect.svg',
    height: 100,
    width: 70,
    color: svgColor,
    // استخدم نفس اللون ولكن بشفافية أكبر
    ),
    ),
    ),
    Row(children: [
    Column(children: [
    Container(
    padding: EdgeInsets.only(left: 30, top: 15),
    child: Text(
    '01',
    textAlign: TextAlign.center,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
    color: Colors.black,
    fontSize: 24, // تعيين حجم الخط إلى 24 نقطة
    ),
    ),
    ),
    Container(
    padding: EdgeInsets.only(left: 30,),
    child: Text(
    'Status',
    textAlign: TextAlign.center,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
    color: Colors.black,
    ),
    ),
    ),
    ],),
    SizedBox(width: 50, ),
    Column(children: [
    Container(
    padding: EdgeInsets.only(left: 15, top: 10),child: Text(
    'Introduction',
    textAlign: TextAlign.left,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
    color: Colors.black,
    fontSize: 24, // تعيين حجم الخط إلى 24 نقطة
    ),
    ),
    ),
    Container(
    padding: EdgeInsets.only(right: 40,),
    child: Text(
    'Dr.Ammar',
    textAlign: TextAlign.left,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
    color: Colors.black,
    ),
    ),
    ),
    Container(
    padding: EdgeInsets.only(right: 40,),
    child: Text(
    'Description',
    textAlign: TextAlign.left,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
    color: Colors.black,
    ),
    ),
    ),
    ],),
    Container(
    padding: EdgeInsets.only(left: 20 ,bottom:20 ),
    child:Icon(Icons.qr_code, color: Colors.black),
    ),

    ],),
    SizedBox(height: 30,),
    Row(
    children: [
    Container(
    padding: EdgeInsets.only(left: 210 , top: 150 ),
    child: IconButton(
    icon: Icon(Icons.edit),
    onPressed: () {
    // الإجراء الذي يتم تنفيذه عند الضغط على أيقونة الحذف
    },

    ),
    ),
    //  SizedBox(width: 10,),
    GestureDetector(
    child: Container(
    padding: EdgeInsets.only(top: 150),
    child:IconButton(
    icon: Icon(Icons.delete),
    onPressed: () {
    // الإجراء الذي يتم تنفيذه عند الضغط على أيقونة الحذف
    },),
    ),),
    ],
    ),
    Column(children: [
    Row(
    children: [
    Container(
    padding: EdgeInsets.only(left: 0,top: 110),
    child: IconButton(
    icon: Icon(Icons.play_circle_filled, color: Colors.black) ,// أيقونة تشغيل الفيديو
    onPressed: () {
    // هنا يمكنك وضع الإجراء الذي يتم تنفيذه عند الضغط على الأيقونة
    // مثلاً، فتح مشغل الفيديو أو تشغيل فيديو معين
    },
    ),
    ),
    SizedBox(width: 15,),
    Container(
    padding: EdgeInsets.only(left: 0,top: 110),
    child:Icon(Icons.pause_circle_filled, color: Colors.black),
    ),
    ],
    ),
    Row(
    children: [
    Container(
    padding: EdgeInsets.only(left: 10,),
    child: Text(
    'Start',
    textAlign: TextAlign.left,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
    color: Colors.black,
    ),
    ),

    ),
    SizedBox(width: 40,),
    Container(
    padding: EdgeInsets.only(top:0),
    child:Text(
    'End',
    textAlign: TextAlign.start,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
    color: Colors.black,
    ),
    ),
    ),
    ],
    ),
    // SizedBox(height: 5,),
    Row(
    children: [
    Row(
    children: [
    Container(
    padding: EdgeInsets.only(left: 10 , bottom: 20),
    child: Text(
    '08:30',
    textAlign: TextAlign.left,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
    color: Colors.black,
    ),
    ),
    ),
    SizedBox(width: 30,),
    Container(
    padding: EdgeInsets.only(left: 5,bottom: 20),
    child:Text(
    '10:30',
    textAlign: TextAlign.left,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(color: Colors.black,
    ),
    ),
    ),
    ],
    ),
    ],
    ),
    ],)
    ],
    ),
    );
    },
    ),
        ],
      ),






    );

  }
}