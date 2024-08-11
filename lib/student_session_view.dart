import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Qr/NormalQrScreen.dart';
import 'controllers/ServiceController.dart';
import 'controllers/session2Controller.dart';

class student_session_view extends StatelessWidget {
  //final Session2Controller sessionController = Get.find();
  final ServiceController serviceController =Get.find();

  final List<String> colors = [
    '#FF8B3A', // لون العنصر الأول
    '#BFB9FD', // لون العنصر الثاني
    '#77B8A1', // لون العنصر الثالث
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() {
        if (serviceController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (serviceController.sessions.isEmpty) {
          return Center(child: Text('No Sessions Found'));
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
                        Container(
                          padding: EdgeInsets.only(left: 10, top: 130),
                          child: const Text(
                            'Description',
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                            ),
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
                        GestureDetector(
                          onTap: () {
                            Future<void> storeUserToken(String token) async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setString('accessToken', token);
                            }
                            Get.to(() =>QRScannerScreen());
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 270, top: 170),
                            child: Icon(Icons.qr_code_scanner,size: 35,),
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
// import 'controllers/ServiceController.dart';
// import 'controllers/session2Controller.dart';
//
// class student_session_view extends StatelessWidget {
//   //final Session2Controller sessionController = Get.find();
//   final ServiceController serviceController =Get.find();
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
//
//       body: Obx(() {
//         if (serviceController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (serviceController.sessions.isEmpty) {
//           return Center(child: Text('No Sessions Found'));
//         } else {
//           return Stack(
//             children: [
//
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
//                           child: Row(
//                             children: [],
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
//                         Container(
//                           padding: EdgeInsets.only(left: 10, top: 130),
//                           child: const Text(
//                             'Description',
//                             textAlign: TextAlign.left,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
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
//                                 // SizedBox(width: 40),
//
//                               ],
//                             ),
//                             const SizedBox(width: 20,),
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
//                                 //const SizedBox(width: 30),
//                                 Container(
//                                   padding: EdgeInsets.only( bottom: 20),
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
