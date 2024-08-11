import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'components/CustomElevatedButton.dart';
import 'controllers/ServiceController.dart';
import 'globals.dart';
import 'model/session2_model.dart';

class EditSessionView extends StatelessWidget {
  final int sessionId;
  final String initialSessionName;
  final String initialSessionDescription;
  final String initialSessionDate;
  final String initialSessionStartTime;
  final String initialSessionEndTime;

  EditSessionView({
    required this.sessionId,
    required this.initialSessionName,
    required this.initialSessionDescription,
    required this.initialSessionDate,
    required this.initialSessionStartTime,
    required this.initialSessionEndTime,
  });

  final TextEditingController sessionNameController = TextEditingController();
  final TextEditingController sessionDescriptionController = TextEditingController();
  final TextEditingController sessionDateController = TextEditingController();
  final TextEditingController sessionStartTimeController = TextEditingController();
  final TextEditingController sessionEndTimeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    sessionNameController.text = initialSessionName;
    sessionDescriptionController.text = initialSessionDescription;
    sessionDateController.text = initialSessionDate;
    sessionStartTimeController.text = initialSessionStartTime;
    sessionEndTimeController.text = initialSessionEndTime;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Session'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: sessionNameController,
                    decoration: InputDecoration(labelText: 'Session Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter session name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: sessionDescriptionController,
                    decoration: InputDecoration(labelText: 'Session Description'),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      final newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 5),
                        lastDate: DateTime(DateTime.now().year + 5),
                      );
                      if (newDate != null) {
                        sessionDateController.text = '${newDate.year}-${newDate.month.toString().padLeft(2, '0')}-${newDate.day.toString().padLeft(2, '0')}';
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: sessionDateController,
                        decoration: InputDecoration(labelText: 'Session Date'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter session date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      final newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (newTime != null) {
                        final formattedTime = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
                        sessionStartTimeController.text = formattedTime;
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: sessionStartTimeController,
                        decoration: InputDecoration(labelText: 'Session Start Time'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter session start time';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      final newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (newTime != null) {
                        final formattedTime = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
                        sessionEndTimeController.text = formattedTime;
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: sessionEndTimeController,
                        decoration: InputDecoration(labelText: 'Session End Time'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter session end time';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await updateSession();
                        Get.back();
                      }
                    },
                    color: Color(0xffB0E7D3), text: 'Update Session',

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateSession() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final url = '$baseURL/api/session/update/$sessionId';
    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode({
        'sessionName': sessionNameController.text,
        'sessionDescription': sessionDescriptionController.text,
        'sessionDate': sessionDateController.text,
        'sessionStartTime': sessionStartTimeController.text,
        'sessionEndTime': sessionEndTimeController.text,
      }),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final updatedSession = Session.fromJson(json.decode(response.body));
      final serviceController = Get.find<ServiceController>();
      serviceController.updateSession(updatedSession);
    } else {
      Get.snackbar('Error', 'Failed to edit sessions');
      print(response.body);
      print(response.statusCode);
      print('Failed to update session');
    }
  }
}
