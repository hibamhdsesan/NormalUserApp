import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextFormField.dart';
import 'forget_password/forgetpassword_enter_email.dart';
import 'login_controller.dart';


class Log_in extends StatefulWidget {
  const Log_in({Key? key}) : super(key: key);

  @override
  State<Log_in> createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Color(0xffFFFFFF) ,
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  'assets/Ellipse/Sign_up.svg',
                ),
               /* Padding(
                  padding: const EdgeInsets.only(left: 168,),
                  child: SvgPicture.asset(
                    'assets/Ellipse/login.svg',
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, left: 20),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            SizedBox(height: 10,),
            Center(
              child: CustomTextFormField(
                hintText: 'Enter your Email',
                controller: _loginController.emailController,
              )
            ),
            const SizedBox(height: 20,),

            const SizedBox(height: 10,),
            Center(
              child: CustomTextFormField(
                hintText: 'Enter your password',
                controller: _loginController.passwordController,
              )
            ),
            const SizedBox(height: 20,),
            Center(
              child: CustomElevatedButton(text: 'Next',
                color:  Color(0xffB0E7D3),
                onPressed:_loginController.login,

              )
            ),

            const SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Get.to(forgot_password());
              },
                child: Center(child: Text('Forget Your Password ?',
                  style: TextStyle(color: Colors.grey),))
            ),

          ],
        ),
      ),
    );
  }
}
