import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextFormField.dart';

import '../Controller/enter_email_controller.dart';
import '../Controller/skills_controller.dart';

class Skills extends StatefulWidget {

  const Skills({Key? key}) : super(key: key);

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  final SkillsController _skillsController = Get.put(SkillsController());
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
                  hintText: 'Enter your skills',
                  controller: _skillsController.skillsController,
                )
            ),
            const SizedBox(height: 20,),
            Center(
                child: CustomElevatedButton(
                  text: 'Register',
                  color: Color(0xffB0E7D3),
                  onPressed: _skillsController.completeAccount3,
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
