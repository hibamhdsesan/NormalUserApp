
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/skills_model.dart';
import '../View/set_new_password.dart';

class SkillsController extends GetxController {
  final TextEditingController skillsController = TextEditingController();


  void completeAccount3() async {
    final skills = skillsController.text;

    try {
      final userData = await SkillsModel.skills(skills);
      print(userData);
      print(skills);

      Get.to(() => SetNewPassword());
    } catch (e) {
      print('Failed: $e');
      Get.snackbar('Error', 'Failed');
    }
  }
}
