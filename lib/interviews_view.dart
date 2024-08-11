
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'Ask_swap_request_view.dart';
import 'advanced_users_of_service.dart';
import 'controllers/ServiceController.dart';
import 'globals.dart';
import 'sent_request_view.dart';

class InterviewsView extends StatelessWidget {
  final ServiceController serviceController = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    // جلب البيانات الخاصة بـ 'projects interviews' عند بدء الشاشة
    serviceController.fetchServices('projects interviews');

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFF292D3D),
        //title: Text('Interviews Services'),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () {
              Get.to(() => SwapRequestsView());
            },
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              Get.to(() => SentSwapRequestsView());
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  serviceController.fetchServices('projects interviews');
                },
                child: Text('Projects Interviews', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {
                  serviceController.fetchServices('advanced users interviews');
                },
                child: Text('Advanced Users Interviews', style: TextStyle(color: Colors.white)),
              ),
            ],
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
                    // int serviceId = serviceController.services[index]['id'];
                    // serviceController.fetchAdvancedUsers(serviceId);
                    // Get.to(() => AdvancedUsersView());
                    int serviceId = serviceController.services[index]['id'];
                    serviceController.fetchAdvancedUsers(serviceId);
                    Get.to(() => AdvancedUsersView(), arguments: serviceId);
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
                            //serviceController.fetchSessions(childServiceId);
                            Get.to(() => AdvancedUsersView());
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

                        // int serviceId = serviceController.services[index]['id'];
                        // serviceController.fetchAdvancedUsers(serviceId);
                        // Get.to(() => AdvancedUsersView());
                        int serviceId = serviceController.services[index]['id'];
                        serviceController.fetchAdvancedUsers(serviceId);
                        Get.to(() => AdvancedUsersView(), arguments: serviceId);
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    int serviceId = serviceController.services[index]['id'];
                    serviceController.fetchAdvancedUsers(serviceId);
                    Get.to(() => AdvancedUsersView());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: containerColor,
                    ),
                    child: ListTile(
                      leading: SvgPicture.asset(
                        'assets/icon/code.svg',color:Color(0xFF292D3D) ,
                      ),
                      title: Text(serviceController.services[index]['serviceName']),
                      subtitle: Text(serviceController.services[index]['serviceDescription']),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),*/