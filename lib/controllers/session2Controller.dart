import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../globals.dart';
import '../model/session2_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/session2_model.dart';
class Session2Controller extends GetxController {

  var sessions = [].obs;
  var isLoading = false.obs;

  @override



  void fetchSessions(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.105:8000/api/session/showAllRelated/$userId'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        sessions.value = data.map((session) => Session.fromJson(session)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch sessions');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch sessions');
    } finally {
      isLoading.value = false;
    }
  }

Future<void> deleteSession(int sessionId) async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');
  isLoading.value = true;
  try {
    final response = await http.delete(
      Uri.parse('http://192.168.1.105:8000/api/session/cancel/$sessionId'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      //fetchSessions(); // Refresh the session list after delete
      Get.snackbar('Success', 'Session deleted successfully');
    } else {
      print(response.body);
      print(response.statusCode);
      Get.snackbar('Error', 'Failed to delete session');
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to delete session');
  } finally {
    isLoading.value = false;
  }
}
  Future<void> createSession(int serviceId, String sessionName, String sessionDescription, String sessionDate, String sessionStartTime, String sessionEndTime) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.post(
        Uri.parse('$baseURL/api/session/create/$serviceId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'sessionName': sessionName,
          'sessionDescription': sessionDescription,
          'sessionDate': sessionDate,
          'sessionStartTime': sessionStartTime,
          'sessionEndTime': sessionEndTime,
        }),
      );
      print('i am in');
      print(serviceId);
      if (response.statusCode == 200) {
        print('200 add');
        var newSession = jsonDecode(response.body);
        sessions.add(newSession);  // Add the new session to the local list
        Get.snackbar('Success', 'Session created successfully');
      } else {
        print(response.body);
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to create session');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while creating session');
    }
  }
}

//import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tired/globals.dart';
// import 'dart:convert';
//
// import '../model/session2_model.dart';
//
// class Session2Controller extends GetxController {
//   var sessions = [].obs;
//   var isLoading = false.obs;
//
//   @override
//   void fetchSessions(int userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     final accessToken = prefs.getString('accessToken');
//     isLoading.value = true;
//     try {
//       final response = await http.get(
//         Uri.parse('http://192.168.1.105:8000/api/session/showAllRelated/$userId'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $accessToken',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         sessions.value = data.map((session) => Session.fromJson(session)).toList();
//       } else {
//         print(response.body);
//         Get.snackbar('Error', 'Failed to fetch sessions');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch sessions');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> createSession(int serviceId, String sessionName, String sessionDescription, String sessionDate, String sessionStartTime, String sessionEndTime) async {
//     final prefs = await SharedPreferences.getInstance();
//     final accessToken = prefs.getString('accessToken');
//     try {
//       final response = await http.post(
//         Uri.parse('http://192.168.1.105:8000/api/session/create/$serviceId'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $accessToken',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(<String, String>{
//           'sessionName': sessionName,
//           'sessionDescription': sessionDescription,
//           'sessionDate': sessionDate,
//           'sessionStartTime': sessionStartTime,
//           'sessionEndTime': sessionEndTime,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         fetchSessions(serviceId);
//         Get.snackbar('Success', 'Session created successfully');
//       } else {
//         Get.snackbar('Error', 'Failed to create session');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to create session');
//     }
//   }
//
//   Future<void> updateSession(int sessionId, String sessionDate, String sessionStartTime, String sessionEndTime) async {
//     final prefs = await SharedPreferences.getInstance();
//     final accessToken = prefs.getString('accessToken');
//     try {
//       final response = await http.put(
//         Uri.parse('http://192.168.1.105:8000/api/session/update/$sessionId'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $accessToken',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(<String, String>{
//           'sessionDate': sessionDate,
//           'sessionStartTime': sessionStartTime,
//           'sessionEndTime': sessionEndTime,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         fetchSessions(sessionId);
//         Get.snackbar('Success', 'Session updated successfully');
//       } else {
//         Get.snackbar('Error', 'Failed to update session');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update session');
//     }
//   }
//
//   Future<void> deleteSession(int sessionId, int userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     final accessToken = prefs.getString('accessToken');
//     try {
//       final response = await http.delete(
//         Uri.parse('http://192.168.1.105:8000/api/session/cancel/$sessionId'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $accessToken',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         fetchSessions(userId);
//         Get.snackbar('Success', 'Session deleted successfully');
//       } else {
//         Get.snackbar('Error', 'Failed to delete session');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to delete session');
//     }
//   }
// }
//Future<void> deleteSession(int sessionId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final accessToken = prefs.getString('accessToken');
  //   isLoading.value = true;
  //   try {
  //     final response = await http.delete(
  //       Uri.parse('http://192.168.1.105:8000/api/session/cancel/$sessionId'),
  //       headers: <String, String>{
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       //fetchSessions(); // Refresh the session list after delete
  //       Get.snackbar('Success', 'Session deleted successfully');
  //     } else {
  //       print(response.body);
  //       print(response.statusCode);
  //       Get.snackbar('Error', 'Failed to delete session');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to delete session');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }