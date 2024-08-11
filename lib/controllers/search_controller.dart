import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../globals.dart';
import '../model/service_model.dart';

class SearchController extends GetxController{
  var searchResults = <Service>[].obs;
  var isLoading = true.obs;

  Future<void> searchServices(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('$baseURL/api/service/searchForAdvancedUser?serviceName=$query'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List;
        searchResults.value = jsonData.map((json) => Service.fromJson(json)).toList();
      } else {
        print(response.body);
      }
    } finally {
      isLoading(false);
    }
  }
}