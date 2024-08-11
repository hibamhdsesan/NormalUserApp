import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../globals.dart';
import '../model/Session_model.dart';


class SessionController extends GetxController {
  var theoreticalSessions = <Session>[].obs;
  var practicalSessions = <Session>[].obs;
  var sessions = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchTheoreticalSessions();
    fetchPracticalSessions();
    super.onInit();
  }

  Future<void> fetchTheoreticalSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading(true);
    try {
      final response = await http.get(Uri.parse('$baseURL/api/session/showActiveTheoretical'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        print('done');
        print(response.body);
        List<dynamic> data = json.decode(response.body);
        sessions.value = data.map((session) => Session.fromJson(session)).toList();
      } else {
        print(response.body);
        Get.snackbar('Error', 'Failed to fetch sessions');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch sessions');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPracticalSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading(true);
    try {
      final response = await http.get(Uri.parse('$baseURL/api/session/showActivePractical'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        List jsonResponse = json.decode(response.body);
        practicalSessions.value = jsonResponse.map((session) => Session.fromJson(session)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch practical sessions');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

}
