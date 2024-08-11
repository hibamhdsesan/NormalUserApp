import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testme/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ServiceAttendance extends StatelessWidget {
  final List<Color> colors = [
    Color(0XFFDFC0D7),
    Color(0XFFDDD9B4),
    Color(0XFFABD8AE),
  ];

  @override
  Widget build(BuildContext context) {
    final int serviceId = Get.arguments;
    final List<Map<String, dynamic>> userAttendanceData = [];

    Future<void> fetchAttendanceData() async {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      try {
        final response = await http.get(
          Uri.parse('$baseURL/api/attendance/showAttendanceOfOneService/$serviceId'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        );

        print(serviceId);
        if (response.statusCode == 200) {
          print("attendance");
          final data = json.decode(response.body) as List<dynamic>;

          userAttendanceData.clear();
          for (var item in data) {
            final Map<String, dynamic> attendance = item as Map<String, dynamic>;
            final normalUserName = attendance['normalUserName'] as String;
            final attendanceCount = attendance['attendanceCount'] as int;
            final sessionsCount = attendance['sessionsCount'] as int;
            final attendancePercentage = double.tryParse(attendance['attendancePercentage'].toString()) ?? 0.0;

            userAttendanceData.add({
              'name': normalUserName,
              'attendanceCount': attendanceCount,
              'sessionsCount': sessionsCount,
              'percentage': attendancePercentage,
            });
          }

          // حفظ البيانات في الذاكرة المحلية
          await prefs.setString('attendanceData_$serviceId', json.encode(userAttendanceData));
        } else {
          print(response.statusCode);
          print(response.body);
          print("bla bla");
          Get.snackbar('Error', 'Request failed with status: ${response.statusCode}');

          // تحميل البيانات من الذاكرة المحلية
          String? storedData = prefs.getString('attendanceData_$serviceId');
          if (storedData != null) {
            List<dynamic> localData = json.decode(storedData);
            userAttendanceData.clear();
            for (var user in localData) {
              userAttendanceData.add({
                'name': user['name'],
                'attendanceCount': user['attendanceCount'],
                'sessionsCount': user['sessionsCount'],
                'percentage': user['percentage'],
              });
            }
          }
        }
      } catch (e) {
        print("Exception occurred: $e");
        Get.snackbar('Error', 'An error occurred while fetching data.');

        // تحميل البيانات من الذاكرة المحلية في حالة حدوث خطأ
        String? storedData = prefs.getString('attendanceData_$serviceId');
        if (storedData != null) {
          List<dynamic> localData = json.decode(storedData);
          userAttendanceData.clear();
          for (var user in localData) {
            userAttendanceData.add({
              'name': user['name'],
              'attendanceCount': user['attendanceCount'],
              'sessionsCount': user['sessionsCount'],
              'percentage': user['percentage'],
            });
          }
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
          } else if (userAttendanceData.isEmpty) {
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: userAttendanceData.length,
                        itemBuilder: (context, index) {
                          final color = colors[index % colors.length];
                          final user = userAttendanceData[index];
                          final percentage = user['percentage'] as double;

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
                                  title: Text(user['name']),
                                  subtitle: Text('Attendance: ${user['attendanceCount']} / ${user['sessionsCount']}'),
                                  trailing: CircularPercentIndicator(
                                    radius: 28.0, // تعديل حجم الدائرة هنا
                                    lineWidth: 3.0,
                                    percent: percentage / 100,
                                    center: Text("${percentage.toStringAsFixed(2)}%"),
                                    progressColor: Color(0XFFDFC0D7), // تعديل لون الدائرة هنا
                                  ),
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
