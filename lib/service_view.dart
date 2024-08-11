import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'Activity_view.dart';
import 'Advanceduser_session_view.dart';
import 'Exam_view.dart';
import 'advanced_users_of_service.dart';
import 'controllers/ServiceController.dart';
import 'interviews_view.dart';

class ServiceView extends StatelessWidget {
  final ServiceController serviceController = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    // جلب البيانات الخاصة بـ 'activity' عند بدء التطبيق
    serviceController.fetchServices('activities');
    final List<Color> containerColors = [
      Color(0xFFFFCABE),
      Color(0xFFDBC6FC),
      Color(0xFFB0E7D3),
      Color(0xffC5EAFB),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF292D3D),
        //title: Text('Service App'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    serviceController.fetchServices('activities');
                    Get.to(() => Activity_view());
                  },
                  child: Text('Activity', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => InterviewsView());
                  },
                  child: Text('Interviews', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    serviceController.fetchServices('exams');
                    Get.to(() => Exam_view());
                  },
                  child: Text('Exams', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
     /* body: Obx(() {
        if (serviceController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (serviceController.services.isEmpty) {
          return Center(child: Text('No Services Found'));
        } else {
          return ListView.builder(
            itemCount: serviceController.services.length,
            itemBuilder: (context, index) {
              Color containerColor = containerColors[index % containerColors.length];
              var service = serviceController.services[index];
              bool hasChildren = service['children'] != null && service['children'].isNotEmpty;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    int serviceId = service['id'];
                    serviceController.fetchPublicSessions(serviceId);
                    Get.to(() => Advanced_public_session_view(), arguments: serviceId);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: containerColor,
                    ),
                    child: hasChildren
                        ? ExpansionTile(
                      leading: SvgPicture.asset(
                        'assets/icon/code.svg',
                        color: Color(0xFF292D3D),
                      ),
                      title: Text(service['serviceName']),
                      subtitle: Text(service['serviceDescription']),
                      children: service['children'].map<Widget>((child) {
                        return ListTile(
                          title: Text(child['serviceName']),
                          subtitle: Text(child['serviceDescription']),
                          onTap: () {
                            int childServiceId = child['id'];
                            serviceController.fetchPublicSessions(childServiceId);
                            Get.to(() => Advanced_public_session_view(), arguments: childServiceId);
                          },
                        );
                      }).toList(),
                    )
                        : ListTile(
                        leading: SvgPicture.asset(
                        'assets/icon/code.svg',
                        color: Color(0xFF292D3D),
                      ),
                        title: Text(service['serviceName']),
                        subtitle: Text(service['serviceDescription']),
                      onTap: () {
                        int serviceId = service['id'];
                        serviceController.fetchPublicSessions(serviceId);
                        Get.to(() => Advanced_public_session_view(), arguments: serviceId);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),*/
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:tired/student_session_view.dart';
// import 'Advanceduser_session_view.dart';
// import 'advanced_users_of_service.dart';
// import 'controllers/ServiceController.dart';
// import 'interviews_view.dart';
//
// class ServiceView extends StatelessWidget {
//   final ServiceController serviceController = Get.put(ServiceController());
//
//   @override
//   Widget build(BuildContext context) {
//     // جلب البيانات الخاصة بـ 'activity' عند بدء التطبيق
//     serviceController.fetchServices('activities');
//     final List<Color> containerColors = [
//       Color(0xFFFFCABE),
//       Color(0xFFDBC6FC),
//       Color(0xFFB0E7D3),
//       Color(0xffC5EAFB),
//
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF292D3D),
//         //title: Text('Service App'),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(70.0),
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     serviceController.fetchServices('activities');
//                   },
//                   child: Text('Activity', style: TextStyle(color: Colors.white)),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Get.to(() => InterviewsView());
//                   },
//                   child: Text('Interviews', style: TextStyle(color: Colors.white)),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     serviceController.fetchServices('exams');
//                   },
//                   child: Text('Exams', style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Obx(() {
//         if (serviceController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (serviceController.services.isEmpty) {
//           return Center(child: Text('No Services Found'));
//         } else {
//           return ListView.builder(
//             itemCount: serviceController.services.length,
//             itemBuilder: (context, index) {
//               Color containerColor = containerColors[index % containerColors.length];
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
//                 child: GestureDetector(
//                   onTap: () {
//                     int serviceId = serviceController.services[index]['id'];
//                     serviceController.fetch_general_Sessions(serviceId);
//                     Get.to(() => Advanced_session_view() ,arguments: serviceId);
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(28),
//                       color: containerColor,
//                     ),
//                     child: ListTile(
//                        leading: SvgPicture.asset(
//                          'assets/icon/code.svg',color:Color(0xFF292D3D),
//                        ),
//                       title: Text(serviceController.services[index]['serviceName']),
//                       subtitle: Text(serviceController.services[index]['serviceDescription']),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
// }
