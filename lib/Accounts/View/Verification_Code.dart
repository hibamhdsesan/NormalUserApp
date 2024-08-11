/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controller/verification_code_controller.dart';

class VerificationCodeView extends StatefulWidget {
  @override
  State<VerificationCodeView> createState() => _VerificationCodeViewState();
}

class _VerificationCodeViewState extends State<VerificationCodeView> {
  final VerificationCodeController _controller = Get.put(VerificationCodeController());
  String verificationCode = '';
  late List<TextEditingController> _controllers;
 // تعريف _controllers هنا
  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (index) => TextEditingController()); // تهيئة _controllers في initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0, right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Verification Code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF343846),
                        fontFamily: 'Inter',
                        height: 1.3,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Text(
                      'we send message for email salam.kwm@gmail.com please go to email and get the verification code . '
                          'if you don’t have any message click resend verification code !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF292D3D),
                        fontFamily: 'Inter',
                        height: 1.3,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  VerificationCodeInput(),
                  SizedBox(height: 20.0),

                   GestureDetector(
                    onTap: () {
                      _controllers.forEach((controller) {
                        verificationCode += controller.text;
                      });
                      _controller.verifyCode(verificationCode);

                      print(verificationCode);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff64A78F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 150,
                      height: 60,
                      child: Center(
                        child: Text(
                          'Next',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerificationCodeInput extends StatefulWidget {
  @override
  _VerificationCodeInputState createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  late List<TextEditingController> _controllers; // تعريف _controllers هنا

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (index) => TextEditingController()); // تهيئة _controllers في initState
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        6,
            (index) => SizedBox(
          width: 40.0,
          height: 46.0,
          child: TextField(
            controller: _controllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: Offstage(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff292D3D), width: 4),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
            },
            focusNode: _focusNodes[index],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/verification_code_controller.dart';

class VerificationCodeView extends StatelessWidget {
  final VerificationCodeController _controller = Get.put(VerificationCodeController());
  late List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController()); // تهيئة _controllers هنا

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0, right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Verification Code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF343846),
                        fontFamily: 'Inter',
                        height: 1.3,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Text(
                      'we send message for email salam.kwm@gmail.com please go to email and get the verification code . '
                          'if you don’t have any message click resend verification code !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF292D3D),
                        fontFamily: 'Inter',
                        height: 1.3,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  VerificationCodeInput(_controllers),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      String verificationCode = '';
                      _controllers.forEach((controller) {
                        verificationCode += controller.text;
                      });
                      _controller.verifyCode(verificationCode);
                      print(verificationCode);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff64A78F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 150,
                      height: 60,
                      child: Center(
                        child: Text(
                          'Next',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerificationCodeInput extends StatefulWidget {
  final List<TextEditingController> controllers;

  VerificationCodeInput(this.controllers);

  @override
  _VerificationCodeInputState createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in widget.controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        6,
            (index) => SizedBox(
          width: 40.0,
          height: 46.0,
          child: TextField(
            controller: widget.controllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: Offstage(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff292D3D), width: 4),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
            },
            focusNode: _focusNodes[index],
          ),
        ),
      ),
    );
  }
}


/*class VerificationCodeInput extends StatefulWidget {
  @override
  _VerificationCodeInputState createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  List<TextEditingController> _controllers =
  List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        6,
            (index) => SizedBox(
          width: 40.0,
          height: 46.0,
          child: TextField(
            controller: _controllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: Offstage(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff292D3D), width: 4),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
            },
            focusNode: _focusNodes[index],
          ),
        ),
      ),
    );
  }
}*/

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// class Verification_Code extends StatefulWidget {
//
//   const Verification_Code({Key? key}) : super(key: key);
//
//   @override
//   State<Verification_Code> createState() => _Verification_CodeState();
// }
//
// class _Verification_CodeState extends State<Verification_Code> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Stack(
//
//         children: [
//           /* SvgPicture.asset(
//             'assets/Ellipse/Sign_up.svg',
//           ),*/
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 150.0,right: 20,left: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Text(
//                       'Verification Code',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF343846),
//                         fontFamily: 'Inter',
//                         height: 1.3,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   Center(
//                     child: Text(
//                       'we send message for email salam.kwm@gmail.com please go to email and get the verification code . '
//                           'if you don’t have any message click resend verification code !',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Color(0xFF292D3D),
//                         fontFamily: 'Inter',
//                         height: 1.3,
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 20.0),
//                   VerificationCodeInput(),
//                   SizedBox(height: 20.0),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Color(0xff64A78F),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     width: 150,
//                     height: 60,
//                     //margin: EdgeInsets.only(left: 20, ),
//                     child: Center(
//                       child: Text(
//                         'Next',
//                         style: TextStyle(
//                           fontSize: 24,
//                           color: Colors.white,
//                           fontFamily: 'Inter',
//                           height: 29 / 24,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: SvgPicture.asset(
//               'assets/Ellipse/Ellipse2.svg',
//
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class VerificationCodeInput extends StatefulWidget {
//   @override
//   _VerificationCodeInputState createState() => _VerificationCodeInputState();
// }
//
// class _VerificationCodeInputState extends State<VerificationCodeInput> {
//   List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
//   List<TextEditingController> _controllers =
//   List.generate(6, (index) => TextEditingController());
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: List.generate(
//         6,
//             (index) => SizedBox(
//           width: 40.0,
//           height: 46.0,
//           child: TextField(
//             controller: _controllers[index],
//             textAlign: TextAlign.center,
//             keyboardType: TextInputType.number,
//             maxLength: 1,
//             decoration: InputDecoration(
//               counter: Offstage(),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xff292D3D),width: 4),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//             onChanged: (value) {
//               if (value.isNotEmpty && index < 5) {
//                 FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
//               } else if (value.isEmpty && index > 0) {
//                 FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
//               }
//             },
//             focusNode: _focusNodes[index],
//           ),
//         ),
//       ),
//     );
//   }
// }
