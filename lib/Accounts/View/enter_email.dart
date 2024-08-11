import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextFormField.dart';
import '../Controller/enter_email_controller.dart';

class enter_email extends StatefulWidget {

  const enter_email({Key? key}) : super(key: key);

  @override
  State<enter_email> createState() => _enter_emailState();
}

class _enter_emailState extends State<enter_email> {
  final CreateEmailController _createEmailController = Get.put(CreateEmailController());
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
                        'Create',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        'New Account',
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
            SizedBox(height: 50,),
            Center(
              child: CustomTextFormField(
                hintText: 'Enter your Email',
                controller: _createEmailController.emailController,
              )
            ),
            const SizedBox(height: 20,),
            Center(
              child: CustomElevatedButton(
                text: 'Register',
                color: Color(0xffB0E7D3),
                onPressed: _createEmailController.completeAccount3,
              )
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
