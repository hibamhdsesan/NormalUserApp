
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Accounts/Advanced_Signin.dart';
import 'Accounts/View/Verification_Code.dart';
import 'Accounts/View/complete_advanced_user.dart';
import 'Accounts/View/set_new_password.dart';
import 'Accounts/View/show_normal_profile.dart';
import 'Accounts/change_email/enter_your_information.dart';
import 'Accounts/View/create_normal_account.dart';
import 'Accounts/View/enter_email.dart';
import 'Accounts/forget_password/change_password.dart';
import 'Accounts/forget_password/forgetpassword_enter_email.dart';
import 'Accounts/login.dart';
import 'AdvancedPrivateReservationsView.dart';
import 'AdvancedUser/screens/home_page.dart';
import 'NewAnnouncement.dart';
import 'announcment.dart';
import 'Explore_group.dart';

import 'new_group.dart';
import 'Accounts/change password/reset.dart';
import 'service_view.dart';

// void main() {
//
//   runApp(GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//       home: home_page()));
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'My_Announcement.dart';
import 'NewAnnouncement.dart';
import 'NewSaved.dart';
import 'addannouncement.dart';
import 'controllers/NewannouncementController.dart';

void main() {
  ImagePicker imagePicker = ImagePicker();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Announcements App',
      initialBinding: BindingsBuilder(() {
        Get.put(AnnouncementController());
      }),
      home: HomeScreen(),
      routes: {
        //'/add': (context) => AddAnnouncementPage(),
        '/saved': (context) => SavedAnnouncementPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.bookmark),
      //       onPressed: () {
      //         Get.toNamed('/saved');
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.person),
      //       onPressed: () {
      //         Get.to(MyAnnouncementPage());
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.add),
      //       onPressed: () {
      //         Get.to(()=> AnnouncementPage());
      //       },
      //     ),
      //   ],
      // ),
      body: Log_in(),

    );
  }
}
