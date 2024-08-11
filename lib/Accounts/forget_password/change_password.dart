import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextFormField.dart';
import 'change_password_controller.dart';

class change_password extends StatefulWidget {
  const change_password({Key? key}) : super(key: key);

  @override
  State<change_password> createState() => _change_passwordState();
}

class _change_passwordState extends State<change_password> {
  final ForgetPasswordController _forgetPasswordController = Get.put(ForgetPasswordController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/Ellipse/Sign_up.svg',color: Color(0xff292D3D),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                child: CustomTextFormField(
                  controller:_forgetPasswordController.newPasswordController ,
                  hintText: 'New Password',
                )
              ),
              const SizedBox(height: 20,),
              Center(
                child: CustomTextFormField(
                  hintText:  'Configure Password',
                  controller: _forgetPasswordController.configurePasswordController,
                )
              ),
              const SizedBox(height: 20,),
              Center(
                child: CustomElevatedButton(text: 'Next', color: Color(0xffFF7B1C), onPressed: _forgetPasswordController.forgetPassword,
                  
                )
              ),
            ],
          ),

        ],

      ),

    );
  }
}
