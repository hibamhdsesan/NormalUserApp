
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'Add_public_session.dart';
import 'Edit_public_session.dart';
import 'addsession.dart';
import 'controllers/ServiceController.dart';
import 'edit_session.dart';
import 'reservations_for_public_session.dart';

class Advanced_public_session_view extends StatelessWidget {
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){}, icon:Icon (Icons.calendar_month_sharp,color: Colors.white,)),
          )

        ],
      ),
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
                  var publicSession = serviceController.sessions[index];
                  Color containerColor = Color(int.parse(colors[index % 3].substring(1, 7), radix: 16) + 0xFF000000);
                  Color intersectColor = containerColor.withOpacity(0.7);
                  Color lighterColor = intersectColor.withOpacity(0.8);

                  return GestureDetector(
                    onTap: () async {
                      List<String> userNames = await serviceController.fetchUserNamesForPublic(publicSession.id);
                      Get.to(() => UserNamesView(sessionId: publicSession.session.id, userNames: userNames));
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
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 30, top: 15),
                                    child: Text(
                                      publicSession.id.toString(),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:const TextStyle(
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
                              SizedBox(width: 50),
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
                                      style: const TextStyle(
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
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 140),
                                child: const Text(
                                  'Date',
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF292D3D),
                                    height: 1.2, // Equivalent to line height 24sp
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 140),
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
                                        fontSize: 16,
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
                                        fontSize: 16,
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
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (publicSession.session.status == 'created' || publicSession.session.status == 'closed') {
                                    serviceController.startSession(publicSession.session.id);
                                  } else if (publicSession.session.status == 'active') {
                                    serviceController.closeSession(publicSession.session.id);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 210, top: 160),
                                  child: SvgPicture.asset(
                                    publicSession.session.status == 'created' || publicSession.session.status == 'closed'
                                        ? 'assets/icon/start.svg'
                                        : 'assets/icon/close.svg',
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                        () => EditPublicSessionView(
                                      sessionId: publicSession.session.id,
                                      initialSessionName: publicSession.session.sessionName,
                                      initialSessionDescription: publicSession.session.sessionDescription,
                                      initialSessionDate: publicSession.session.sessionDate,
                                      initialSessionStartTime: publicSession.session.sessionStartTime,
                                      initialSessionEndTime: publicSession.session.sessionEndTime,
                                          initialMaximumNumberOfReservations: publicSession.maximumNumberOfReservations.toString(),
                                    ), arguments: serviceId ,
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
                                  serviceController.deleteSession(publicSession.session.id, serviceId);
                                  serviceController.fetchPublicSessions(serviceId);
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
                    Get.to(() => Add_public_SessionView(), arguments: serviceId);
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
