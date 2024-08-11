// reset_password_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextFormField.dart';
import '../forget_password/forgetpassword_enter_email.dart';
import 'reset_controller.dart';

class ResetPasswordView extends StatelessWidget {

  final PasswordController _passwordController = Get.put(PasswordController());
  bool hideOldPassword = true;
  bool hideNewPassword = true;
  bool hideConfigurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/Ellipse/Sign_up.svg',
              color: Color(0xff292D3D),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 300,),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Change Password',
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
                SizedBox(height: 20,),
                Center(
                  child: Container(

                    width: 350,
                    child: Obx( ()=>
                        CustomTextFormField(
                          hintText: 'Old Password',
                          controller: _passwordController.oldPasswordController,
                          obscureText: _passwordController.hideOldPassword.value,
                          suffixIcon: IconButton(
                            icon: Icon(_passwordController.hideOldPassword.value ? Icons.visibility_off : Icons.visibility),
                            onPressed: _passwordController.toggleOldPasswordVisibility,
                          ),

                        )
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Container(

                    width: 350,
                    child: Obx(()=>
                       CustomTextFormField(
                         hintText: 'New Password',
                         controller: _passwordController.newPasswordController,
                         obscureText: _passwordController.hideNewPassword.value,
                         suffixIcon: IconButton(
                           icon: Icon(_passwordController.hideNewPassword.value ? Icons.visibility_off : Icons.visibility),
                           onPressed: _passwordController.toggleNewPasswordVisibility,
                         ),

                       )
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Container(

                    width: 350,
                    child: Obx(()=>
                        CustomTextFormField(
                          hintText:  'Configure Password',
                          controller:  _passwordController.configurePasswordController,
                          obscureText: _passwordController.hideConfigurePassword.value,
                          suffixIcon: IconButton(
                            icon: Icon(_passwordController.hideConfigurePassword.value ? Icons.visibility_off : Icons.visibility),
                            onPressed: _passwordController.toggleConfigurePasswordVisibility,
                          ),

                        )
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                CustomElevatedButton(
                  color: Color(0xffFF7B1C),
                  text: 'Next',
                  onPressed: _passwordController.changePassword,),
                const SizedBox(height: 20,),
                GestureDetector(
                    onTap: (){
                      Get.to(forgot_password());
                    },
                    child: const Center(child: Text('Forget Your Password ?',
                      style: TextStyle(color: Colors.grey),))
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}




