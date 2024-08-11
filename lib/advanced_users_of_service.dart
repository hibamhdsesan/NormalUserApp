import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Advanceduser_related_session_view.dart';
import 'controllers/ServiceController.dart';
import 'controllers/SessionsController.dart';
import 'student_related_session_view.dart';

class AdvancedUsersView extends StatefulWidget {
  @override
  _AdvancedUsersViewState createState() => _AdvancedUsersViewState();
}

class _AdvancedUsersViewState extends State<AdvancedUsersView> {
  final ServiceController serviceController = Get.put(ServiceController());
  final RxInt selectedIndex = (0).obs;
 // final SessionController sessionController = Get.put(SessionController());
  final int serviceId = Get.arguments; // Get the passed service ID

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (serviceController.advancedUsers.isNotEmpty) {
        var firstUserId = serviceController.advancedUsers[0]['id'];
        if (firstUserId != null) {
          serviceController.fetchPrivateSessions(firstUserId, serviceId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (serviceController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (serviceController.advancedUsers.isEmpty) {
            return Center(child: Text('No Advanced Users Found'));
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Container(
                    height: 80, // Adjust the height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: serviceController.advancedUsers.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            selectedIndex.value = index;
                            var userId = serviceController.advancedUsers[index]['id'];
                            if (userId != null) {
                              serviceController.fetchPrivateSessions(serviceId,userId);
                              Get.to(() => student_related_session_view(), arguments: [serviceId,userId]);
                            } else {
                              Get.snackbar('Error', 'User ID is null');
                            }
                          },
                          child: Obx(() {
                            bool isSelected = selectedIndex.value == index;
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 20.0),
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.orange : Colors.transparent,
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: Text(
                                  serviceController.advancedUsers[index]['fullName'],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
               /* Expanded(
                  child: Obx(() {
                    if (serviceController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (serviceController.privateSessions.isEmpty) {
                      return Center(child: Text('No Sessions Found'));
                    } else {

                      return Advanced_related_session_view();
                    }
                  }),
                ),*/
              ],
            );
          }
        }),
      ),
    );
  }
}

