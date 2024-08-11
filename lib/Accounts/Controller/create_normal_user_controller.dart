import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../home_page.dart';

import '../Model/create_normal_user_model.dart';
import '../View/enter_email.dart';

// class CreatePassController extends GetxController {
//   final TextEditingController passwordController = TextEditingController();
//   var hidePassword = true.obs;
//
//   void togglePasswordVisibility() {
//     hidePassword.value = !hidePassword.value;
//   }
//
//   void completeAccount() async {
//     final password = passwordController.text;
//     print(passwordController.text);
//
//     try {
//       final userData = await CreatePassModel.createPassword(password);
//       print(userData);
//       // انتقل إلى الصفحة التالية بعد تسجيل الدخول بنجاح
//       Get.snackbar('Success', 'Password accepted');
//       Get.to(() => enter_email());
//     } catch (e) {
//       print(passwordController.text);
//       print('Failed to create account: $e');
//       Get.snackbar('Error', 'Failed to create account');
//     }
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../home_page.dart';
import '../Model/create_normal_user_model.dart';

class CreatePassController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  var hidePassword = true.obs;

  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  void completeAccount() async {
    final password = passwordController.text;
    print(passwordController.text);

    try {
      final userData = await CreatePassModel.createPassword(password);
      print(userData);

      // انتقل إلى الصفحة التالية بعد تسجيل الدخول بنجاح
      Get.snackbar('Success', 'Password accepted');
      Get.to(() => enter_email());
    } catch (e) {
      print(passwordController.text);
      print('Failed to create account: $e');
      Get.snackbar('Error', 'Failed to create account');
    }
  }
}
