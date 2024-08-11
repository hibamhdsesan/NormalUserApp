import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../globals.dart';
import '../../model/service_model.dart';

class ServiceController extends GetxController {
  var services = <Service>[].obs;
  var isLoading = true.obs;
  String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYzUwMzgyYzcyZTRjNGExZmM5ZTk3M2VlZjc0NDI5N2M1MWJkNTM5NmY5NWRiYjM2NTA4MzM1MmViMDlhNDVlZTNlYjhiMjgyZTc3ZTU1NTYiLCJpYXQiOjE3MTgzMDk3MzUuNDUzODgsIm5iZiI6MTcxODMwOTczNS40NTM4ODMsImV4cCI6MTc0OTg0NTczNS40NDI5NDgsInN1YiI6IjEzIiwic2NvcGVzIjpbXX0.fqJGYA6INaIAgzcqINGB5jQKDtqjGpmVjCppzwP7HWhXpbGqGdK1tUEpfZxFN0xAiZYq2S0grPjaRou9Ks3Ol7hghjUPzu2oPlYK-v5c4wX8zW3QGQyVG8JRxPJRj4EK0RDq3SW_kYuFhh2RZ0MZPHnXR-ICsMXMTKWCvBXe9lqTW8odBlpgnNYQ4Dlgfd_L4DzrO1plIojihglv4yqH5ar7RyCMYtWXKItxfy0-8CDZNQ26sbvaSsCe2gbzdUJ-hF2Oak4oQIiGkZQxq6wFzsPYiib7gO1deIh2kemss3Se3DPOkuQu6vmEBA-p4H35Iw9nhxORSEgSjFH8KXUAqUPDzf0AYfBwQOzwgbtgU9xb6QngjchhgO6IPcmpBKWdNU5KH3VnAPpV4L8cn2vRDn_EuvGhD3UKU_JyRqZvmPygGh5gfg356z3J4-BnRC_aU4wjx6RF1AVrYzdsPfP85rh7Hw83zcADLOloKDwHG7x3RwIq23ZOULLJjIrrlNBTyPFb7PnBKqN940tT0Cs2pLRmZvNi6svm-B2bYUEDswdaOf_3AWpC-6_JoHB_8FdAmrmgADSEBF1cRCKyY1lS7iIGz5mXOMZN1UH9bnamktKfd9Zbi_Kz3EFUGavYqEMC-twzNGE6EWdqAR2UM6xsc8rWKe70z6k5T2MYm6gbeK8';
  var searchResults = <Service>[].obs;

  /*Future<void> searchServices(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('$baseURL/api/service/searchForAdvancedUser?serviceName=$query'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List;
        searchResults.value = jsonData.map((json) => Service.fromJson(json)).toList();
      } else {
        print(response.body);
      }
    } finally {
      isLoading(false);
    }
  }*/
  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  Future<void> fetchServices() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://192.168.1.105:8000/api/service/showMyFromAdvancedUser'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      print('i am in');

      if (response.statusCode == 200) {
        print('200');
        List<dynamic> jsonData = json.decode(response.body);
        var fetchedServices = jsonData.map((data) => Service.fromJson(data)).toList();
        services.assignAll(fetchedServices);
      } else {
        print(response.body);
        Get.snackbar('Error', 'Failed to load data');

      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading(false);
    }
  }
}
