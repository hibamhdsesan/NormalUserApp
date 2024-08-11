import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextFormField.dart';
import '../Controller/enter_email_controller.dart';
import '../Controller/forget_pass_controller.dart';
import '../Controller/verification_code_controller.dart';

class forgot_password extends StatefulWidget {
  const forgot_password({Key? key}) : super(key: key);

  @override
  State<forgot_password> createState() => _forgot_passwordState();
}

class _forgot_passwordState extends State<forgot_password> {
  final  ForgetPassController _forgetPassController = Get.put(ForgetPassController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/Ellipse/Sign_up.svg',color: Color(0xff292D3D),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 300,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Enter Your Email',
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
                  child: CustomTextFormField(
                    hintText: 'Enter your Email',
                    controller:  _forgetPassController.emailController,
                  )
                ),
                SizedBox(height: 20,),
                Center(
                  child: CustomElevatedButton(
                    text: 'Next',
                    color: Color(0xffFF7B1C),
                    onPressed:_forgetPassController.forget_pass,

                  )
                ),
              ],
            ),

          ],

        ),
      ),

    );
  }
}
