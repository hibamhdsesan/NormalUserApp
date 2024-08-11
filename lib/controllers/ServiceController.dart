import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../globals.dart';
import '../model/private_session.dart';
import '../model/public_session.dart';
import '../model/service_model.dart';
import '../model/session2_model.dart';

class ServiceController extends GetxController {
  var services = [].obs;
  var isLoading = true.obs;
  var advancedUsers = [].obs;
  var searchResults = <Service>[].obs;
  var sessions = [].obs;
  var privateSessions= [].obs;



  /*Future<void> searchServices(String query) async {
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
  }*/
  void fetchAdvancedUsers(int serviceId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('$baseURL/api/service/showAdvancedUsersOfService/$serviceId'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        print('200 advanced');
        var jsonData = jsonDecode(response.body);
        advancedUsers.value = jsonData;
      } else {
        print(response.body);
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchServices(String type) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('$baseURL/api/service/showByType/$type'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(type);
      print('i am in');
      if (response.statusCode == 200) {
        print('200');
        var jsonData = jsonDecode(response.body);
        services.value = jsonData;
      }else{
        print(response.body);
      }
    } finally {
      isLoading(false);
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
  Future<void> createPrivateSession(int serviceId,int userId, String sessionName, String sessionDescription, String sessionDate, String sessionStartTime, String sessionEndTime, String durationForEachReservation) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.post(
        Uri.parse('$baseURL/api/privateSession/create/$serviceId'),
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
          'durationForEachReservation': durationForEachReservation,
        }),
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Private session created successfully');
        // تحديث قائمة الجلسات الخاصة بعد الإنشاء

        //print(serviceId);
       // print(userId);
      } else {
        Get.snackbar('Error', 'Failed to create private session');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while creating private session');
    }
  }
  Future<void> createPublicSession(int serviceId, String sessionName, String sessionDescription, String sessionDate, String sessionStartTime, String sessionEndTime, String maximumNumberOfReservations) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.post(
        Uri.parse('$baseURL/api/publicSession/create/$serviceId'),
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
          'MaximumNumberOfReservations': maximumNumberOfReservations,
        }),
      );
      print('i am in');
      if (response.statusCode == 200) {
        print('public');
        Get.snackbar('Success', 'Public session created successfully');
        // تحديث قائمة الجلسات الخاصة بعد الإنشاء

        print(serviceId);
        // print(userId);
      } else {
        print(response.body);
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to create public session');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while creating public session');
    }
  }
  // void fetchPrivateSessions(int serviceId, int userId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final accessToken = prefs.getString('accessToken');
  //   isLoading.value = true;
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseURL/api/privateSession/showAdvancedUsersInterviews/$serviceId/$userId'),
  //       headers: <String, String>{
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );
  //     print(serviceId);
  //     print(userId);
  //     if (response.statusCode == 200) {
  //       print('thanks god');
  //        print(response.body);
  //        print(response.statusCode);
  //       List<dynamic> data = json.decode(response.body);
  //       privateSessions.value = data.map((session) => PrivateSession.fromJson(session)).toList();
  //     } else {
  //       Get.snackbar('Error', 'Failed to fetch private sessions');
  //     }
  //   } catch (e) {
  //     print(e);
  //     print('catch');
  //     Get.snackbar('Error', 'Failed to fetch private sessions');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  Future<void> fetchPrivateSessions(int serviceId, int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('$baseURL/api/privateSession/showAdvancedUsersInterviews/$serviceId/$userId'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(serviceId);
      print(userId);
      if (response.statusCode == 200) {
        print('thanks god');
        print(response.body);
        print(response.statusCode);
        List<dynamic> data = json.decode(response.body);
        privateSessions.value = data.map((session) => PrivateSession.fromJson(session)).toList();
        print('Private sessions loaded: ${privateSessions.map((s) => s.id).toList()}');
      } else {
        Get.snackbar('Error', 'Failed to fetch private sessions');
      }
    } catch (e) {
      print(e);
      print('catch');
      Get.snackbar('Error', 'Failed to fetch private sessions');
    } finally {
      isLoading.value = false;
    }
  }


  void fetch_general_Sessions(int serviceId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('$baseURL/api/session/showAll/$serviceId'),
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

  void updateSession(Session updatedSession) {
    int index = sessions.indexWhere((session) =>
    session.id == updatedSession.id);
    try {
      if (index != -1) {
        sessions[index] = updatedSession;
      } else {
        Get.snackbar('Error', 'Failed to edit sessions');
      }
    } catch (e) {
      print(e);
    }
  }
  // void updatePrivateSession(PrivateSession updatedSession) {
  //   int index = privateSessions.indexWhere((session) =>
  //   session.id == updatedSession.id);
  //   try {
  //     if (index != -1) {
  //       privateSessions[index] = updatedSession;
  //     } else {
  //       Get.snackbar('Error', 'Failed to edit private sessions');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  void updatePrivateSession(PrivateSession updatedSession) {
    int index = privateSessions.indexWhere((session) => session.id == updatedSession.id);

    print('Trying to update session with ID: ${updatedSession.id}');
    print('Current sessions IDs: ${privateSessions.map((s) => s.id).toList()}');

    // طباعة البيانات قبل التحديث
    print('Private sessions before update: ${privateSessions.map((s) => s.toJson()).toList()}');


    try {
      if (index != -1) {
        privateSessions[index] = updatedSession;
        print('Session updated successfully');
      } else {
        print('Error: Session with ID ${updatedSession.id} not found in the list');
        Get.snackbar('Error', 'Failed to edit private sessions');
      }
    } catch (e) {
      print(e);
    }
    // طباعة البيانات بعد التحديث
    print('Private sessions after update: ${privateSessions.map((s) => s.toJson()).toList()}');
  }

  Future<void> EditPrivateSession(int sessionId, String sessionName, String sessionDescription, String sessionDate, String sessionStartTime, String sessionEndTime, String durationForEachReservation) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.put(
        Uri.parse('$baseURL/api/privateSession/update/$sessionId'),
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
          'durationForEachReservation': durationForEachReservation,
        }),
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Private session updated successfully');
        print('update');

        //fetchPrivateSessions(sessionId); // تحديث الجلسات بعد التحديث
      } else {
        Get.snackbar('Error', 'Failed to update private session');
        print(response.body);

      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while updating private session');
    }
  }
  Future<void> EditPublicSession(int sessionId, String sessionName, String sessionDescription, String sessionDate, String sessionStartTime, String sessionEndTime, String maximumNumberOfReservations) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.put(
        Uri.parse('$baseURL/api/publicSession/update/$sessionId'),
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
          'MaximumNumberOfReservations': maximumNumberOfReservations,
        }),
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Private session updated successfully');
        print('update');

        //fetchPrivateSessions(sessionId); // تحديث الجلسات بعد التحديث
      } else {
        Get.snackbar('Error', 'Failed to update private session');
        print(response.body);

      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while updating private session');
    }
  }
  /*Future<void> updateSession(int sessionId, String sessionName, String sessionDescription, String sessionDate, String sessionStartTime, String sessionEndTime) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading.value = true;
    try {
      var response = await http.put(
        Uri.parse('$baseURL/api/session/update/$sessionId'),
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
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Session updated successfully');
        fetchSessions(sessionId); // تحديث الجلسات بعد التحديث
      } else {
        Get.snackbar('Error', 'Failed to update session');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while updating session');
    } finally {
      isLoading.value = false;
    }
  }*/

  Future<void> deleteSession(int sessionId,int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading.value = true;
    try {
      final response = await http.delete(
        Uri.parse('$baseURL/api/session/cancel/$sessionId'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        //fetchSessions(); // Refresh the session list after delete
        Get.snackbar('Success', 'Session deleted successfully');
        //fetchSessions(userId);

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
  Future<void> startSession(int sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.put(
        Uri.parse('$baseURL/api/session/start/$sessionId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      print('hey');
      if (response.statusCode == 200) {
        print('start');
        var session = Session.fromJson(jsonDecode(response.body));
        updateSession(session);
        Get.snackbar('Success', 'Session started successfully');
      } else {
        print(response.body);
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to start session');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while starting session');
    }
  }
  Future<void> closeSession(int sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.put(
        Uri.parse('$baseURL/api/session/close/$sessionId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      print('bye');
      if (response.statusCode == 200) {
        print('close');
        var session = Session.fromJson(jsonDecode(response.body));
        updateSession(session);
        Get.snackbar('Success', 'Session closed successfully');
      } else {
        print(response.body);
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to close session');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while closing session');
    }
  }
  Future<void> startPrivateSession(int sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.put(
        Uri.parse('$baseURL/api/session/start/$sessionId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var privateSession = PrivateSession.fromJson(jsonDecode(response.body));
        // طباعة البيانات المستلمة من السيرفر
        print('Received private session from server: ${privateSession.toJson()}');

        updatePrivateSession(privateSession);
        Get.snackbar('Success', 'Private session started successfully');
      } else {
        print(response.body);
        Get.snackbar('Error', 'Failed to start private session');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred while starting private session');
    }
  }

  Future<void> closePrivateSession(int sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.put(
        Uri.parse('$baseURL/api/session/close/$sessionId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      print('bye');
      if (response.statusCode == 200) {
        print('close');
        var privateSession = PrivateSession.fromJson(jsonDecode(response.body));
        updatePrivateSession(privateSession);
        Get.snackbar('Success', 'Session closed successfully');
      } else {
        print(response.body);
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to close session');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred while closing session');
    }
  }

  // Future<void> startPrivateSession(int sessionId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final accessToken = prefs.getString('accessToken');
  //   try {
  //     var response = await http.put(
  //       Uri.parse('$baseURL/api/session/start/$sessionId'),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );
  //     print('hey');
  //     if (response.statusCode == 200) {
  //       print('start');
  //       var private = PrivateSession.fromJson(jsonDecode(response.body));
  //       updateSession(private);
  //       Get.snackbar('Success', 'Session started successfully');
  //     } else {
  //       print(response.body);
  //       print(response.statusCode);
  //       Get.snackbar('Error', 'Failed to start session');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'An error occurred while starting session');
  //   }
  // }

  // Future<void> closePrivateSession(int sessionId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final accessToken = prefs.getString('accessToken');
  //   try {
  //     var response = await http.put(
  //       Uri.parse('$baseURL/api/session/close/$sessionId'),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );
  //     print('bye');
  //     if (response.statusCode == 200) {
  //       print('close');
  //       var session = Session.fromJson(jsonDecode(response.body));
  //       updateSession(session);
  //       Get.snackbar('Success', 'Session closed successfully');
  //     } else {
  //       print(response.body);
  //       print(response.statusCode);
  //       Get.snackbar('Error', 'Failed to close session');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'An error occurred while closing session');
  //   }
  // }

  // void fetchPublicSessions(int serviceId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final accessToken = prefs.getString('accessToken');
  //   try {
  //     isLoading(true);
  //     var response = await http.get(
  //       Uri.parse('$baseURL/api/publicSession/show/$serviceId'),
  //       headers: <String, String>{
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       print('oh shit here we go again');
  //       var jsonData = jsonDecode(response.body) as List;
  //       sessions.value = jsonData.map((json) => PublicSession.fromJson(json)).toList();
  //       // طباعة قائمة السيشن
  //       sessions.value.forEach((session) {
  //         print('id: ${session.id}');
  //         print('Session ID: ${session.sessionID}');
  //         print('Session Name: ${session.session?.sessionName}');
  //         print('Session Description: ${session.session?.sessionDescription}');
  //         print('Session Date: ${session.session?.sessionDate}');
  //         print('Session Start Time: ${session.session?.sessionStartTime}');
  //         print('Session End Time: ${session.session?.sessionEndTime}');
  //         print('Status: ${session.session?.status}');
  //         print('Maximum Number Of Reservations: ${session.maximumNumberOfReservations}');
  //         print('Is Reserved: ${session.isReserved}');
  //         print('-------------------------------------');
  //       });
  //     } else {
  //       print(response.body);
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  void fetchPublicSessions(int serviceId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('$baseURL/api/publicSession/show/$serviceId'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        print('oh shit here we go again');
        var jsonData = jsonDecode(response.body) as List;
        var sessionList = jsonData.map((json) => PublicSession.fromJson(json)).toList();

        // استرجاع حالة الحجز من SharedPreferences لكل جلسة
        for (var session in sessionList) {
          session.isReserved = prefs.getBool('isReserved_${session.id}') ?? false;
        }

        sessions.value = sessionList;

        // طباعة قائمة السيشن
        sessions.value.forEach((session) {
          print('id: ${session.id}');
          print('Session ID: ${session.sessionID}');
          print('Session Name: ${session.session.sessionName}');
          print('Session Description: ${session.session.sessionDescription}');
          print('Session Date: ${session.session.sessionDate}');
          print('Session Start Time: ${session.session.sessionStartTime}');
          print('Session End Time: ${session.session.sessionEndTime}');
          print('Status: ${session.session.status}');
          print('Maximum Number Of Reservations: ${session.maximumNumberOfReservations}');
          print('Is Reserved: ${session.isReserved}');
          print('-------------------------------------');
        });
      } else {
        print(response.body);
      }
    } finally {
      isLoading(false);
    }
  }


  // Future<void> bookSession(int sessionId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final accessToken = prefs.getString('accessToken');
  //   try {
  //     var response = await http.post(
  //       Uri.parse('$baseURL/api/publicReservation/book/$sessionId'),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //
  //     print(sessionId);
  //
  //     if (response.statusCode == 200) {
  //       Get.snackbar('Success', 'Your reservation has been completed successfully.');
  //
  //       // تحديث حالة الحجز في SharedPreferences
  //       await prefs.setBool('isReserved_$sessionId', true);
  //
  //       // تحديث حالة الحجز في القائمة المؤقتة
  //       final index = sessions.indexWhere((session) => session.id == sessionId);
  //       if (index != -1) {
  //         sessions[index].isReserved = true;
  //         sessions.refresh(); // تحديث قائمة الجلسات لإعادة بناء واجهة المستخدم
  //       }
  //     } else if (response.statusCode == 400) {
  //       Get.snackbar('Error', 'You already have a reservation for this session.');
  //     } else if (response.statusCode == 403) {
  //       Get.snackbar('Error', 'Sorry, the count has completed.');
  //     } else {
  //       print(response.body);
  //       print(response.statusCode);
  //       Get.snackbar('Error', 'Failed to book session.');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'An error occurred while booking the session');
  //   }
  // }
  Future<void> bookSession(PublicSession publicSession) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.post(
        Uri.parse('$baseURL/api/publicReservation/book/${publicSession.id}'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        int publicReservationId = jsonResponse['publicReservation']['id'];

        Get.snackbar('Success', 'Your reservation has been completed successfully.');

        // تخزين حالة الحجز ومعرف الحجز في SharedPreferences
        await prefs.setBool('isReserved_${publicSession.id}', true);
        await prefs.setInt('publicReservationId_${publicSession.id}', publicReservationId);

        // تحديث حالة الحجز في القائمة المؤقتة
        publicSession.isReserved = true;
        sessions.refresh(); // إعادة بناء واجهة المستخدم
      } else if (response.statusCode == 400) {
        Get.snackbar('Error', 'You already have a reservation for this session.');
      } else if (response.statusCode == 403) {
        Get.snackbar('Error', 'Sorry, the count has completed.');
      } else {
        print(response.body);
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to book session.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while booking the session');
    }
  }

  Future<void> cancelReservation(PublicSession publicSession) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final publicReservationId = prefs.getInt('publicReservationId_${publicSession.id}');

    if (publicReservationId == null) {
      Get.snackbar('Error', 'No reservation found to cancel.');
      return;
    }

    try {
      var response = await http.delete(
        Uri.parse('$baseURL/api/publicReservation/cancel/$publicReservationId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Your reservation has been cancelled successfully.');

        // إزالة حالة الحجز ومعرف الحجز من SharedPreferences
        await prefs.remove('isReserved_${publicSession.id}');
        await prefs.remove('publicReservationId_${publicSession.id}');

        // تحديث حالة الحجز في القائمة المؤقتة
        publicSession.isReserved = false;
        sessions.refresh(); // إعادة بناء واجهة المستخدم
      } else if (response.statusCode == 404) {
        Get.snackbar('Error', 'No reservation found.');
      } else {
        print(response.body);
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to cancel reservation.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while cancelling the reservation');
    }
  }
  Future<List<String>> fetchUserNamesForPublic(int sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final response = await http.get(
      Uri.parse('$baseURL/api/publicReservation/showAll/$sessionId'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
print(sessionId);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> userNames = List<String>.from(data['userNames']);
      return userNames;
    } else {
      print(response.body);
      print(response.statusCode);
      throw Exception('Failed to load user names');
    }
  }

}



/*
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/service_model.dart';

class ServiceController extends GetxController {
  var services = <Service>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchServices();
    super.onInit();
  }

  Future<void> fetchServices() async {
    final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDk4ZDQ0NGY3NGYxOGNkOTEzM2YyZjU4MTFkNDgwYjM0MDYzNWY0NjY2OTcyYjA3N2RlNDY0M2U0ZWRkMjAwMjQyOTU0M2IyZjU4ZmE1YjYiLCJpYXQiOjE3MTU4NTM2NzYuMTkyMjYzLCJuYmYiOjE3MTU4NTM2NzYuMTkyMjc2LCJleHAiOjE3NDczODk2NzYuMTgwNjc5LCJzdWIiOiIyNiIsInNjb3BlcyI6W119.G96SLA3SmU0nGFL3GoAlJoKFktDyyw-N34L6G3RwNLbWvRUijTq1e8Q3vpsUhabwvcHhUkBDU3eZWfx57dLvIbHJPFVx1eJi4xo9Ue0976GBWOSfr5BHW9RWpWtOItcz5d-doRt5tLI37lCQhOEbCtfObJfVY9tZNWGLqb3P8qYoJZBArZOT7JBMuIcw1FtyO3BtepeEL04tEdjL5MHIGK1_At3yXK4k0xpLwvxEZwKPDQ5fWxQdc1NBguV2Ir22rGX1F2eMejKHNbikaDhOh_8zZojKk5IWVkwTPw77W_OEE-_gK8A0QJMga4gNwx-hRIfnQlL1a1ncDrNqT8MvTC-c6rjsqrndPOqZrfzjZz1zY-EEI5fMxL2NxS260j5Jm78RQUREZ14tTXD_sNsCnJadxY5dI1kB_F6sEyZ55Ac0Nq4Dao0z9J3WXG7-9moYUa8FXKeQHo0HWlqSta9HSQjYO4KaDtwamgGp4Vxo0BVDnvr5HMv-tOC1wCMfA7NQmmBvATO5gJMrJAzPf9lwOPevIXMFnJkHSxC_HdqmU2fXf7fAs3xBzgLWJrAHdi6VSJ2WIn6gF3PZ1TWGT6EuOwe62ru21ljpYIJfoD03rRfK2wkxXzMlUt2xks-o9ksauZ3q3UrdLGqUTwHxZTC6ypWRQgFTym0iDdzG1sQTKHE";
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://192.168.137.216:8000/api/service/showByYearAndSpecialization/1'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        services.value = jsonResponse.map((data) => Service.fromJson(data)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load services');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load services');
    } finally {
      isLoading(false);
    }
  }
}
*/