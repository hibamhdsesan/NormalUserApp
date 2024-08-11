import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import '../home_page.dart';
// import 'user_model.dart';
//
// class LoginController extends GetxController {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   void login() async {
//     final email = emailController.text;
//     final password = passwordController.text;
//
//     try {
//       final userData = await UserModel.login(email, password);
//       print(userData);
//       // انتقل إلى الصفحة التالية بعد تسجيل الدخول بنجاح
//       Get.to(() => home_page());
//     } catch (e) {
//       print('Failed to login: $e');
//       Get.snackbar('Error', 'Failed to login');
//     }
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Groups/GroupView.dart';
import '../globals.dart';
import '../home_page.dart';
import 'user_model.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final userData = await UserModel.login(email, password);
      print(userData);
      // انتقل إلى الصفحة التالية بعد تسجيل الدخول بنجاح
      Get.to(() => home_page());
    } catch (e) {
      print('فشل تسجيل الدخول: $e');
      Get.snackbar('خطأ', 'فشل تسجيل الدخول');
    }
  }
}