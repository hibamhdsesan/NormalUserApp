// create_password_model.dart

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart';

// class CreatePassModel {
//   static Future<Map<String, dynamic>> createPassword(String password) async {
//     final response = await http.post(
//       Uri.parse('$baseURL/api/normalUser/completeAccount1'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'password': password,
//       }),
//     );
//     print('i am in');
//     print(response.body);
//     if (response.statusCode == 200) {
//       print('200');
//       return jsonDecode(response.body);
//
//     } else {
//       print(response.body);
//       throw Exception('Failed');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreatePassModel {
  static Future<Map<String, dynamic>> createPassword(String password) async {
    final response = await http.put(
      Uri.parse('$baseURL/api/normalUser/completeAccount1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final accessToken = responseData['access_token'];

      // حفظ الـ token في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken);
      print(accessToken);
      return responseData;
    } else {
      print(response.statusCode);
      throw Exception('Failed');
    }
  }
}
