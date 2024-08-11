import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextFormField.dart';
import '../Controller/complete_advu_controller.dart';

class complete_advanced_user extends StatefulWidget {

  const complete_advanced_user({Key? key}) : super(key: key);

  @override
  State<complete_advanced_user> createState() => _complete_advanced_userState();
}

class _complete_advanced_userState extends State<complete_advanced_user> {
  final CompleteController _completeController = Get.put(CompleteController());

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
                Padding(
                  padding: const EdgeInsets.only(top: 60.0, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complete',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        'Your Account',
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
            const SizedBox(height: 50,),
            Center(
              child: CustomTextFormField(
                hintText: 'Enter your Email',
                controller:_completeController.emailController,
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child:CustomTextFormField(
                hintText: 'Enter your password',
                controller: _completeController.passwordController,
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child:CustomElevatedButton(
                text: 'Next',
                onPressed: _completeController.complete,
                color:  Color(0xffB0E7D3),
              ),
            ),

            Center(child: Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: Image(image: AssetImage('assets/images/new_account.jpg'),width:267 ,height: 275,),
            )),


          ],
        ),
      ),
    );
  }
}
