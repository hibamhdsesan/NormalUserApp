import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Advanceduser_related_session_view.dart';
import 'controllers/PrivateReservationController.dart';

class StudantPrivateReservationsView extends StatelessWidget {
  final int privateSessionID;
  final PrivateReservationController reservationController = Get.put(PrivateReservationController());

  StudantPrivateReservationsView({required this.privateSessionID});

  @override
  Widget build(BuildContext context) {
    reservationController.fetchPrivateReservations(privateSessionID);
    final List<dynamic> args = Get.arguments;
    final int? passedUserId = args[0];
    final int serviceId = args[1];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => Advanced_related_session_view(), arguments: [serviceId, passedUserId]);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        title: Text('Reservations'),
        backgroundColor: Color(0xFF292D3D),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          if (reservationController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (reservationController.reservations.isEmpty) {
            return Center(child: Text('No Reservations Found'));
          } else {
            return ListView.builder(
              itemCount: reservationController.reservations.length,
              itemBuilder: (context, index) {
                var reservation = reservationController.reservations[index];
                return IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: index.isEven ? Color(0xFFA5EAD1) : Color(0xffDEC5FF),
                        borderRadius: BorderRadius.circular(23.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0, left: 12, bottom: 12),
                        child: ListTile(
                          title: const Text(
                            'Group Member',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFF292D3D),
                              height: 1.2,
                            ),
                          ),
                          leading: Text(
                            '${reservation.id}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color(0xFF292D3D),
                              height: 1.2,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${reservation.groupMembers}'),
                              Text('Date: ${reservation.reservationDate}\nStart: ${reservation.reservationStartTime}\nEnd: ${reservation.reservationEndTime}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.swap_horiz),
                            onPressed: () {
                              reservationController.switchRole(reservation.id);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
