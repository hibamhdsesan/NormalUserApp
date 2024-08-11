import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // استيراد SharedPreferences
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'globals.dart';

class MyActivitiesPage extends StatelessWidget {


  Future<List<dynamic>> fetchMyActivities() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final response = await http.get(
      Uri.parse('$baseURL/api/publicReservation/showMyActivities'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      print('done');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load activities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Activities'),
        backgroundColor: Color(0xFF292D3D),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchMyActivities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No activities found.'));
          } else {
            final activities = snapshot.data!;
            return ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return ListTile(
                  title: Text(activity['sessionName']),
                  subtitle: Text('${activity['serviceName']} - ${activity['sessionDate']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}