import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../home_page.dart';

import '../Model/create_normal_user_model.dart';
import '../Model/enter_email_model.dart';
import '../View/Verification_Code.dart';

class CreateEmailController extends GetxController {
  final TextEditingController emailController = TextEditingController();


  void completeAccount3() async {
    final email = emailController.text;

    try {
      final userData = await CreateEmailModel.createEmail(email);
      print(userData);
      print(email);
      Get.to(() => VerificationCodeView());
      Get.snackbar('', userData['message']);
    } catch (e) {
      print('Failed: $e');
      Get.snackbar('Error', 'Failed');

    }
  }
}
