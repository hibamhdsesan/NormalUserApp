import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../globals.dart';

class CompleteAccountModel {
  static Future<Map<String, dynamic>> complete(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseURL/api/setEmail'),
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
      return jsonDecode(response.body);
    } else {
      print(response.body);
      print(response.statusCode);
      throw Exception('Failed to login');
    }
  }
}
