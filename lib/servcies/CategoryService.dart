import 'dart:convert';
import 'package:http/http.dart' as http;

import '../controllers/CategoryController.dart';


class CategoryService {
  Future<List<Category>> fetchCategories() async {
    final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDk4ZDQ0NGY3NGYxOGNkOTEzM2YyZjU4MTFkNDgwYjM0MDYzNWY0NjY2OTcyYjA3N2RlNDY0M2U0ZWRkMjAwMjQyOTU0M2IyZjU4ZmE1YjYiLCJpYXQiOjE3MTU4NTM2NzYuMTkyMjYzLCJuYmYiOjE3MTU4NTM2NzYuMTkyMjc2LCJleHAiOjE3NDczODk2NzYuMTgwNjc5LCJzdWIiOiIyNiIsInNjb3BlcyI6W119.G96SLA3SmU0nGFL3GoAlJoKFktDyyw-N34L6G3RwNLbWvRUijTq1e8Q3vpsUhabwvcHhUkBDU3eZWfx57dLvIbHJPFVx1eJi4xo9Ue0976GBWOSfr5BHW9RWpWtOItcz5d-doRt5tLI37lCQhOEbCtfObJfVY9tZNWGLqb3P8qYoJZBArZOT7JBMuIcw1FtyO3BtepeEL04tEdjL5MHIGK1_At3yXK4k0xpLwvxEZwKPDQ5fWxQdc1NBguV2Ir22rGX1F2eMejKHNbikaDhOh_8zZojKk5IWVkwTPw77W_OEE-_gK8A0QJMga4gNwx-hRIfnQlL1a1ncDrNqT8MvTC-c6rjsqrndPOqZrfzjZz1zY-EEI5fMxL2NxS260j5Jm78RQUREZ14tTXD_sNsCnJadxY5dI1kB_F6sEyZ55Ac0Nq4Dao0z9J3WXG7-9moYUa8FXKeQHo0HWlqSta9HSQjYO4KaDtwamgGp4Vxo0BVDnvr5HMv-tOC1wCMfA7NQmmBvATO5gJMrJAzPf9lwOPevIXMFnJkHSxC_HdqmU2fXf7fAs3xBzgLWJrAHdi6VSJ2WIn6gF3PZ1TWGT6EuOwe62ru21ljpYIJfoD03rRfK2wkxXzMlUt2xks-o9ksauZ3q3UrdLGqUTwHxZTC6ypWRQgFTym0iDdzG1sQTKHE";
    final response = await http.get(
      Uri.parse('http://192.168.137.216:8000/api/serviceYearAndSpecialization/showAll'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
     print('i am in');
    if (response.statusCode == 200) {
      print('done');
      List<dynamic> data = json.decode(response.body);
      print(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}

