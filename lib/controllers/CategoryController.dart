import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../globals.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var categories = <Category>[].obs;
  var subjects = <Subject>[].obs;
  var favoriteSubjects = <Subject>[].obs;
  var favoriteSubjectIds = <int>[].obs; // تخزين interestedId محلياً

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchFavoriteSubjects();
  }


  void fetchCategories() async {
    isLoading(true);
    // final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
    try {
      var response = await http.get(Uri.parse('$baseURL/api/serviceYearAndSpecialization/showAll'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        categories.value = (data as List).map((json) => Category.fromJson(json)).toList();
      } else {
        print("Failed to load categories");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void fetchSubjects(int categoryId) async {
    isLoading(true);

    try {
      var response = await http.get(
        Uri.parse('$baseURL/api/service/showByYearAndSpecialization/$categoryId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var fetchedSubjects = (data as List).map((json) => Subject.fromJson(json)).toList();

        // تعيين حالة المواد المفضلة
        for (var subject in fetchedSubjects) {
          subject.isFavorite = favoriteSubjects.any((fav) => fav.id == subject.id);
        }

        subjects.value = fetchedSubjects;
      } else {
        print("Failed to load subjects: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void fetchFavoriteSubjects() async {
    isLoading(true);

    try {
      var response = await http.get(
        Uri.parse('$baseURL/api/interestedService/showAll'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        favoriteSubjects.value = (data as List).map((json) => Subject.fromJson(json)).toList();

        // تحديث حالة المواد في القائمة الكاملة
        for (var subject in subjects) {
          subject.isFavorite = favoriteSubjects.any((fav) => fav.id == subject.id);
        }
      } else {
        print("Failed to load favorite subjects");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }


 int interestedId = 0; // تخزين interestedId محلياً

  // إضافة المادة المفضلة
  Future<void> addFavoriteSubject(int subjectId) async {

    try {
      var response = await http.post(
        Uri.parse('$baseURL/api/interestedService/interestInService/$subjectId'), // استبدل بمسار الطلب الخاص بك
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        interestedId = data['id']; // تخزين interestedId محلياً
        fetchFavoriteSubjects();
      } else {
        print("Failed to add favorite subject");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // إلغاء اهتمام المستخدم بالخدمة
  Future<void> removeFavoriteSubject(int subjectId) async {

    try {
      var response = await http.delete(
        Uri.parse('$baseURL/api/interestedService/unInterestInService/$interestedId'), // استبدل بمسار الطلب الخاص بك
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );
      print(interestedId);
      if (response.statusCode == 200) {
        fetchFavoriteSubjects();
      } else {
        print("Failed to remove favorite subject");
      }
    } catch (e) {
      print("Error: $e");
    }
  }



}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['serviceSpecializationName'] ?? 'Unknown',
    );
  }
}

class Subject {
  final int id;
  final String serviceName;
  final List<Child> children;
  bool isFavorite; // الحالة الجديدة

  Subject({required this.id, required this.serviceName, required this.children,this.isFavorite = false});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      serviceName: json['serviceName'],
      children: (json['children'] as List).map((i) => Child.fromJson(i)).toList(),
    );
  }
}

class Child {
  final int id;
  final String serviceName;

  Child({required this.id, required this.serviceName});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      serviceName: json['serviceName'],
    );
  }
}

class InterestedService {
  final int interestedId; // استبدل interestedServiceId بـ interestedId
  final int serviceId;
  final int userId;

  InterestedService({required this.interestedId, required this.serviceId, required this.userId});

  factory InterestedService.fromJson(Map<String, dynamic> json) {
    return InterestedService(
      interestedId: json['id'], // استبدل interestedServiceId بـ interestedId
      serviceId: json['serviceID'],
      userId: json['userID'],
    );
  }
}




////اخر واحد كنت استعملو
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../globals.dart';
//
// class CategoryController extends GetxController {
//   var isLoading = false.obs;
//   var categories = <Category>[].obs;
//   var subjects = <Subject>[].obs;
//   var favoriteSubjects = <Subject>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCategories();
//     fetchFavoriteSubjects();
//   }
//
//
//   void fetchCategories() async {
//     isLoading(true);
//     // final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
//     try {
//       var response = await http.get(Uri.parse('$baseURL/api/serviceYearAndSpecialization/showAll'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         categories.value = (data as List).map((json) => Category.fromJson(json)).toList();
//       } else {
//         print("Failed to load categories");
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void fetchSubjects(int categoryId) async {
//     isLoading(true);
//
//     try {
//       var response = await http.get(
//         Uri.parse('$baseURL/api/service/showByYearAndSpecialization/$categoryId'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         var fetchedSubjects = (data as List).map((json) => Subject.fromJson(json)).toList();
//
//         // دمج حالة المواد المفضلة
//         for (var subject in fetchedSubjects) {
//           subject.isFavorite = favoriteSubjects.any((fav) => fav.id == subject.id);
//         }
//
//         subjects.value = fetchedSubjects;
//       } else {
//         print("Failed to load subjects: ${response.statusCode}");
//         print("Response body: ${response.body}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//
//   Future<void> fetchFavoriteSubjects() async {
//     isLoading(true);
//
//     try {
//       var response = await http.get(Uri.parse('$baseURL/api/interestedService/showAll'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         favoriteSubjects.value = (data as List).map((json) => Subject.fromJson(json)).toList();
//
//         // تحديث حالة المواد في القائمة الكاملة
//         for (var subject in subjects) {
//           subject.isFavorite = favoriteSubjects.any((fav) => fav.id == subject.id);
//         }
//       } else {
//         print("Failed to load favorite subjects");
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//
//   int interestedId = 0; // تخزين interestedId محلياً
//
//   // إضافة المادة المفضلة
//   Future<void> addFavoriteSubject(int subjectId) async {
//
//     try {
//       var response = await http.post(
//         Uri.parse('$baseURL/api/interestedService/interestInService/$subjectId'), // استبدل بمسار الطلب الخاص بك
//         headers: <String, String>{'Authorization': 'Bearer $token'},
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         interestedId = data['id']; // تخزين interestedId محلياً
//         fetchFavoriteSubjects();
//       } else {
//         print("Failed to add favorite subject");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   // إلغاء اهتمام المستخدم بالخدمة
//   Future<void> removeFavoriteSubject(int subjectId) async {
//
//     try {
//       var response = await http.delete(
//         Uri.parse('$baseURL/api/interestedService/unInterestInService/$interestedId'), // استبدل بمسار الطلب الخاص بك
//         headers: <String, String>{'Authorization': 'Bearer $token'},
//       );
//       if (response.statusCode == 200) {
//         fetchFavoriteSubjects();
//       } else {
//         print("Failed to remove favorite subject");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
// }
//
// class Category {
//   final int id;
//   final String name;
//
//   Category({required this.id, required this.name});
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'],
//       name: json['serviceSpecializationName'] ?? 'Unknown',
//     );
//   }
// }
//
// class Subject {
//   final int id;
//   final String serviceName;
//   final List<Child> children;
//   bool isFavorite; // الحالة الجديدة
//
//   Subject({required this.id, required this.serviceName, required this.children,this.isFavorite = false});
//
//   factory Subject.fromJson(Map<String, dynamic> json) {
//     return Subject(
//       id: json['id'],
//       serviceName: json['serviceName'],
//       children: (json['children'] as List).map((i) => Child.fromJson(i)).toList(),
//     );
//   }
// }
//
// class Child {
//   final int id;
//   final String serviceName;
//
//   Child({required this.id, required this.serviceName});
//
//   factory Child.fromJson(Map<String, dynamic> json) {
//     return Child(
//       id: json['id'],
//       serviceName: json['serviceName'],
//     );
//   }
// }
//
// class InterestedService {
//   final int interestedId; // استبدل interestedServiceId بـ interestedId
//   final int serviceId;
//   final int userId;
//
//   InterestedService({required this.interestedId, required this.serviceId, required this.userId});
//
//   factory InterestedService.fromJson(Map<String, dynamic> json) {
//     return InterestedService(
//       interestedId: json['id'], // استبدل interestedServiceId بـ interestedId
//       serviceId: json['serviceID'],
//       userId: json['userID'],
//     );
//   }
// }
//


//كود هظيم للاضافة والحذف
// class CategoryController extends GetxController {
//   var isLoading = false.obs;
//   var categories = <Category>[].obs;
//   var subjects = <Subject>[].obs;
//   var favoriteSubjects = <Subject>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCategories();
//     fetchFavoriteSubjects();
//   }
//
//
//   void fetchCategories() async {
//     isLoading(true);
//     // final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
//     try {
//       var response = await http.get(Uri.parse('$baseURL/api/serviceYearAndSpecialization/showAll'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         categories.value = (data as List).map((json) => Category.fromJson(json)).toList();
//       } else {
//         print("Failed to load categories");
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void fetchSubjects(int categoryId) async {
//     isLoading(true);
//
//     try {
//       var response = await http.get(
//         Uri.parse('$baseURL/api/service/showByYearAndSpecialization/$categoryId'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         subjects.value = (data as List).map((json) => Subject.fromJson(json)).toList();
//       } else {
//         print("Failed to load subjects: ${response.statusCode}");
//         print("Response body: ${response.body}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> fetchFavoriteSubjects() async {
//     isLoading(true);
//
//     try {
//       var response = await http.get(Uri.parse('$baseURL/api/interestedService/showAll'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         favoriteSubjects.value = (data as List).map((json) => Subject.fromJson(json)).toList();
//       } else {
//         print("Failed to load favorite subjects");
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   int interestedId = 0; // تخزين interestedId محلياً
//
//   // إضافة المادة المفضلة
//   Future<void> addFavoriteSubject(int subjectId) async {
//
//     try {
//       var response = await http.post(
//         Uri.parse('$baseURL/api/interestedService/interestInService/$subjectId'), // استبدل بمسار الطلب الخاص بك
//         headers: <String, String>{'Authorization': 'Bearer $token'},
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         interestedId = data['id']; // تخزين interestedId محلياً
//         fetchFavoriteSubjects();
//       } else {
//         print("Failed to add favorite subject");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   // إلغاء اهتمام المستخدم بالخدمة
//   Future<void> removeFavoriteSubject(int subjectId) async {
//
//     try {
//       var response = await http.delete(
//         Uri.parse('$baseURL/api/interestedService/unInterestInService/$interestedId'), // استبدل بمسار الطلب الخاص بك
//         headers: <String, String>{'Authorization': 'Bearer $token'},
//       );
//       if (response.statusCode == 200) {
//         fetchFavoriteSubjects();
//       } else {
//         print("Failed to remove favorite subject");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
// }
//
// class Category {
//   final int id;
//   final String name;
//
//   Category({required this.id, required this.name});
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'],
//       name: json['serviceSpecializationName'] ?? 'Unknown',
//     );
//   }
// }
//
// class Subject {
//   final int id;
//   final String serviceName;
//   final List<Child> children;
//   bool isFavorite; // الحالة الجديدة
//
//   Subject({required this.id, required this.serviceName, required this.children,this.isFavorite = false});
//
//   factory Subject.fromJson(Map<String, dynamic> json) {
//     return Subject(
//       id: json['id'],
//       serviceName: json['serviceName'],
//       children: (json['children'] as List).map((i) => Child.fromJson(i)).toList(),
//     );
//   }
// }
//
// class Child {
//   final int id;
//   final String serviceName;
//
//   Child({required this.id, required this.serviceName});
//
//   factory Child.fromJson(Map<String, dynamic> json) {
//     return Child(
//       id: json['id'],
//       serviceName: json['serviceName'],
//     );
//   }
// }
//
// class InterestedService {
//   final int interestedId; // استبدل interestedServiceId بـ interestedId
//   final int serviceId;
//   final int userId;
//
//   InterestedService({required this.interestedId, required this.serviceId, required this.userId});
//
//   factory InterestedService.fromJson(Map<String, dynamic> json) {
//     return InterestedService(
//       interestedId: json['id'], // استبدل interestedServiceId بـ interestedId
//       serviceId: json['serviceID'],
//       userId: json['userID'],
//     );
//   }
// }

/*import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tired/globals.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var categories = <Category>[].obs;
  var subjects = <Subject>[].obs;
  var favoriteSubjects = <Subject>[].obs;

  @override
  void onInit() {
    super.onInit();

    // تأكد من استدعاء fetchSavedAnnouncements أولاً
    fetchFavoriteSubjects().then((_) {
      fetchCategories();
    });
  }



  void fetchCategories() async {
    isLoading(true);
   // final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
    try {
      var response = await http.get(Uri.parse('$baseURL/api/serviceYearAndSpecialization/showAll'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        categories.value = (data as List).map((json) => Category.fromJson(json)).toList();
      } else {
        print("Failed to load categories");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void fetchSubjects(int categoryId) async {
    isLoading(true);
    try {
      var response = await http.get(
        Uri.parse('$baseURL/api/service/showByYearAndSpecialization/$categoryId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var allSubjects = (data as List).map((json) => Subject.fromJson(json)).toList();

        // تحديث المواد المفضلة
        await fetchFavoriteSubjects();

        // تحقق من المواد المفضلة
        var favoriteIds = favoriteSubjects.map((subject) => subject.id).toList();
        subjects.value = allSubjects.map((subject) {
          if (favoriteIds.contains(subject.id)) {
            subject.isFavorite = true;
          } else {
            subject.isFavorite = false;
          }
          return subject;
        }).toList();
      } else {
        print("Failed to load subjects: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }


  Future<void> fetchFavoriteSubjects() async {
    isLoading(true);
    try {
      var response = await http.get(
        Uri.parse('$baseURL/api/interestedService/showAll'),
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        favoriteSubjects.value = (data as List).map((json) => Subject.fromJson(json)).toList();
      } else {
        print("Failed to load favorite subjects");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  int interestedId = 0; // تخزين interestedId محلياً

  // إضافة المادة المفضلة
  Future<void> addFavoriteSubject(int subjectId) async {

    try {
      var response = await http.post(
        Uri.parse('$baseURL/api/interestedService/interestInService/$subjectId'), // استبدل بمسار الطلب الخاص بك
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        interestedId = data['id']; // تخزين interestedId محلياً
        fetchFavoriteSubjects();
      } else {
        print("Failed to add favorite subject");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // إلغاء اهتمام المستخدم بالخدمة
  Future<void> removeFavoriteSubject(int subjectId) async {

    try {
      var response = await http.delete(
        Uri.parse('$baseURL/api/interestedService/unInterestInService/$interestedId'), // استبدل بمسار الطلب الخاص بك
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        fetchFavoriteSubjects();
      } else {
        print("Failed to remove favorite subject");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['serviceSpecializationName'] ?? 'Unknown',
    );
  }
}

class Subject {
  final int id;
  final String serviceName;
  final List<Child> children;
  bool isFavorite; // الحالة الجديدة

  Subject({required this.id, required this.serviceName, required this.children,this.isFavorite = false});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      serviceName: json['serviceName'],
      children: (json['children'] as List).map((i) => Child.fromJson(i)).toList(),

    );
  }
}

class Child {
  final int id;
  final String serviceName;

  Child({required this.id, required this.serviceName});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      serviceName: json['serviceName'],
    );
  }
}

class InterestedService {
  final int interestedId; // استبدل interestedServiceId بـ interestedId
  final int serviceId;
  final int userId;

  InterestedService({required this.interestedId, required this.serviceId, required this.userId});

  factory InterestedService.fromJson(Map<String, dynamic> json) {
    return InterestedService(
      interestedId: json['id'], // استبدل interestedServiceId بـ interestedId
      serviceId: json['serviceID'],
      userId: json['userID'],
    );
  }
}

*/

//شغال زي العسل
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:tired/globals.dart';
//
// class CategoryController extends GetxController {
//   var isLoading = false.obs;
//   var categories = <Category>[].obs;
//   var subjects = <Subject>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCategories();
//   }
//
//   void fetchCategories() async {
//     isLoading(true);
//     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDk4ZDQ0NGY3NGYxOGNkOTEzM2YyZjU4MTFkNDgwYjM0MDYzNWY0NjY2OTcyYjA3N2RlNDY0M2U0ZWRkMjAwMjQyOTU0M2IyZjU4ZmE1YjYiLCJpYXQiOjE3MTU4NTM2NzYuMTkyMjYzLCJuYmYiOjE3MTU4NTM2NzYuMTkyMjc2LCJleHAiOjE3NDczODk2NzYuMTgwNjc5LCJzdWIiOiIyNiIsInNjb3BlcyI6W119.G96SLA3SmU0nGFL3GoAlJoKFktDyyw-N34L6G3RwNLbWvRUijTq1e8Q3vpsUhabwvcHhUkBDU3eZWfx57dLvIbHJPFVx1eJi4xo9Ue0976GBWOSfr5BHW9RWpWtOItcz5d-doRt5tLI37lCQhOEbCtfObJfVY9tZNWGLqb3P8qYoJZBArZOT7JBMuIcw1FtyO3BtepeEL04tEdjL5MHIGK1_At3yXK4k0xpLwvxEZwKPDQ5fWxQdc1NBguV2Ir22rGX1F2eMejKHNbikaDhOh_8zZojKk5IWVkwTPw77W_OEE-_gK8A0QJMga4gNwx-hRIfnQlL1a1ncDrNqT8MvTC-c6rjsqrndPOqZrfzjZz1zY-EEI5fMxL2NxS260j5Jm78RQUREZ14tTXD_sNsCnJadxY5dI1kB_F6sEyZ55Ac0Nq4Dao0z9J3WXG7-9moYUa8FXKeQHo0HWlqSta9HSQjYO4KaDtwamgGp4Vxo0BVDnvr5HMv-tOC1wCMfA7NQmmBvATO5gJMrJAzPf9lwOPevIXMFnJkHSxC_HdqmU2fXf7fAs3xBzgLWJrAHdi6VSJ2WIn6gF3PZ1TWGT6EuOwe62ru21ljpYIJfoD03rRfK2wkxXzMlUt2xks-o9ksauZ3q3UrdLGqUTwHxZTC6ypWRQgFTym0iDdzG1sQTKHE";
//     try {
//       var response = await http.get(Uri.parse('$baseURL/api/serviceYearAndSpecialization/showAll'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         categories.value = (data as List).map((json) => Category.fromJson(json)).toList();
//       } else {
//         print("Failed to load categories");
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//
//   void fetchSubjects(int categoryId) async {
//     isLoading(true);
//     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDk4ZDQ0NGY3NGYxOGNkOTEzM2YyZjU4MTFkNDgwYjM0MDYzNWY0NjY2OTcyYjA3N2RlNDY0M2U0ZWRkMjAwMjQyOTU0M2IyZjU4ZmE1YjYiLCJpYXQiOjE3MTU4NTM2NzYuMTkyMjYzLCJuYmYiOjE3MTU4NTM2NzYuMTkyMjc2LCJleHAiOjE3NDczODk2NzYuMTgwNjc5LCJzdWIiOiIyNiIsInNjb3BlcyI6W119.G96SLA3SmU0nGFL3GoAlJoKFktDyyw-N34L6G3RwNLbWvRUijTq1e8Q3vpsUhabwvcHhUkBDU3eZWfx57dLvIbHJPFVx1eJi4xo9Ue0976GBWOSfr5BHW9RWpWtOItcz5d-doRt5tLI37lCQhOEbCtfObJfVY9tZNWGLqb3P8qYoJZBArZOT7JBMuIcw1FtyO3BtepeEL04tEdjL5MHIGK1_At3yXK4k0xpLwvxEZwKPDQ5fWxQdc1NBguV2Ir22rGX1F2eMejKHNbikaDhOh_8zZojKk5IWVkwTPw77W_OEE-_gK8A0QJMga4gNwx-hRIfnQlL1a1ncDrNqT8MvTC-c6rjsqrndPOqZrfzjZz1zY-EEI5fMxL2NxS260j5Jm78RQUREZ14tTXD_sNsCnJadxY5dI1kB_F6sEyZ55Ac0Nq4Dao0z9J3WXG7-9moYUa8FXKeQHo0HWlqSta9HSQjYO4KaDtwamgGp4Vxo0BVDnvr5HMv-tOC1wCMfA7NQmmBvATO5gJMrJAzPf9lwOPevIXMFnJkHSxC_HdqmU2fXf7fAs3xBzgLWJrAHdi6VSJ2WIn6gF3PZ1TWGT6EuOwe62ru21ljpYIJfoD03rRfK2wkxXzMlUt2xks-o9ksauZ3q3UrdLGqUTwHxZTC6ypWRQgFTym0iDdzG1sQTKHE";
//     try {
//       var response = await http.get(
//         Uri.parse('$baseURL/api/service/showByYearAndSpecialization/$categoryId'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         subjects.value = (data as List).map((json) => Subject.fromJson(json)).toList();
//         print("Subjects loaded successfully: ${subjects.length} items");
//       } else {
//         print("Failed to load subjects: ${response.statusCode}");
//         print("Response body: ${response.body}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
// }
// class Category {
//   final int id;
//   final String name;
//
//   Category({required this.id, required this.name});
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'] ,
//       name: json['serviceSpecializationName'] ?? 'Unknown',
//     );
//   }
// }
//
// class Subject {
//   final int id;
//   final String serviceName;
//   final List<Child> children;
//
//   Subject({required this.id, required this.serviceName, required this.children});
//
//   factory Subject.fromJson(Map<String, dynamic> json) {
//     return Subject(
//       id: json['id'],
//       serviceName: json['serviceName'],
//       children: (json['children'] as List).map((i) => Child.fromJson(i)).toList(),
//     );
//   }
// }
//
// class Child {
//   final int id;
//   final String serviceName;
//
//   Child({required this.id, required this.serviceName});
//
//   factory Child.fromJson(Map<String, dynamic> json) {
//     return Child(
//       id: json['id'],
//       serviceName: json['serviceName'],
//     );
//   }
// }
//
//
