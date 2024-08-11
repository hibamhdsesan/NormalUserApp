import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Accounts/View/show_normal_profile.dart';
import '../../globals.dart';



class PasswordController extends GetxController {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController configurePasswordController = TextEditingController();


  var hideOldPassword = true.obs;
  var hideNewPassword = true.obs;
  var hideConfigurePassword = true.obs;

  void toggleOldPasswordVisibility() {
    hideOldPassword.value = !hideOldPassword.value;
  }

  void toggleNewPasswordVisibility() {
    hideNewPassword.value = !hideNewPassword.value;
  }

  void toggleConfigurePasswordVisibility() {
    hideConfigurePassword.value = !hideConfigurePassword.value;
  }


  Future<void> changePassword() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final String oldPassword = oldPasswordController.text;
    final String newPassword = newPasswordController.text;
    final String configurePassword = configurePasswordController.text;

    if (newPassword != configurePassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }
    try {
      final response = await http.put(
        Uri.parse('$baseURL/api/changePassword'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
        body: <String, String>{
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      );

      if (response.statusCode == 200) {

        Get.snackbar('Success', 'Password changed successfully');
        Get.to(()=> ProfilePage() );

      } else if (response.statusCode == 405){

        Get.snackbar('Error', 'Incorrect Password');
      } else {

    Get.snackbar('Error', 'Failed to change password');
    }
    } catch (e) {

      print('Failed to change password: $e');
      Get.snackbar('Error', 'Failed to change password');
    }
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'reset_model.dart';
//
//
// class PasswordController extends GetxController {
//   static const String _baseUrl = 'http://192.168.137.218:8000/api/changePassword';
//   final TextEditingController _oldPasswordController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//
//
//   Future<void> changePassword(String oldPassword, String newPassword, String confirmPassword) async {
//     if (newPassword == confirmPassword) {
//       final passwordData = PasswordData(oldPassword: oldPassword, newPassword: newPassword);
//       final jsonData = jsonEncode(passwordData.toJson());
//
//
//       try {
//         final response = await http.put(
//           Uri.parse(_baseUrl),
//           headers: {
//             'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYzNiODEwMTA1YThjZThhMTI5YzQxMDZjZTdhMjgwOTY1MjM2YTQ1Yjg0ZjdiMTYyNjE2Mzc0YzZkOGM4NWY4OGMzMmQ4NzBmZGY2NzdkNmEiLCJpYXQiOjE3MTUwODE0MjQuNTkxMTQxLCJuYmYiOjE3MTUwODE0MjQuNTkxMTQ1LCJleHAiOjE3NDY2MTc0MjQuNTcwNjY2LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.SfFtCLaJbSG-vUiR3gEMHWLskzsrziDjxs5Gke1BFZjElNfJbKdSaEERMAsUETgfYmTyyhSVQP0uc2INEE61yWVPIdbLDV2906zZ8Gz45eQB3fwGYxmC5SxmIqvN_hdsE6V_FiuLIlKt1XwJbB3i0ktAqZ-z4xAu8VmrpgE1lbFQyAFlKHkgF4CGawF9itwNty_POT6WwHVHZMHkE7T2tYyLRE28b3qnoDCAHuO3ehyPuwSL3-EBqg1_s9RRk878R6YwQbYJChdJao61jcukcJY1jYpnJdtfeoPedcx-B8X8am9uR7eR_6G3Sz6v4kJDtx3qcp_-Z8qagL-jUs9H5hJrbjrjckZoG65vZraEDAE6AyM5OXvvOzI16ciJxY0Ky5js6fugPS7XTY0Gu258HtlmlMY43MAv3x1USxUKfV6vcN_TJYXCaMhdhzY0KWxm3Uo4djqXTeTuDXftUaux-uRTSkajRbJnzuiiXvjLLU4e00oqy7lWke09AoI5hf_RVIs5npAc-jv6grRDDm6DC5iPNn_Lkx5D1z9Wd42NURiIC_CiWNRQLIhgfw8hlWYs9LYyiyeb8DvoL6cnkwZNLlVn_MJNIq97MKFdvpVhXcTNtsT913eBhwgOOIaQnV1MU1xUOfgFLXZW8oaAIYFdJP_K7xeA9jQpKeWNi-qu_p0',
//             'Content-Type': 'application/json',
//           },
//           body: jsonData,
//         );
//
//         if (response.statusCode == 200) {
//           Get.snackbar('Success', 'Password changed successfully');
//         } else {
//           throw Exception('Failed to change password');
//         }
//       } catch (e) {
//         print('Error: $e');
//         Get.snackbar('Error', 'Failed to change password');
//       }
//     } else {
//       Get.snackbar('Error', 'Passwords do not match');
//     }
//   }
// }
