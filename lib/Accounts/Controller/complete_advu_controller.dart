
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Model/complete_advu_model.dart';
import '../View/Verification_Code.dart';

class CompleteController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void complete() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final userData = await CompleteAccountModel.complete(email, password);
      print(userData);
      // انتقل إلى الصفحة التالية بعد تسجيل الدخول بنجاح
      Get.to(() => VerificationCodeView());
    } catch (e) {

      print('Failed to login: $e');
      Get.snackbar('Error', 'Failed to login');
    }
  }
}
