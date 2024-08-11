import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../globals.dart';
import '../model/SwapRequest_model.dart';
import '../model/fake_reservation.dart';
import '../model/my_private_reservation.dart';
import '../model/private_reservations.dart';

class PrivateReservationController extends GetxController {
  var reservations = <PrivateReservation>[].obs;
  var fakeReservations = <FakeReservation>[].obs;
  var myReservations = <MyPrivateReservation>[].obs;
  var swapRequests = <SwapRequest>[].obs;
  var sentSwapRequests = <SwapRequest>[].obs;
  var isLoading = false.obs;

  Future<void> fetchPrivateReservations(int privateSessionID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading(true);
    try {
      final response = await http.get(Uri.parse('$baseURL/api/privateReservation/showAll/$privateSessionID'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        print('200');
        var data = json.decode(response.body) as List;
        reservations.value = data.map((reservation) => PrivateReservation.fromJson(reservation)).toList();
      } else {
        // Handle error
        print(response.statusCode);
        print(response.body);
        print('Failed to load reservations');
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchFakeReservations(int privateSessionID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading(true);
    try {
      final response = await http.get(Uri.parse('$baseURL/api/showFakeReservations/$privateSessionID'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        fakeReservations.value = data.map((reservation) => FakeReservation.fromJson(reservation)).toList();
      } else {
        // Handle error
        print('Failed to load fake reservations');
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchMyReservations() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading(true);
    try {
      final response = await http.get(Uri.parse('$baseURL/api/privateReservation/showMy'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        myReservations.value = data.map((reservation) => MyPrivateReservation.fromJson(reservation)).toList();
      } else {
        // Handle error
        print(response.body);
        print('Failed to load my reservations');
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSwapRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('$baseURL/api/privateReservation/showAskedSwitch'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        swapRequests.value = data.map((item) => SwapRequest.fromJson(item)).toList();
        print('swap request');
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch swap requests.',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        snackPosition: SnackPosition.TOP,
      );
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchSentSwapRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse('$baseURL/api/privateReservation/showSentSwitch'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        print('sent request');
        var data = json.decode(response.body) as List;
        sentSwapRequests.value = data.map((item) => SwapRequest.fromJson(item)).toList();
      } else {
        print(response.body);
        Get.snackbar(
          'Error',
          'Failed to fetch swap requests.',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
  Future<void> deleteSentSwapRequest(int swapRequestID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      final response = await http.delete(
        Uri.parse('$baseURL/api/privateReservation/cancelSwapRequest/$swapRequestID'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Swap request deleted successfully');
        fetchSentSwapRequests(); // لإعادة تحميل قائمة طلبات التبديل بعد الحذف
      } else {
        var data = json.decode(response.body);
        Get.snackbar('Error', data['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred.');
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
  Future<void> switchRole(int receiverGroupReservationID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse('$baseURL/api/privateReservation/switch/$receiverGroupReservationID'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 201) {
        var data = json.decode(response.body);
        Get.snackbar('Success', data['message']);
      } else {
        var data = json.decode(response.body);
        Get.snackbar('Error', data['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred.');
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
  Future<void> acceptSwapRequest(int swapRequestID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      final response = await http.delete(
        Uri.parse('$baseURL/api/privateReservation/acceptSwapRequest/$swapRequestID'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        Get.snackbar('Success', 'Swap request accepted successfully');
        fetchSwapRequests(); // Refresh the list of swap requests
      } else {
        print(response.body);
        var data = json.decode(response.body);
        Get.snackbar('Error', data['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred.');
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> declineSwapRequest(int swapRequestID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      final response = await http.delete(
        Uri.parse('$baseURL/api/privateReservation/declineSwapRequest/$swapRequestID'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Swap request declined successfully');
        fetchSwapRequests(); // Refresh the list of swap requests
      } else {

        var data = json.decode(response.body);
        Get.snackbar('Error', data['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred.');
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> bookReservation(int reservationID, int privateSessionID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.post(
        Uri.parse('$baseURL/api/privateReservation/book/$reservationID'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Your reservation has been completed successfully',
          snackPosition: SnackPosition.TOP,
        );
        fetchFakeReservations(privateSessionID);  // Refresh the list of reservations
      } else {
        var data = json.decode(response.body);
        Get.snackbar(
          'Error',
          data['message'],
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        snackPosition: SnackPosition.TOP,
      );
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }


  Future<void> deleteReservation(int reservationID, int privateSessionID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.delete(Uri.parse('$baseURL/api/privateReservation/delete/$reservationID'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Reservation deleted successfully',
          snackPosition: SnackPosition.TOP,
        );
        fetchFakeReservations(privateSessionID);  // Refresh the list of reservations
      } else {
        print(response.body);

        var data = json.decode(response.body);
        Get.snackbar(
          'Error',
          data['message'],
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        snackPosition: SnackPosition.TOP,
      );
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
