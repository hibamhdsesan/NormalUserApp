import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../home_page.dart';

import '../Model/create_normal_user_model.dart';
import '../Model/enter_email_model.dart';
import '../Model/foret_pass_model.dart';
import '../View/Verification_Code.dart';

class ForgetPassController extends GetxController {
  final TextEditingController emailController = TextEditingController();


  void forget_pass() async {
    final email = emailController.text;

    try {
      final userData = await ForgetPassModel.forget_pass(email);
      print(userData);
      print(email);

      Get.to(() => VerificationCodeView());
    } catch (e) {
      print('Failed: $e');
      Get.snackbar('Error', 'Failed');
    }
  }
}
