// create_password_model.dart

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../globals.dart';

// class CreateEmailModel {
//   static Future<Map<String, dynamic>> createEmail(String email) async {
//     final response = await http.put(
//       Uri.parse('$baseURL/api/updateEmail'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjg2YmM4ODEzMDkyMTVhMDM2NDQ0YjU4OTY2NTI3N2FjOGFiNTQ1OWQzN2Q3YzI0ZmI5NjZkMTdhYjFhMjU1MDEwY2U5MDVhNTNiZmUzMTQiLCJpYXQiOjE3MTU2MDg1ODYuOTY2NzM4LCJuYmYiOjE3MTU2MDg1ODYuOTY2NzQyLCJleHAiOjE3NDcxNDQ1ODYuOTU4MTYyLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.hN2T2RFORcyBgM6W0tOnlmoH4TtLWl_Y4c0DEswDXxVn_iA4E5zyr0imbCD4AiVrboAkRVlt-lxVJaRNsrRG3XiSQUsXWazc2f0kaE2-mLXqv0nqzGujUB4U2ekKQHd5zCYBbHykhJVXKMm9E0z6etz5P_eYnHdbQ-5RqLGOLS52ABY6j0qfbWnVRZNI9NHF6w-vOMUHRs8TUK2DYIOYQgdbQXCXqNfpad37vzbrK1QjiL5FDj2JHJddz0IQq77RR-27OP20TinPt4TxTCeCW3AqQkMOHrFw2l0maCWchqJNaCHhO89DU9O0Sep1pU5hKwqnyJLgxsl6ESKj-yd7gNWxIEQ5tMKbjF4Og5mNur3lCkHFsHZJkRluARaZvQrl2Q5-L5eFDiqRfct1jncjw8XnoKrXCTbTxWkQF6gFL8XUxmNPOgLcZIrKSJifVEYfV3j3XhgYTOA-z5c94GV7s5yNr4UitPSXvrKC_YaEMQ40Gn6r9i2Fm6mZ2jLDUXL2LZPu542kr-dDdn7siqrEN5AAEz480No5Ta9Mk13MRlhDFpsuXyD-CZeLzJSMjU7UARq24c3xWsYcaYTYBVC5iW2gMgHt9yJwOCH2WmP7Vzx1UtPtRRY-Mq41ln5mfiw3piBTuywjAwOcsp7dQhubRqS4BLsW9-5DNJOinyb3eyI',
//       },
//       body: jsonEncode(<String, String>{
//         'email': email,
//       }),
//     );
//     print('i am in');
//     print(response.body);
//     if (response.statusCode == 200) {
//       Get.snackbar('Success', 'we sent 6 digit code to this email');
//       print('200');
//
//       return jsonDecode(response.body);
//
//     } else {
//       throw Exception('Failed');
//     }
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';

class CreateEmailModel {
  static Future<Map<String, dynamic>> createEmail(String email) async {
    // استرجاع التوكن من SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final response = await http.post(
      Uri.parse('$baseURL/api/setEmail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken', // استخدام التوكن المسترجع
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    print(accessToken);
    print('i am in');
    print(response.body);
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'we sent 6 digit code to this email');
      print('200');

      return jsonDecode(response.body);

    } else {

      throw Exception('Failed');
    }
  }
}
