import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Advanceduser_related_session_view.dart';
import 'components/CustomElevatedButton.dart';
import 'controllers/ServiceController.dart';

class EditPrivateSessionView extends StatelessWidget {
  final int sessionId;
  final TextEditingController sessionNameController = TextEditingController();
  final TextEditingController sessionDescriptionController = TextEditingController();
  final TextEditingController sessionDateController = TextEditingController();
  final TextEditingController sessionStartTimeController = TextEditingController();
  final TextEditingController sessionEndTimeController = TextEditingController();
  final TextEditingController durationForEachReservationController = TextEditingController();
  final ServiceController serviceController = Get.find<ServiceController>();

  EditPrivateSessionView({
    required this.sessionId,
    required String initialSessionName,
    required String initialSessionDescription,
    required String initialSessionDate,
    required String initialSessionStartTime,
    required String initialSessionEndTime,
    required String initialDurationForEachReservation,
  }) {
    sessionNameController.text = initialSessionName;
    sessionDescriptionController.text = initialSessionDescription;
    sessionDateController.text = initialSessionDate;
    sessionStartTimeController.text = initialSessionStartTime;
    sessionEndTimeController.text = initialSessionEndTime;
    durationForEachReservationController.text = initialDurationForEachReservation;
  }

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

  @override
  Widget build(BuildContext context) {
    if (Get.arguments == null || Get.arguments is! List<dynamic> || Get.arguments.length < 2) {
      return Scaffold(
        body: Center(
          child: Text('Invalid arguments passed.'),
        ),
      );
    }
    final List<dynamic> args = Get.arguments;
    final int userId = args[0];
    final int serviceId = args[1];
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        title: Text('Edit Session'),
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
                controller: durationForEachReservationController,
                decoration: InputDecoration(labelText: 'Duration For Each Reservation'),
              ),
              SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () {
                  serviceController.EditPrivateSession(
                    sessionId,
                    sessionNameController.text,
                    sessionDescriptionController.text,
                    sessionDateController.text,
                    sessionStartTimeController.text,
                    sessionEndTimeController.text,
                    durationForEachReservationController.text,
                  ).then((_) {
                    Get.back(); // إغلاق هذه الواجهة
                    Get.to(() => Advanced_related_session_view(), arguments: [serviceId, userId]); // إعادة التوجيه
                    serviceController.fetchPrivateSessions(serviceId, userId);
                  });
                },
                color: Color(0xffB0E7D3),
                text: 'Update Session',
              ),
              const SizedBox(height: 20),
              const Image(image: AssetImage('assets/images/doctors.png')),
            ],
          ),
        ),
      ),
    );
  }
}
