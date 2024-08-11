import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart';
import '../Model/show_normal_profile_model.dart';

class NormalProfileController extends GetxController{
  var user = NormalUserModel(
    fullName: '',
    email: '',
    serviceYear: 0,
    serviceSpecializationName: '',
    examinationNumber: 0,
    studySituation: '',
  ).obs;
  var isLoading= true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }
  void fetchUserProfile() async{
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try{
      isLoading(true);
      var response = await http.get(Uri.parse('$baseURL/api/normalUser/showProfile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if(response.statusCode==200){
        user.value = NormalUserModel.fromJson(json.decode(response.body));
      } else {
    print('Failed to load profile');
     }
     } catch (e) {
    print('Error: $e');
    } finally {
    isLoading(false);
    }

    }

}
