import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/CustomElevatedButton.dart';
import '../Controller/show_normal_profile_controller.dart';
import '../change password/reset.dart';
import '../change_email/enter_your_information.dart';


class ProfilePage extends StatelessWidget {
  final NormalProfileController profileController = Get.put(NormalProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: Text('Profile'),
      ),*/

      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          if (profileController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text('Full Name: ${profileController.user.value.fullName}'),
                    Text('Email: ${profileController.user.value.email}'),
                    Text('Service Year: ${profileController.user.value.serviceYear}'),
                    Text('Service Specialization: ${profileController.user.value.serviceSpecializationName}'),
                    Text('Examination Number: ${profileController.user.value.examinationNumber}'),
                    Text('Study Situation: ${profileController.user.value.studySituation}'),
                    Text('Skills: ${profileController.user.value.skills ?? ''}'),
                    Text('Birth Date: ${profileController.user.value.birthDate != null ? profileController.user.value.birthDate!.toLocal().toString().split(' ')[0] : ''}'),
                    CustomElevatedButton(color:Color(0xffB0E7D3) , text: 'Change Email', onPressed: () {Get.to(()=> information() ); }),
                    const SizedBox(height: 20,),
                    CustomElevatedButton(color:Color(0xffB0E7D3) , text: 'Change Password', onPressed: () {Get.to(()=> ResetPasswordView() ); }),

                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
