// create_password_model.dart

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals.dart';

class SkillsModel {
  static Future<Map<String, dynamic>> skills(String skills) async {
    // استرجاع التوكن من SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final response = await http.put(
      Uri.parse('$baseURL/api/normalUser/completeAccount4'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken', // استخدام التوكن المسترجع
      },
      body: jsonEncode(<String, String>{
        'skills': skills,
      }),
    );
    print('skillstoken$accessToken');
    print('i am in');
    print(response.body);
    if (response.statusCode == 200) {

      print('200 skills');

      return jsonDecode(response.body);

    } else {
      throw Exception('Failed');
    }
  }
}
