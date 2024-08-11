import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';

class UserNamesView extends StatelessWidget {
  final int sessionId;

  UserNamesView({required this.sessionId});

  final List<Color> colors = [
    Color(0XFFDFC0D7),
    Color(0XFFDDD9B4),
    Color(0XFFABD8AE),
  ]; // قائمة الألوان المتنوعة

  Future<List<String>> fetchUserNames() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      throw Exception('Access token is not set');
    }

    final response = await http.get(
      Uri.parse('$baseURL/api/attendance/showAttendanceOfOneSession/$sessionId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      return responseBody.map((record) => record['normalUserName'] as String).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load user names');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffA6A0AE),
      appBar: AppBar(
        title: Text('Attendance'),
        backgroundColor: Color(0xFF292D3D),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchUserNames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Attendance Found.',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            );
          } else {
            final List<String> userNames = snapshot.data!;
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
                        itemCount: userNames.length,
                        itemBuilder: (context, index) {
                          final color = colors[index % colors.length]; // اختيار اللون بناءً على التسلسل
                          return Column(
                            children: [
                              ListTile(
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
                                title: Text(userNames[index]),
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
