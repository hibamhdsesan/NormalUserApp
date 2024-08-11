// controller/group_controller.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart';
import 'GroupModel.dart';

class GroupController {
  Future<List<Group>> fetchGroups(int serviceId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final response = await http.get(
      Uri.parse('$baseURL/api/group/showAll/$serviceId'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );
    print(serviceId);
    print("url is true");

    if (response.statusCode == 200) {
      print("200");
      List<dynamic> body = jsonDecode(response.body);
      List<Group> groups = body.map((dynamic item) => Group.fromJson(item)).toList();
      return groups;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load groups');
    }
  }
}
