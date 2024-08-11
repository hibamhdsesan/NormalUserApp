import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals.dart';
import '../../home_page.dart';



class ForgetPasswordController extends GetxController {

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController configurePasswordController = TextEditingController();



  var hideNewPassword = true.obs;
  var hideConfigurePassword = true.obs;



  void toggleNewPasswordVisibility() {
    hideNewPassword.value = !hideNewPassword.value;
  }

  void toggleConfigurePasswordVisibility() {
    hideConfigurePassword.value = !hideConfigurePassword.value;
  }


  Future<void> forgetPassword() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final String newPassword = newPasswordController.text;
    final String configurePassword = configurePasswordController.text;

    if (newPassword != configurePassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }
    try {
      final response = await http.put(
        Uri.parse('$baseURL/api/setNewPassword'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
        body: <String, String>{

          'password': newPassword,
        },
      );
print(newPassword);
      if (response.statusCode == 200) {

        Get.snackbar('Success', 'Password Updated successfully');
        Get.to(()=> home_page() );

      } else if (response.statusCode == 405){

        Get.snackbar('Error', 'Incorrect Password');
      } else {

        Get.snackbar('Error', 'Failed to change password');
        print(response.body);
      }
    } catch (e) {

      print('Failed to change password: $e');
      Get.snackbar('Error', 'Failed to change password');
    }
  }
}
