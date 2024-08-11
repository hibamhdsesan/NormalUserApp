
import 'package:get/get.dart';

import '../Model/VerificationCodeModel.dart';
import '../View/skills.dart';
import '../forget_password/change_password.dart';


class VerificationCodeController extends GetxController {
  Future<void> verifyCode(String code) async {
    try {
      final isVerified = await VerificationCodeModel.verifyCode(code);
      print(code);
      if (isVerified) {
        Get.snackbar('Success', 'Code Verified Successfully');
        Get.to(() => Skills());


      } else {
        Get.snackbar('Error', 'Failed to Verify Code');
      }
    } catch (e) {
      print('Failed to verify code: $e');
      Get.snackbar('Error', 'Failed to Verify Code');
    }
  }
}
