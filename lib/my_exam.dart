import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'controllers/ServiceController.dart';
import 'globals.dart';
import 'model/public_session.dart';

class MyExamsPage extends StatelessWidget {

  Future<List<dynamic>> fetchMyExams() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final response = await http.get(
      Uri.parse('$baseURL/api/publicReservation/showMyExams'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      print('done');
      return jsonDecode(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to load exams');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Exams'),
        backgroundColor: Color(0xFF292D3D),      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchMyExams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No exams found.'));
          } else {
            final exams = snapshot.data!;
            return ListView.builder(
              itemCount: exams.length,
              itemBuilder: (context, index) {
                final exam = exams[index];
                return ListTile(
                  title: Text(exam['sessionName']),
                  subtitle: Text('${exam['serviceName']} - ${exam['sessionDate']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}