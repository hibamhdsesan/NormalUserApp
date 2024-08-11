import 'package:flutter/material.dart';

class PasswordController extends StatefulWidget {
  @override
  _PasswordControllerState createState() => _PasswordControllerState();
}

class _PasswordControllerState extends State<PasswordController> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController configurePasswordController =
  TextEditingController();

  bool hideOldPassword = true;
  bool hideNewPassword = true;
  bool hideConfigurePassword = true;

  void toggleVisibility(PasswordType type) {
    setState(() {
      switch (type) {
        case PasswordType.OldPassword:
          hideOldPassword = !hideOldPassword;
          break;
        case PasswordType.NewPassword:
          hideNewPassword = !hideNewPassword;
          break;
        case PasswordType.ConfigurePassword:
          hideConfigurePassword = !hideConfigurePassword;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body : Column(
        children: [
          TextField(
            controller: oldPasswordController,
            obscureText: hideOldPassword,
            decoration: InputDecoration(
              labelText: 'Old Password',
              suffixIcon: IconButton(
                icon: Icon(
                    hideOldPassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  toggleVisibility(PasswordType.OldPassword);
                },
              ),
            ),
          ),
          TextField(
            controller: newPasswordController,
            obscureText: hideNewPassword,
            decoration: InputDecoration(
              labelText: 'New Password',
              suffixIcon: IconButton(
                icon: Icon(
                    hideNewPassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  toggleVisibility(PasswordType.NewPassword);
                },
              ),
            ),
          ),
          TextField(
            controller: configurePasswordController,
            obscureText: hideConfigurePassword,
            decoration: InputDecoration(
              labelText: 'Configure Password',
              suffixIcon: IconButton(
                icon: Icon(hideConfigurePassword
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  toggleVisibility(PasswordType.ConfigurePassword);
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // إرسال كلمة المرور
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}

enum PasswordType {
  OldPassword,
  NewPassword,
  ConfigurePassword,
}
