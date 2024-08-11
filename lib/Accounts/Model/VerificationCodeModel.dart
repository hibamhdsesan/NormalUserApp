import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../globals.dart';
//
// class VerificationCodeModel {
//   static Future<bool> verifyCode(String code) async {
//
//     final response = await http.delete(
//       Uri.parse('$baseURL/api/verification'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiM2U2N2Y1ZjI1Y2ZlMTI0MWM4N2M5MGE4ZGRhNzAwZDJjYmNiZWE1NjE1N2QxOGU4ODFkMzNhMDZlMjdiNDI0NzMyOTVkODM3YmE0NjE3NDIiLCJpYXQiOjE3MTUyNDU4NDAuMDAxMzgxLCJuYmYiOjE3MTUyNDU4NDAuMDAxMzg0LCJleHAiOjE3NDY3ODE4MzkuOTg0NjIyLCJzdWIiOiI0Iiwic2NvcGVzIjpbXX0.gYx1xtnH4nwg-VBi30LYHig4DCaUL1NpMvpDYEAuyaJJ0YsbfvcnlfEz9Dfgbz1BjgY_ERE5Eq-kkN0VWnKoHGmFXN75SLmbhAFXXjDlba2HO4RS0M-akHapv8sJDjGD_hoRDcZeD78V95oaHWcjYCxf5Njsg-6EvPwrLY5_zfe8tE07rU9iF49Aif16c5ClW33HGFt4iMZS2pPvTKuaS6oyOTs_wsMpffRsFF4MBLmw1gceRESTWU1797B4VSpkCLhZt998e8Xp7u3w2qWldvhUTWAWKuGRbcrtIE8Ztd7eXUjERudWCg-_nSEzu_9iwwzCusVkCNJB_6xBJb138t5vtckGV8alxIDLYnBo0C9gV8CV5VJrn-LjMBUKh6WI1FsrzgHo5bSu4sO00OvBXQkCWp7dM3oHz0V4VWZf-ns8hoMW9sLuJ1mLNoP86p1_PFJr5ad0iJCPSKEsi5EiFF8RQHNkBHSOaPz8yA9louyjvAqzYXKQqGG06cP-KDhQkTv3nVcrzKHbJtL7oC7SwsyfQusMXn1dy810ajhBbN8fluEFG_8xuxrFjQQhNxMl88GauiC0roUi-l6I2mFLkUdedhR_A5omLBfqAuinaOTpTQ2qUjEJvZFIM_eQ45kP_18HioE-aWo6Wj1bpTG4vhast57qW8Y2OEzsZEwDCOI',
//       },
//       body: jsonEncode(<String, String>{
//         'token': code,
//       }),
//     );
// print(response.body);
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VerificationCodeModel {
  static Future<bool> verifyCode(String code) async {
    // استرجاع التوكن من SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final response = await http.delete(
      Uri.parse('$baseURL/api/verification'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken', // استخدام التوكن المسترجع
      },
      body: jsonEncode(<String, String>{
        'token': code,
      }),
    );
    print('first$accessToken');
    print(response.body);
    if (response.statusCode == 200) {
      // استرجاع التوكن المستجد من الرد
      final responseData = jsonDecode(response.body);
      final accessToken = responseData['access_token'];

      // تحديث التوكن في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken);
      print('second$accessToken');

      return true;
    } else {
      return false;
    }
  }
}
