import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextFormField.dart';
import '../Controller/create_normal_user_controller.dart';

class create_normal_account extends StatefulWidget {

  const create_normal_account({Key? key}) : super(key: key);

  @override
  State<create_normal_account> createState() => _create_normal_accountState();
}

class _create_normal_accountState extends State<create_normal_account> {
  final CreatePassController _createPassController =  Get.put(CreatePassController());

  bool hidePassword = true;


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
            const SizedBox(height: 50,),
            Center(
              child: Container(

                width: 350,
                child:  Obx(()=>
                    CustomTextFormField(
                      hintText: 'Enter your password',
                      controller:  _createPassController.passwordController,
                      obscureText:_createPassController.hidePassword.value,
                      suffixIcon:  IconButton(
                        icon: Icon(_createPassController.hidePassword.value ? Icons.visibility_off : Icons.visibility),
                        onPressed: _createPassController.togglePasswordVisibility,
                      ),
                    ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child:CustomElevatedButton(
                text: 'Next',
                color: Color(0xffB0E7D3),
                onPressed: _createPassController.completeAccount,
              ),
            ),
            //SizedBox(height: 70,),
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
