import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'Advanced_public_session.dart';
import 'controllers/ServiceController.dart';
import 'globals.dart';
import 'interviews_view.dart';
import 'studant_public_session.dart';

class Activity_view extends StatelessWidget {

  final ServiceController serviceController = Get.put(ServiceController());
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
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
                  },
                  child: Text('Exams', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
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
                    Get.to(() => studant_public_session_view(), arguments: serviceId);
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
                            Get.to(() => studant_public_session_view(), arguments: childServiceId);
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
                        Get.to(() => studant_public_session_view(), arguments: serviceId);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
