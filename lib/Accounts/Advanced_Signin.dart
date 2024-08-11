import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'Controller/complete_advu_controller.dart';

class Advanced_Signin extends StatefulWidget {



  @override
  State<Advanced_Signin> createState() => _Advanced_SigninState();
}

class _Advanced_SigninState extends State<Advanced_Signin> {
  final CompleteController _signupController = Get.put(CompleteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 10,),
            Center(
              child: Container(

                width: 350,
                child: TextFormField(
                  controller:_signupController.emailController ,
                  decoration: InputDecoration(

                    hintText: 'Enter your Email',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                  ),


                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Container(

                width: 350,
                child: TextFormField(
                  controller:_signupController.passwordController ,
                  decoration: InputDecoration(

                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                  ),


                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: GestureDetector(
                onTap: _signupController.complete,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffB0E7D3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 350,
                  height: 60,
                  //margin: EdgeInsets.only(left: 20, ),
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'Inter',
                        height: 29 / 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            //SizedBox(height: 70,),
            Center(child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Image(image: AssetImage('assets/images/new_account.jpg'),width:267 ,height: 275,),
            )),


          ],
        ),
      ),
    );
  }
}
