// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
//
// class student_session extends StatelessWidget {
//   final List<String> colors = [
//     '#FF8B3A', // لون العنصر الأول
//     '#BFB9FD', // لون العنصر الثاني
//     '#77B8A1', // لون العنصر الثالث
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Stack(
//         children: [
//       Container(
//       child: Positioned(
//       left: 0,
//         top: 0,
//         child: SvgPicture.asset(
//           'assets/Ellipse.svg',
//           colorBlendMode: BlendMode.srcOver,
//
//         ),
//       ),
//     ),
//     ListView.builder(
//     itemCount: null, // عدد العناصر غير محدد
//     itemBuilder: (context, index) {
//     // تحديد لون العنصر بناء على فهرسه في القائمة
//     Color containerColor = Color(int.parse(colors[index % 3].substring(1, 7), radix: 16) + 0xFF000000);
//     Color intersectColor = containerColor.withOpacity(0.7); // لون الـ Intersect.svg بشفافية 0.7
//     Color lighterColor = intersectColor.withOpacity(0.8); // لون الـ container بشفافية 0.5
//
//     return Padding(
//     padding: const EdgeInsets.only(left: 35, top: 15),
//     child: Stack(
//     alignment: AlignmentDirectional.topStart,
//     children: [
//     Container(
//     width: 330,
//     height: 215,
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(28),
//     color: lighterColor, // لون الـ container بشفافية 0.5
//     ),
//     child: Row(
//     children: [],
//     ),
//     ),
//     Container(
//     child: Positioned(
//     left: 0,
//     top: 0,
//     child: SvgPicture.asset(
//     'assets/Intersect.svg',
//     height: 100,
//     width: 70,
//     color: intersectColor, // لون الـ Intersect.svg بشفافية 0.7
//     ),
//     ),
//     ),
//     Row(
//     children: [
//     Column(
//     children: [
//     Container(
//     padding: EdgeInsets.only(left: 30, top: 15),
//     child: Text(
//     '01',
//     textAlign: TextAlign.center,
//     maxLines: 2,
//     overflow: TextOverflow.ellipsis,
//     style: TextStyle(
//     color: Colors.black,
//     fontSize: 24, // تعيين حجم الخط إلى 24 نقطة
//     ),
//     ),
//     ),
//     Container(
//     padding: EdgeInsets.only(left: 30),
//     child: Text(
//     'Status',
//     textAlign: TextAlign.center,
//     maxLines: 2,
//     overflow: TextOverflow.ellipsis,
//     style: TextStyle(
//     color: Colors.black,
//     ),
//     ),
//     ),],
//     ),
//     SizedBox(width: 50),
//     Column(
//     children: [
//     Container(
//     padding: EdgeInsets.only(left: 15),
//     child: Text(
//     'Introduction',
//     textAlign: TextAlign.left,
//     maxLines: 2,
//     overflow: TextOverflow.ellipsis,
//     style: TextStyle(
//     color: Colors.black,
//     fontSize: 24, // تعيين حجم الخط إلى 24 نقطة
//     ),
//     ),
//     ),
//     Container(
//     padding: EdgeInsets.only(right: 50),
//     child: Text(
//     'Dr.Ammar',
//     textAlign: TextAlign.left,
//     maxLines: 2,
//     overflow: TextOverflow.ellipsis,
//     style: TextStyle(
//     color: Colors.black,
//     ),
//     ),
//     ),
//     ],
//     ),
//     ],
//     ),
//     Container(
//     padding: EdgeInsets.only(left: 10, top: 130),
//     child: Text(
//     'Description',
//     textAlign: TextAlign.left,
//     maxLines: 2,
//     overflow: TextOverflow.ellipsis,
//     style: TextStyle(
//     color: Colors.black,
//     ),
//     ),
//     ),
//     // SizedBox(height: 100,),
//     Column(
//     children: [
//     Row(
//     children: [
//     Container(
//     padding: EdgeInsets.only(left: 10, top: 160),
//     child: Text(
//     'Start',
//     textAlign: TextAlign.left,
//     maxLines: 2,
//     overflow: TextOverflow.ellipsis,
//     style: TextStyle(
//     color: Colors.black,
//     ),
//     ),
//     ),
//     SizedBox(width: 40),
//     Container(
//     padding: EdgeInsets.only(top: 160),
//     child: Text(
//     'End',
//     textAlign: TextAlign.start,
//     maxLines: 2,
//     overflow: TextOverflow.ellipsis,
//     style: TextStyle(
//     color: Colors.black,
//     ),
//     ),
//     ),
//     ],
//     ),
//     // SizedBox(height: 5,),
//     Row(
//     children: [
//     Container(
//     padding: EdgeInsets.only(left: 10, bottom: 20),
//     child: Text(
//     '08:30',
//     textAlign: TextAlign.left,
//     maxLines: 2,
//     overflow: TextOverflow.ellipsis,
//     style: TextStyle(color: Colors.black,
//     ),
//     ),
//     ),
//       SizedBox(width: 30),
//       Container(
//         padding: EdgeInsets.only(left: 5, bottom: 20),
//         child: Text(
//           '10:30',
//           textAlign: TextAlign.left,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//       ),
//     ],
//     ),
//     ],
//     ),
//       GestureDetector(
//         onTap: () {
//
//         },
//         child: Container(
//           padding: EdgeInsets.only(left: 270, top: 170),
//           child: Icon(Icons.qr_code_scanner, color: Colors.white70, size: 30),
//         ),
//       ),
//
//     ],
//     ),
//     );
//     },
//     ),
//         ],
//       ),
//     );
//   }
// }
//شغال
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'controllers/session2Controller.dart';
//
// class student_session extends StatelessWidget {
//   final Session2Controller sessionController = Get.find();
//
//   final List<String> colors = [
//     '#FF8B3A', // لون العنصر الأول
//     '#BFB9FD', // لون العنصر الثاني
//     '#77B8A1', // لون العنصر الثالث
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Sessions'),
//         backgroundColor: Color(0xFF292D3D),
//       ),
//       body: Obx(() {
//         if (sessionController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (sessionController.sessions.isEmpty) {
//           return Center(child: Text('No Sessions Found'));
//         } else {
//           return Stack(
//             children: [
//               Positioned(
//                 left: 0,
//                 top: 0,
//                 child: SvgPicture.asset(
//                   'assets/Ellipse.svg',
//                   colorBlendMode: BlendMode.srcOver,
//                 ),
//               ),
//               ListView.builder(
//                 itemCount: sessionController.sessions.length,
//                 itemBuilder: (context, index) {
//                   var session = sessionController.sessions[index];
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
//                           child: Row(
//                             children: [],
//                           ),
//                         ),
//                         Positioned(
//                           left: 0,
//                           top: 0,
//                           child: SvgPicture.asset(
//                             'assets/Intersect.svg',
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
//                                     style: TextStyle(
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
//                             Column(
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.only(left: 15),
//                                   child: Text(
//                                     session.sessionName,
//                                     textAlign: TextAlign.left,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.only(right: 50),
//                                   child: Text(
//                                     session.sessionDescription,
//                                     textAlign: TextAlign.left,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(left: 10, top: 130),
//                           child: Text(
//                             'Description',
//                             textAlign: TextAlign.left,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.only(left: 10, top: 160),
//                                   child: Text(
//                                     'Start',
//                                     textAlign: TextAlign.left,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 40),
//                                 Container(
//                                   padding: EdgeInsets.only(top: 160),
//                                   child: Text(
//                                     'End',
//                                     textAlign: TextAlign.start,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
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
//                                 SizedBox(width: 30),
//                                 Container(
//                                   padding: EdgeInsets.only(left: 5, bottom: 20),
//                                   child: Text(
//                                     session.sessionEndTime,
//                                     textAlign: TextAlign.left,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             // QR Code action
//                           },
//                           child: Container(
//                             padding: EdgeInsets.only(left: 270, top: 170),
//                             child: Icon(Icons.qr_code_scanner),
//                           ),
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'AvailableReservationsView.dart';
import 'controllers/ServiceController.dart';
import 'controllers/session2Controller.dart';

class student_related_session_view extends StatelessWidget {
  //final Session2Controller sessionController = Get.find();
  final ServiceController serviceController =Get.put(ServiceController());

  final List<String> colors = [
    '#FF8B3A', // لون العنصر الأول
    '#BFB9FD', // لون العنصر الثاني
    '#77B8A1', // لون العنصر الثالث
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
                  Color containerColor = Color(int.parse(colors[index % 3].substring(1, 7), radix: 16) + 0xFF000000);
                  Color intersectColor = containerColor.withOpacity(0.7);
                  Color lighterColor = intersectColor.withOpacity(0.8);

                  return GestureDetector(
                    onTap: (){
                      Get.to(()=> AvailableReservationsView(privateSessionID: privateSession.id), arguments: [serviceId, passedUserId]);
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
                            child: Row(
                              children: [],
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
                                padding: const EdgeInsets.all(14),
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
                          Container(
                            padding: EdgeInsets.only(left: 10, top: 130),
                            child: Row(
                              children: [


                              ],
                            ),
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
                                      session.sessionEndTime,
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
                              )
                            ],
                          ),

                        ],
                      ),
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
