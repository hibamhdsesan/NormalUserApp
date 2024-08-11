import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextFormField.dart';
import 'change_email_controller.dart';

class information extends StatefulWidget {



  @override
  State<information> createState() => _informationState();

}

class _informationState extends State<information> {
  final ChangeEmailController _ChangeEmailController = Get.put(ChangeEmailController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  'assets/Ellipse/Sign_up.svg',color: Color(0xff292D3D),
                ),
              ],

            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Change Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7B1C),
                    fontFamily: 'Inter',
                    height: 1.3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child:CustomTextFormField(
                hintText: 'Password',
                controller:_ChangeEmailController.passwordController,
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: CustomTextFormField(
                hintText: 'New Email',
                controller: _ChangeEmailController.emailController,
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child:CustomElevatedButton(
                text: 'Next',
                color: Color(0xffFF7B1C),
                onPressed:_ChangeEmailController.complete,

              ),
            ),
          ],
        ),
      ),

    );
  }
}
