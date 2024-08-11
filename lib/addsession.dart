import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'Advanceduser_related_session_view.dart';
import 'Advanceduser_session_view.dart';
import 'components/CustomElevatedButton.dart';
import 'controllers/ServiceController.dart';

class AddSessionView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  final int serviceId = Get.arguments ?? 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ServiceController serviceController = Get.find();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (pickedDate != null) {
        dateController.text = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Session Name',),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter session name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Session Description'),
                ),
                TextFormField(
                  controller: dateController,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter session date';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: startTimeController,
                  decoration: InputDecoration(
                    labelText: 'Session Start Time',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () {
                        _selectTime(context, startTimeController);
                      },
                    ),
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter session start time';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: endTimeController,
                  decoration: InputDecoration(
                    labelText: 'Session End Time',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () {
                        _selectTime(context, endTimeController);
                      },
                    ),
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter session end time';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      serviceController.createSession(
                        serviceId,
                        nameController.text,
                        descriptionController.text,
                        dateController.text,
                        startTimeController.text,
                        endTimeController.text,
                      ).then((_) {
                       // serviceController.fetchSessions(serviceId); // Fetch sessions after adding a new one
                        print(serviceId);
                        //Get.off(() => Advanced_related_session_view(), arguments: serviceId);
                        serviceController.fetch_general_Sessions(serviceId);
                        Get.off(() => Advanced_session_view(), arguments: serviceId);
                      });
                    }
                  }, color: Color(0xffB0E7D3), text: 'Add',

                ),
                SizedBox(height: 20,),
                Image(image: AssetImage('assets/images/doctors.png')),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
