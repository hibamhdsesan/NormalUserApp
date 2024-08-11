import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testme/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyServiceAttendance extends StatelessWidget {
  final List<Color> colors = [
    Color(0XFFDFC0D7),
    Color(0XFFDDD9B4),
    Color(0XFFABD8AE),
  ];

  @override
  Widget build(BuildContext context) {
    final int serviceId = Get.arguments;
    final List<Map<String, dynamic>> sessionData = [];
    int attendanceCount = 0;
    int sessionCount = 0;
    double attendancePercentage = 0.0;

    Future<void> fetchAttendanceData() async {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      try {
        final response = await http.get(
          Uri.parse('$baseURL/api/attendance/showMyAttendanceOfOneService/$serviceId'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body) as Map<String, dynamic>;

          sessionData.clear();
          for (var item in data['attendanceData']) {
            sessionData.add({
              'sessionID': item['sessionID'],
              'sessionName': item['sessionName'],
            });
          }
          attendanceCount = data['attendanceCount'];
          sessionCount = data['sessionsCount'];
          attendancePercentage = data['attendancePercentage'].toDouble();

          // حفظ البيانات في الذاكرة المحلية
          await prefs.setString('attendanceData_$serviceId', json.encode({
            'attendanceData': sessionData,
            'attendanceCount': attendanceCount,
            'sessionsCount': sessionCount,
            'attendancePercentage': attendancePercentage,
          }));
        } else {
          Get.snackbar('Error', 'Request failed with status: ${response.statusCode}');

          // تحميل البيانات من الذاكرة المحلية
          String? storedData = prefs.getString('attendanceData_$serviceId');
          if (storedData != null) {
            Map<String, dynamic> localData = json.decode(storedData);
            sessionData.clear();
            for (var item in localData['attendanceData']) {
              sessionData.add({
                'sessionID': item['sessionID'],
                'sessionName': item['sessionName'],
              });
            }
            attendanceCount = localData['attendanceCount'];
            sessionCount = localData['sessionsCount'];
            attendancePercentage = localData['attendancePercentage'];
          }
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred while fetching data.');

        // تحميل البيانات من الذاكرة المحلية في حالة حدوث خطأ
        String? storedData = prefs.getString('attendanceData_$serviceId');
        if (storedData != null) {
          Map<String, dynamic> localData = json.decode(storedData);
          sessionData.clear();
          for (var item in localData['attendanceData']) {
            sessionData.add({
              'sessionID': item['sessionID'],
              'sessionName': item['sessionName'],
            });
          }
          attendanceCount = localData['attendanceCount'];
          sessionCount = localData['sessionsCount'];
          attendancePercentage = localData['attendancePercentage'];
        }
      }
    }

    return Scaffold(
      backgroundColor: Color(0xffA6A0AE),
      appBar: AppBar(
        title: Text('Attendance'),
        backgroundColor: Color(0xFF292D3D),
      ),
      body: FutureBuilder(
        future: fetchAttendanceData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (sessionData.isEmpty) {
            return Center(
              child: Text(
                'No Attendance Found.',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            );
          } else {
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 20,
                  child: Image(
                    width: 200,
                    height: 200,
                    image: AssetImage('assets/images/girl.png'),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 240),
                    CircularPercentIndicator(
                      radius: 100.0,
                      lineWidth: 10.0,
                      percent: attendancePercentage / 100,
                      center: Text("${attendancePercentage.toStringAsFixed(2)}%"),
                      progressColor: Color(0XFFDFC0D7),
                    ),
                    Text('Attendance: $attendanceCount / $sessionCount'),
                    Expanded(
                      child: ListView.builder(
                        itemCount: sessionData.length,
                        itemBuilder: (context, index) {
                          final color = colors[index % colors.length];
                          final session = sessionData[index];

                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          color: Color(0xFF292D3D),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(session['sessionName']),
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