//حااافظي عليه
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'Advanceduser_related_session_view.dart';
// import 'controllers/ServiceController.dart';
// import 'controllers/SessionsController.dart';
// import 'controllers/session2Controller.dart';
// import 'student_related_session_view.dart'; // Import the new session view
// class AdvancedUsersView extends StatefulWidget {
//   @override
//   _AdvancedUsersViewState createState() => _AdvancedUsersViewState();
// }
//
// class _AdvancedUsersViewState extends State<AdvancedUsersView> {
//   final ServiceController serviceController = Get.put(ServiceController());
//   final RxInt selectedIndex = (0).obs;
//   final SessionController sessionController = Get.put(SessionController());
//   //final Session2Controller _sessionController = Get.put(Session2Controller());
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (serviceController.advancedUsers.isNotEmpty) {
//         var firstUserId = serviceController.advancedUsers[0]['advancedUserID'];
//         if (firstUserId != null) {
//           serviceController.fetchSessions(firstUserId);
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Obx(() {
//           if (serviceController.isLoading.value) {
//             return Center(child: CircularProgressIndicator());
//           } else if (serviceController.advancedUsers.isEmpty) {
//             return Center(child: Text('No Advanced Users Found'));
//           } else {
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 28.0),
//                   child: Container(
//                     height: 80, // Adjust the height as needed
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: serviceController.advancedUsers.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             selectedIndex.value = index;
//                             var userId = serviceController.advancedUsers[index]['advancedUserID'];
//                             if (userId != null) {
//                               serviceController.fetchSessions(userId);
//                               Get.to(() => Advanced_related_session_view(), arguments: userId); // Pass userId as argument
//                             } else {
//                               Get.snackbar('Error', 'User ID is null');
//                             }
//                           },
//                           child: Obx(() {
//                             bool isSelected = selectedIndex.value == index;
//                             return Container(
//                               margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 20.0),
//                               padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                               decoration: BoxDecoration(
//                                 color: isSelected ? Colors.orange : Colors.transparent,
//                                 border: Border.all(color: Colors.orange),
//                                 borderRadius: BorderRadius.circular(20.0),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   serviceController.advancedUsers[index]['fullName'],
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                             );
//                           }),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Obx(() {
//                     if (serviceController.isLoading.value) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (serviceController.sessions.isEmpty) {
//                       return Center(child: Text('No Sessions Found'));
//                     } else {
//                       return Advanced_related_session_view(); // Navigate to the session view
//                     }
//                   }),
//                 ),
//               ],
//             );
//           }
//         }),
//       ),
//     );
//   }
// }

/*class AdvancedUsersView extends StatefulWidget {
  @override
  _AdvancedUsersViewState createState() => _AdvancedUsersViewState();
}

class _AdvancedUsersViewState extends State<AdvancedUsersView> {
  final ServiceController serviceController = Get.put(ServiceController());
  final RxInt selectedIndex = (0).obs;
  final SessionController sessionController = Get.put(SessionController());
  final Session2Controller _sessionController = Get.put(Session2Controller());

  @override
  void initState() {
    super.initState();
    // Fetch sessions for the first advanced user by default
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (serviceController.advancedUsers.isNotEmpty) {
        var firstUserId = serviceController.advancedUsers[0]['advancedUserID'];
        if (firstUserId != null) {
          _sessionController.fetchSessions(firstUserId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       /* appBar: AppBar(
          title: Text('Advanced Users'),
          backgroundColor: Color(0xFF292D3D),
        ),*/
        body: Obx(() {
          if (serviceController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (serviceController.advancedUsers.isEmpty) {
            return Center(child: Text('No Advanced Users Found'));
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Container(
                    height: 80, // Adjust the height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: serviceController.advancedUsers.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            selectedIndex.value = index;
                            var userId = serviceController.advancedUsers[index]['advancedUserID'];
                            if (userId != null) {
                              _sessionController.fetchSessions(userId);
                            } else {
                              Get.snackbar('Error', 'User ID is null');
                            }
                          },
                          child: Obx(() {
                            bool isSelected = selectedIndex.value == index;
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 20.0),
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.orange : Colors.transparent,
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: Text(
                                  serviceController.advancedUsers[index]['fullName'],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (_sessionController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (_sessionController.sessions.isEmpty) {
                      return Center(child: Text('No Sessions Found'));
                    } else {
                      ///////////////////////change here
                      return Advanced_session_view(); // Navigate to the session view
                    }
                  }),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}*/

//شغال
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'controllers/ServiceController.dart';
// import 'controllers/SessionsController.dart';
// import 'controllers/session2Controller.dart';
// import 'student_related_session_view.dart'; // Import the new session view
//
// class AdvancedUsersView extends StatelessWidget {
//   final ServiceController serviceController = Get.put(ServiceController());
//   final RxInt selectedIndex = (0).obs; // حالة لتتبع العنصر المحدد
//   final SessionController sessionController = Get.put(SessionController()); // Instantiate the new controller
//   final Session2Controller _sessionController = Get.put(Session2Controller()); // Instantiate the new controller
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Advanced Users'),
//         backgroundColor: Color(0xFF292D3D),
//       ),
//       body: Obx(() {
//         if (serviceController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (serviceController.advancedUsers.isEmpty) {
//           return Center(child: Text('No Advanced Users Found'));
//         } else {
//           return Align(
//             alignment: Alignment.topLeft,
//             child: Container(
//               height: 80, // Adjust the height as needed
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: serviceController.advancedUsers.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       selectedIndex.value = index;
//                       var userId = serviceController.advancedUsers[index]['advancedUserID'];
//
//                       if (userId != null) {
//                         _sessionController.fetchSessions(userId);
//                         Get.to(() => student_session());
//                       } else {
//                         Get.snackbar('Error', 'User ID is null');
//                       }
//                     },
//                     child: Obx(() {
//                       bool isSelected = selectedIndex.value == index;
//                       return Container(
//                         margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 20.0),
//                         padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                         decoration: BoxDecoration(
//                           color: isSelected ? Colors.orange : Colors.transparent,
//                           border: Border.all(color: Colors.orange),
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: Center(
//                           child: Text(
//                             serviceController.advancedUsers[index]['fullName'],
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       );
//                     }),
//                   );
//                 },
//               ),
//             ),
//           );
//         }
//       }),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'controllers/ServiceController.dart';
//
//
// class AdvancedUsersView extends StatelessWidget {
//   final ServiceController serviceController = Get.put(ServiceController());
//   final RxInt selectedIndex = (0).obs; // حالة لتتبع العنصر المحدد
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Advanced Users'),
//         backgroundColor: Color(0xFF292D3D),
//       ),
//       body: Obx(() {
//         if (serviceController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (serviceController.advancedUsers.isEmpty) {
//           return Center(child: Text('No Advanced Users Found'));
//         } else {
//           return Align(
//             alignment: Alignment.topLeft,
//             child: Container(
//               height: 80, // Adjust the height as needed
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: serviceController.advancedUsers.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       selectedIndex.value = index;
//                     },
//                     child: Obx(() {
//                       bool isSelected = selectedIndex.value == index;
//                       return Container(
//                         margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 20.0),
//                         padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                         decoration: BoxDecoration(
//                           color: isSelected ? Colors.orange : Colors.transparent,
//                           border: Border.all(color: Colors.orange),
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: Center(
//                           child: Text(
//                             serviceController.advancedUsers[index]['fullName'],
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       );
//                     }),
//                   );
//                 },
//               ),
//             ),
//           );
//         }
//       }),
//     );
//   }
// }
