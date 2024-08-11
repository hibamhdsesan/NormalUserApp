import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals.dart';

class QuestionModel {
  // Example method to send data to the backend
  static Future<bool> submitData(Map<String, dynamic> data) async {
    try {
      // Print the baseURL for debugging
      print("Base URL: $baseURL");

      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      if (token == null) {
        print("No auth token found");
        return false;
      }

      final response = await http.put(
        Uri.parse('$baseURL/api/normalUser/completeAccount2'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',  // Adding the token here
        },
        body: jsonEncode(data),
      );

      // Log the request URL
      print("Request URL: $baseURL/api/normalUser/completeAccount2");

      if (response.statusCode == 200) {
        print("Request succeeded with status code 200");
        return true;
      } else if (response.statusCode == 302) {
        // Log the new location
        print("Request was redirected to: ${response.headers['location']}");

        // Optionally follow the redirect with the same token
        final newResponse = await http.get(
          Uri.parse(response.headers['location']!),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',  // Adding the token here as well
          },
        );

        if (newResponse.statusCode == 200) {
          print("Redirected request succeeded with status code 200");
          return true;
        } else {
          print("Redirected request failed with status code: ${newResponse.statusCode}");
          print("Response body: ${newResponse.body}");
          return false;
        }
      } else {
        // Log detailed information about the failure
        print("Request failed with status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return false;
      }
    } catch (e) {
      // Log any exceptions that occur
      print("Exception caught in submitData: $e");
      return false;
    }
  }
}
