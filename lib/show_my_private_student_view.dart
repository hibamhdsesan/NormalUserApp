import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AvailableReservationsView.dart';
import 'controllers/PrivateReservationController.dart';
import 'student_related_session_view.dart';

class show_my_private_student_view extends StatelessWidget {
  final int privateSessionID;
  final PrivateReservationController fakeReservationController = Get.put(PrivateReservationController());

  show_my_private_student_view({required this.privateSessionID});

  @override
  Widget build(BuildContext context) {
    fakeReservationController.fetchFakeReservations(privateSessionID);
    final List<dynamic> args = Get.arguments;
    final int? passedUserId = args[0];
    final int serviceId = args[1];
    fakeReservationController.fetchMyReservations();
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(onPressed: (){Get.to(()=> AvailableReservationsView(privateSessionID: privateSessionID,), arguments: [serviceId, passedUserId]);}, icon: Icon(Icons.arrow_back_outlined)) ,
        title: Text('My Reservations'),
        backgroundColor: Color(0xFF292D3D),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          if (fakeReservationController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (fakeReservationController.myReservations.isEmpty) {
            return Center(child: Text('No Reservations'));
          } else {
            return ListView.builder(
              itemCount: fakeReservationController.myReservations.length,
              itemBuilder: (context, index) {
                var reservation = fakeReservationController.myReservations[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: Container(
                    width: 50,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Color(0xFFDBC6FC),
                    ),
                    child: ListTile(
                      title: Text('${reservation.serviceName}\nDate: ${reservation.reservationDate}'),
                      subtitle: Text('Start: ${reservation.reservationStartTime} - End: ${reservation.reservationEndTime}'),
                      trailing:Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // IconButton(
                          //   icon: Icon(Icons.check_box_outline_blank_rounded),
                          //   onPressed: () {
                          //     fakeReservationController.bookReservation(reservation.id,privateSessionID);
                          //   },
                          // ),
                          IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {
                              fakeReservationController.deleteReservation(reservation.reservationID,privateSessionID);
                            },
                          ),
                        ],
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
