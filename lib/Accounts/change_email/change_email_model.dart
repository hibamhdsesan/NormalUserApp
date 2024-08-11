import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart';

class ChangeEmailModel {
  static Future<Map<String, dynamic>> changeEmail(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final response = await http.put(
      Uri.parse('$baseURL/api/updateEmail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',

      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    print('i am in');
    if (response.statusCode == 200) {
      print('200');
      return jsonDecode(response.body);
    } else {

      print(response.body);
      print(response.statusCode);
      throw Exception('Failed to Update');
    }
  }
}
