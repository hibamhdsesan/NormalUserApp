import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home_page.dart';

import '../Model/SetPassword_Model.dart';
import '../View/enter_email.dart';

class SetNewPassController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  var hidePassword = true.obs;


  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  // void completeAccount() async {
  //   final password = passwordController.text;
  //   print(passwordController.text);
  //
  //   try {
  //     final userData = await CreatePassModel.createPassword(password);
  //     print(userData);
  //
  //     // انتقل إلى الصفحة التالية بعد تسجيل الدخول بنجاح
  //     Get.snackbar('Success', 'Password accepted');
  //     Get.to(() => home_page());
  //   } catch (e) {
  //     print(passwordController.text);
  //     // استرجاع التوكن من SharedPreferences
  //     final prefs = await SharedPreferences.getInstance();
  //     final accessToken = prefs.getString('accessToken');
  //     print(accessToken);
  //     print('Failed to create account: $e');
  //     Get.snackbar('Error', 'Failed to create account');
  //   }
  // }
  void completeAccount() async {
    final password = passwordController.text;

    try {
      final userData = await CreatePassModel.createPassword(password);
      if (userData.containsKey('message')) {
        // الرد ناجح
        Get.snackbar('Success', userData['message']);
        Get.to(() => home_page());
      } else {
        // حدث خطأ غير متوقع في الرد
        Get.snackbar('Error', 'Failed to create account');
      }
    } catch (e) {
      // حدث خطأ أثناء الاتصال بالخادم
      Get.snackbar('Error', 'Failed to create account');
    }
  }

}
