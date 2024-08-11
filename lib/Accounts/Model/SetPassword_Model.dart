
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals.dart';

class CreatePassModel {
  static Future<Map<String, dynamic>> createPassword(String password) async{
    // استرجاع التوكن من SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    print('setnew$accessToken');

    final response = await http.post(
      Uri.parse('$baseURL/api/setNewPassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(<String, String>{
        'password': password,
      }),
    );
    print('i am in');
    print('setnew$accessToken');
    print(response.body);
    if (response.statusCode == 200) {
      print('200 setnew');
      final responseData = jsonDecode(response.body);
      return responseData;
      //return jsonDecode(response.body);

    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }
}
