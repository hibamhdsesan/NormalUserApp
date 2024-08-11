import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';

class UserModel {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseURL/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    print('i am in');
    if (response.statusCode == 200) {
      print('200');
      final responseData = jsonDecode(response.body);
      final accessToken = responseData['access_token'];

      // حفظ الـ token في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken);
      print(accessToken);
      return responseData;

    } else {
      print(response.body);
      print(response.statusCode);
      throw Exception('Failed to login');
    }
  }
}
