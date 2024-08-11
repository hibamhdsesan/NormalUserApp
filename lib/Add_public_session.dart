// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'Advanceduser_related_session_view.dart';
// import 'controllers/ServiceController.dart';
//
// class Add_private_SessionView extends StatelessWidget {
//   final TextEditingController sessionNameController = TextEditingController();
//   final TextEditingController sessionDescriptionController = TextEditingController();
//   final TextEditingController sessionDateController = TextEditingController();
//   final TextEditingController sessionStartTimeController = TextEditingController();
//   final TextEditingController sessionEndTimeController = TextEditingController();
//   final TextEditingController durationForEachReservationController = TextEditingController();
//   final ServiceController serviceController = Get.find<ServiceController>();
//
//   @override
//   Widget build(BuildContext context) {
//     // Check Get.arguments type
//     if (Get.arguments == null || Get.arguments is! List<dynamic> || Get.arguments.length < 2) {
//       return Scaffold(
//         body: Center(
//           child: Text('Invalid arguments passed.'),
//         ),
//       );
//     }
//     final List<dynamic> args = Get.arguments;
//     final int serviceId = args[0];
//     final int userId = args[1];
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Session'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: sessionNameController,
//               decoration: InputDecoration(labelText: 'Session Name'),
//             ),
//             TextField(
//               controller: sessionDescriptionController,
//               decoration: InputDecoration(labelText: 'Session Description'),
//             ),
//             TextField(
//               controller: sessionDateController,
//               decoration: InputDecoration(labelText: 'Session Date'),
//             ),
//             TextField(
//               controller: sessionStartTimeController,
//               decoration: InputDecoration(labelText: 'Session Start Time'),
//             ),
//             TextField(
//               controller: sessionEndTimeController,
//               decoration: InputDecoration(labelText: 'Session End Time'),
//             ),
//             TextField(
//               controller: durationForEachReservationController,
//               decoration: InputDecoration(labelText: 'Duration For Each Reservation'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 serviceController.createPrivateSession(
//                   serviceId,
//                   userId,
//                   sessionNameController.text,
//                   sessionDescriptionController.text,
//                   sessionDateController.text,
//                   sessionStartTimeController.text,
//                   sessionEndTimeController.text,
//                   durationForEachReservationController.text,
//                 ).then((_) {
//                   Get.back(); // إغلاق هذه الواجهة
//                   Get.to(() => Advanced_related_session_view(), arguments: [serviceId,userId ]); // إعادة التوجيه
//                 });
//               },
//
//               child: Text('Add Session'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Advanced_public_session.dart';
import 'Advanceduser_related_session_view.dart';
import 'components/CustomElevatedButton.dart';
import 'controllers/ServiceController.dart';

class Add_public_SessionView extends StatelessWidget {
  final TextEditingController sessionNameController = TextEditingController();
  final TextEditingController sessionDescriptionController = TextEditingController();
  final TextEditingController sessionDateController = TextEditingController();
  final TextEditingController sessionStartTimeController = TextEditingController();
  final TextEditingController sessionEndTimeController = TextEditingController();
  final TextEditingController maximumNumberOfReservationsController = TextEditingController();
  final ServiceController serviceController = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {


    final int serviceId = Get.arguments;

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );
      if (pickedDate != null) {
        sessionDateController.text = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
      }
    }

    Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final String formattedTime = '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
        controller.text = formattedTime;
      }
    }

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        title: Text('Add Session'),
        backgroundColor: Color(0xFF292D3D),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: sessionNameController,
                decoration: InputDecoration(labelText: 'Session Name'),
              ),
              TextField(
                controller: sessionDescriptionController,
                decoration: InputDecoration(labelText: 'Session Description'),
              ),
              TextField(
                controller: sessionDateController,
                decoration: InputDecoration(
                  labelText: 'Session Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ),
                readOnly: true,
              ),
              TextField(
                controller: sessionStartTimeController,
                decoration: InputDecoration(
                  labelText: 'Session Start Time',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () {
                      _selectTime(context, sessionStartTimeController);
                    },
                  ),
                ),
                readOnly: true,
              ),
              TextField(
                controller: sessionEndTimeController,
                decoration: InputDecoration(
                  labelText: 'Session End Time',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () {
                      _selectTime(context, sessionEndTimeController);
                    },
                  ),
                ),
                readOnly: true,
              ),
              TextField(
                controller: maximumNumberOfReservationsController,
                decoration: InputDecoration(labelText: 'Maximum Number Of Reservations'),
              ),
              SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () {
                  serviceController.createPublicSession(
                    serviceId,
                    sessionNameController.text,
                    sessionDescriptionController.text,
                    sessionDateController.text,
                    sessionStartTimeController.text,
                    sessionEndTimeController.text,
                    maximumNumberOfReservationsController.text,
                  ).then((_) {

                    Get.back(); // إغلاق هذه الواجهة
                    // serviceController.fetchPrivateSessions(userId,serviceId);
                    Get.to(() => Advanced_public_session_view(), arguments: serviceId); // إعادة التوجيه
                    serviceController.fetchPublicSessions(serviceId);
                    print(serviceId);
                    print('service+${serviceId}');

                  });
                },
                color: Color(0xffB0E7D3),
                text: 'Add Session',

              ),
              const SizedBox(height: 20,),
              const Image(image: AssetImage('assets/images/doctors.png')),

            ],
          ),
        ),
      ),
    );
  }
}