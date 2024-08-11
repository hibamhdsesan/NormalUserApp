import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View/Verification_Code.dart';
import 'change_email_model.dart';

class ChangeEmailController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void complete() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final userData = await ChangeEmailModel.changeEmail(email, password);
      print(userData);
      // انتقل إلى الصفحة التالية بعد تسجيل الدخول بنجاح
      Get.to(() => VerificationCodeView());
    } catch (e) {
      print('Failed to login: $e');
      Get.snackbar('Error', 'Failed to login');
    }
  }
}