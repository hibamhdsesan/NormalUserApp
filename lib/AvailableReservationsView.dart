import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AdvancedPrivateReservationsView.dart';
import 'StudantPrivateReservationsView.dart';
import 'controllers/PrivateReservationController.dart';
import 'show_my_private_student_view.dart';
import 'student_related_session_view.dart';

class AvailableReservationsView extends StatelessWidget {
  final int privateSessionID;
  final PrivateReservationController fakeReservationController = Get.put(PrivateReservationController());

  AvailableReservationsView({required this.privateSessionID});

  @override
  Widget build(BuildContext context) {
    fakeReservationController.fetchFakeReservations(privateSessionID);
    final List<dynamic> args = Get.arguments;
    final int? passedUserId = args[0];
    final int serviceId = args[1];

    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(onPressed: (){Get.to(()=> student_related_session_view(), arguments: [serviceId, passedUserId]);}, icon: Icon(Icons.arrow_back_outlined)) ,
        title: Text('Available Reservations'),
        backgroundColor: Color(0xFF292D3D),
        actions: [
          IconButton(onPressed: (){Get.to(()=> show_my_private_student_view(privateSessionID: privateSessionID,),arguments: [serviceId, passedUserId]);}, icon: Icon(Icons.calendar_month_rounded)),
          IconButton(onPressed: (){Get.to(()=> StudantPrivateReservationsView(privateSessionID: privateSessionID), arguments: [serviceId, passedUserId]);}, icon: Icon(Icons.groups_outlined))
        ],

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
          } else if (fakeReservationController.fakeReservations.isEmpty) {
            return Center(child: Text('No Available Reservations'));
          } else {
            return ListView.builder(
              itemCount: fakeReservationController.fakeReservations.length,
              itemBuilder: (context, index) {
                var reservation = fakeReservationController.fakeReservations[index];
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
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${reservation.id}\nStart: ${reservation.reservationStartTime} - End: ${reservation.reservationEndTime}'),
                      ),
                      //subtitle: Text('${reservation.id}:'),
                      trailing:Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check_box_outline_blank_rounded),
                            onPressed: () {
                              fakeReservationController.bookReservation(reservation.id,privateSessionID);
                            },
                          ),
                          // IconButton(
                          //   icon: Icon(Icons.delete_outline),
                          //   onPressed: () {
                          //     fakeReservationController.deleteReservation(reservation.id,privateSessionID);
                          //   },
                          // ),
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
