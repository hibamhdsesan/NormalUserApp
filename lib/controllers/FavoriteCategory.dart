//تخبيص
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// import '../globals.dart';
//
// class FavoriteController extends GetxController {
//   var subjects = <Subject>[].obs;
//   var categories = <Category>[].obs;
//   RxList<FavoriteSubject> favoriteSubjects = <FavoriteSubject>[].obs;
//   var isLoading = true.obs;
//   var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0'; // ضع التوكن هنا
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchFavoriteSubjects().then((_) {
//       fetchCategories();
//     });
//   }
//
//   void toggleFavoriteSubject(int index) {
//     var subject = subjects[index];
//     if (subject.isFavorite) {
//       var favoriteSubject = favoriteSubjects.firstWhereOrNull((fav) => fav.subjectID == subject.id);
//       if (favoriteSubject != null) {
//         unfavoriteSubject(favoriteSubject.id);
//       } else {
//         Get.snackbar('Error', 'Cannot unfavorite subject, favoriteSubject not found');
//       }
//     } else {
//       favoriteSubject(subject.id).then((favoriteSubjectID) {
//         if (favoriteSubjectID != null) {
//           subject.isFavorite = true;
//           subjects[index] = subject; // Force UI update
//           subjects.refresh(); // Refresh the list to update UI
//         }
//       });
//     }
//   }
//
//   void fetchCategories() async {
//     isLoading(true);
//     try {
//       var response = await http.get(
//         Uri.parse('$baseURL/api/serviceYearAndSpecialization/showAll'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         categories.value =
//             (data as List).map((json) => Category.fromJson(json)).toList();
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
//     try {
//       isLoading(true);
//       var response = await http.get(
//         Uri.parse(
//             '$baseURL/api/service/showByYearAndSpecialization/$categoryId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body);
//         if (jsonData != null) {
//           subjects.value =
//               (jsonData as List).map((i) => Subject.fromJson(i)).toList();
//           updateFavoriteStatus();
//         } else {
//           subjects.value = [];
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to fetch subjects');
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> fetchFavoriteSubjects() async {
//     try {
//       isLoading(true);
//       var response = await http.get(
//         Uri.parse('$baseURL/api/interestedService/showAll'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body);
//         print("Response JSON: $jsonData");
//         if (jsonData != null) {
//           favoriteSubjects.assignAll(
//             (jsonData as List)
//                 .map((i) {
//               try {
//                 return FavoriteSubject.fromJson(i);
//               } catch (e) {
//                 print('Error parsing favorite subject: $e, Data: $i');
//                 return null;
//               }
//             })
//                 .where((e) => e != null)
//                 .cast<FavoriteSubject>()
//                 .toList(),
//           );
//           updateFavoriteStatus();
//         } else {
//           favoriteSubjects.value = [];
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to fetch favorite subjects');
//       }
//     } catch (e) {
//       print("Error: $e");
//       Get.snackbar('Error', 'An error occurred');
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void updateFavoriteStatus() {
//     for (var subject in subjects) {
//       var favoriteSubject = favoriteSubjects.firstWhereOrNull((fav) => fav.subjectID == subject.id);
//       if (favoriteSubject != null) {
//         subject.isFavorite = true;
//       } else {
//         subject.isFavorite = false;
//       }
//     }
//   }
//
//   Future<int?> favoriteSubject(int subjectID) async {
//     try {
//       var response = await http.post(
//         Uri.parse('$baseURL/api/interestedService/interestInService/$subjectID'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       print("Response status: ${response.statusCode}");
//       print("Response body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         var savedData = json.decode(response.body);
//
//         // تحقق من وجود جميع القيم المطلوبة في الاستجابة
//         if (savedData != null && savedData['id'] != null && savedData['userID'] != null && savedData['serviceID'] != null) {
//           var favoriteSubject = FavoriteSubject(
//             id: savedData['id'],
//             userID: savedData['userID'],
//             subjectID: savedData['serviceID'],
//             createdAt: savedData['created_at'],
//             updatedAt: savedData['updated_at'],
//             subject: subjects.firstWhere((subject) => subject.id == savedData['serviceID']),
//           );
//
//           favoriteSubjects.add(favoriteSubject);
//           updateFavoriteStatus();
//           Get.snackbar('Success', 'Subject favorited successfully');
//           return savedData['id']; // Return the favoriteSubjectID
//         } else {
//           Get.snackbar('Error', 'Invalid response data');
//           return null;
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to favorite subject');
//         return null;
//       }
//     } catch (e) {
//       print("Error: $e");
//       Get.snackbar('Error', 'An error occurred');
//       return null;
//     }
//   }
//
//   void unfavoriteSubject(int favoriteSubjectID) async {
//     try {
//       var response = await http.delete(
//         Uri.parse('$baseURL/api/interestedService/unInterestInService/$favoriteSubjectID'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         // احذف المادة المفضلة من القائمة
//         var favoriteSubject = favoriteSubjects.firstWhere((fav) => fav.id == favoriteSubjectID);
//         favoriteSubjects.removeWhere((fav) => fav.id == favoriteSubjectID);
//
//         // تحديث حالة التفضيل للمادة المرتبطة
//         var subject = subjects.firstWhere((sub) => sub.id == favoriteSubject.subjectID);
//         subject.isFavorite = false;
//         // أجبر تحديث واجهة المستخدم
//         subjects.refresh();
//
//         updateFavoriteStatus();
//         Get.snackbar('Success', 'Subject unfavorited successfully');
//       } else {
//         Get.snackbar('Error', 'Failed to unfavorite subject');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred while trying to unfavorite the subject');
//     }
//   }
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
//   bool isFavorite;
//
//   Subject({required this.id, required this.serviceName, required this.children, this.isFavorite = false});
//
//   factory Subject.fromJson(Map<String, dynamic> json) {
//     return Subject(
//       id: json['id'],
//       serviceName: json['serviceName'],
//       children: (json['children'] as List).map((i) => Child.fromJson(i)).toList(),
//       isFavorite: json['isFavorite'] ?? false,
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
// class FavoriteSubject {
//   final int id;
//   final int userID;
//   final int subjectID;
//   final String createdAt;
//   final String updatedAt;
//   final Subject subject;
//
//   FavoriteSubject({
//     required this.id,
//     required this.userID,
//     required this.subjectID,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.subject,
//   });
//
//   factory FavoriteSubject.fromJson(Map<String, dynamic> json) {
//     if (json['id'] == null || json['userID'] == null || json['serviceID'] == null || json['service'] == null) {
//       throw Exception("Invalid JSON data: $json");
//     }
//
//     return FavoriteSubject(
//       id: json['id'],
//       userID: json['userID'],
//       subjectID: json['serviceID'],
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//       subject: Subject.fromJson(json['service']),
//     );
//   }
// }



//صدمة كبيرة
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart';

class FavoriteController extends GetxController {
  var subjects = <Subject>[].obs;
  var categories = <Category>[].obs;
  RxList<FavoriteSubject> favoriteSubjects = <FavoriteSubject>[].obs;
  var isLoading = true.obs;
  //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0'; // ضع التوكن هنا

  @override
  void onInit() {
    super.onInit();
    fetchFavoriteSubjects().then((_) {
      fetchCategories();
    });
  }
//مية المية
  // void toggleFavoriteSubject(int index) {
  //   var subject = subjects[index];
  //   if (subject.isFavorite) {
  //     var favoriteSubject = favoriteSubjects.firstWhereOrNull((fav) => fav.subjectID == subject.id);
  //     if (favoriteSubject != null) {
  //       unfavoriteSubject(favoriteSubject.id);
  //     } else {
  //       Get.snackbar('Error', 'Cannot unfavorite subject, favoriteSubject not found');
  //     }
  //   } else {
  //     favoriteSubject(subject.id).then((favoriteSubjectID) {
  //       if (favoriteSubjectID != null) {
  //         subject.isFavorite = true;
  //         subjects[index] = subject; // Force UI update
  //       }
  //     });
  //   }
  // }
  void toggleFavoriteSubject(int index) {
    var subject = subjects[index];
    if (subject.isFavorite) {
      var favoriteSubject = favoriteSubjects.firstWhereOrNull((fav) => fav.subjectID == subject.id);
      if (favoriteSubject != null) {
        unfavoriteSubject(favoriteSubject.id);
      } else {
        Get.snackbar('Error', 'Cannot unfavorite subject, favoriteSubject not found');
      }
    } else {
      favoriteSubject(subject.id).then((favoriteSubjectID) {
        if (favoriteSubjectID != null) {
          subject.isFavorite = true;
          subjects[index] = subject; // Force UI update
          subjects.refresh(); // Refresh the list to update UI
        }
      });
    }
  }



  void fetchCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading(true);
    try {
      var response = await http.get(
        Uri.parse('$baseURL/api/serviceYearAndSpecialization/showAll'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        categories.value =
            (data as List).map((json) => Category.fromJson(json)).toList();
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
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(
            '$baseURL/api/service/showByYearAndSpecialization/$categoryId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData != null) {
          subjects.value =
              (jsonData as List).map((i) => Subject.fromJson(i)).toList();
          updateFavoriteStatus();
        } else {
          subjects.value = [];
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch subjects');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchFavoriteSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('$baseURL/api/interestedService/showAll'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData != null) {
          favoriteSubjects.assignAll((jsonData as List)
              .map((i) => FavoriteSubject.fromJson(i))
              .toList());
          updateFavoriteStatus();
        } else {
          favoriteSubjects.value = [];
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch favorite subjects');
      }
    } finally {
      isLoading(false);
    }
  }

  void updateFavoriteStatus() {
    for (var subject in subjects) {
      var favoriteSubject = favoriteSubjects.firstWhereOrNull((fav) => fav.subjectID == subject.id);
      if (favoriteSubject != null) {
        subject.isFavorite = true;
      } else {
        subject.isFavorite = false;
      }
    }
  }


  // Future<int?> favoriteSubject(int subjectID) async {
  //   var response = await http.post(
  //     Uri.parse('$baseURL/api/interestedService/interestInService/$subjectID'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     var savedData = json.decode(response.body);
  //     var favoriteSubject = FavoriteSubject(
  //       id: savedData['id'],
  //       userID: savedData['userID'],
  //       subjectID: savedData['subjectID'],
  //       createdAt: savedData['created_at'],
  //       updatedAt: savedData['updated_at'],
  //       subject: subjects.firstWhere((subject) => subject.id == subjectID),
  //     );
  //     favoriteSubjects.add(favoriteSubject);
  //     updateFavoriteStatus();
  //     Get.snackbar('Success', 'Subject favorited successfully');
  //     return savedData['id']; // Return the favoriteSubjectID
  //   } else {
  //     Get.snackbar('Error', 'Failed to favorite subject');
  //     return null;
  //   }
  // }
  Future<int?> favoriteSubject(int subjectID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.post(
        Uri.parse('$baseURL/api/interestedService/interestInService/$subjectID'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var savedData = json.decode(response.body);

        // تحقق من وجود جميع القيم المطلوبة في الاستجابة
        if (savedData != null && savedData['id'] != null && savedData['userID'] != null && savedData['serviceID'] != null) {
          var favoriteSubject = FavoriteSubject(
            id: savedData['id'],
            userID: savedData['userID'],
            subjectID: savedData['serviceID'],
            createdAt: savedData['created_at'],
            updatedAt: savedData['updated_at'],
            subject: subjects.firstWhere((subject) => subject.id == savedData['serviceID']),
          );

          favoriteSubjects.add(favoriteSubject);
          updateFavoriteStatus();
          Get.snackbar('Success', 'Subject favorited successfully');
          return savedData['id']; // Return the favoriteSubjectID
        } else {
          Get.snackbar('Error', 'Invalid response data');
          return null;
        }
      } else {
        Get.snackbar('Error', 'Failed to favorite subject');
        return null;
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', 'An error occurred');
      return null;
    }
  }

  void unfavoriteSubject(int favoriteSubjectID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.delete(
        Uri.parse('$baseURL/api/interestedService/unInterestInService/$favoriteSubjectID'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        // احذف المادة المفضلة من القائمة
        var favoriteSubject = favoriteSubjects.firstWhere((fav) => fav.id == favoriteSubjectID);
        favoriteSubjects.removeWhere((fav) => fav.id == favoriteSubjectID);

        // تحديث حالة التفضيل للمادة المرتبطة
        var subject = subjects.firstWhere((sub) => sub.id == favoriteSubject.subjectID);
        subject.isFavorite = false;
        // أجبر تحديث واجهة المستخدم
        subjects.refresh();

        updateFavoriteStatus();
        Get.snackbar('Success', 'Subject unfavorited successfully');
      } else {
        Get.snackbar('Error', 'Failed to unfavorite subject');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while trying to unfavorite the subject');
    }
  }

}

class Category {
  final int id;
  final String name;
  final String serviceYear;

  Category({required this.id, required this.name, required this.serviceYear});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['serviceSpecializationName'] ?? 'Unknown',
        serviceYear:json['serviceYear'],
    );
  }
}

class Subject {
  final int id;
  final String serviceName;
  final List<Child> children;
  bool isFavorite;

  Subject({required this.id, required this.serviceName, required this.children, this.isFavorite = false});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      serviceName: json['serviceName'],
      children: (json['children'] as List).map((i) => Child.fromJson(i)).toList(),
      isFavorite: json['isFavorite'] ?? false,
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

class FavoriteSubject {
  final int id;
  final int userID;
  final int subjectID;
  final String createdAt;
  final String updatedAt;
  final Subject subject;

  FavoriteSubject({
    required this.id,
    required this.userID,
    required this.subjectID,
    required this.createdAt,
    required this.updatedAt,
    required this.subject,
  });

  factory FavoriteSubject.fromJson(Map<String, dynamic> json) {
    return FavoriteSubject(
      id: json['id'],
      userID: json['userID'],
      subjectID: json['serviceID'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      subject: Subject.fromJson(json['service']),
    );
  }
}

/*class FavoriteController extends GetxController {
  var subjects = <Subject>[].obs;
  var categories = <Category>[].obs;
  RxList<FavoriteSubject> favoriteSubjects = <FavoriteSubject>[].obs;
  var isLoading = true.obs;
  var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0'; // ضع التوكن هنا

  @override
  void onInit() {
    super.onInit();
    fetchFavoriteSubjects().then((_) {
      fetchCategories();
    });
  }

  void toggleFavoriteSubject(int index) {
    var subject = subjects[index];
    if (subject.isFavorite) {
      if (subject.id != null) {
        unfavoriteSubject(subject.id);
      } else {
        Get.snackbar('Error', 'Cannot unfavorite subject, missing subjectID');
      }
    } else {
      favoriteSubject(subject.id).then((favoriteSubjectID) {
        subject.isFavorite = true;
        subjects[index] = subject; // Force UI update
      });
    }
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
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('$baseURL/api/service/showByYearAndSpecialization/$categoryId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData != null) {
          subjects.value = (jsonData as List).map((i) => Subject.fromJson(i)).toList();
          updateFavoriteStatus();
        } else {
          subjects.value = [];
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch subjects');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchFavoriteSubjects() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('$baseURL/api/interestedService/showAll'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData != null) {
          favoriteSubjects.assignAll((jsonData as List).map((i) => FavoriteSubject.fromJson(i)).toList());
          updateFavoriteStatus();
        } else {
          favoriteSubjects.value = [];
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch favorite subjects');
      }
    } finally {
      isLoading(false);
    }
  }

  void updateFavoriteStatus() {
    for (var subject in subjects) {
      var favoriteSubject = favoriteSubjects.firstWhereOrNull((fav) => fav.subjectID == subject.id);
      if (favoriteSubject != null) {
        subject.isFavorite = true;
      } else {
        subject.isFavorite = false;
      }
    }
  }

  Future<int?> favoriteSubject(int subjectID) async {
    var response = await http.post(
      Uri.parse('$baseURL/api/interestedService/interestInService/$subjectID'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var savedData = json.decode(response.body);
      var favoriteSubject = FavoriteSubject(
        id: savedData['id'],
        userID: savedData['userID'],
        subjectID: savedData['subjectID'],
        createdAt: savedData['created_at'],
        updatedAt: savedData['updated_at'],
        subject: subjects.firstWhere((subject) => subject.id == subjectID),
      );
      favoriteSubjects.add(favoriteSubject);
      updateFavoriteStatus();
      Get.snackbar('Success', 'Subject favorited successfully');
      return savedData['id']; // Return the favoriteSubjectID
    } else {
      Get.snackbar('Error', 'Failed to favorite subject');
      return null;
    }
  }

  void unfavoriteSubject(int favoriteSubjectID) async {
    try {
      var response = await http.delete(
        Uri.parse('$baseURL/api/interestedService/unInterestInService/$favoriteSubjectID'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        favoriteSubjects.removeWhere((fav) => fav.id == favoriteSubjectID);
        updateFavoriteStatus();
        Get.snackbar('Success', 'Subject unfavorited successfully');
      } else {
        Get.snackbar('Error', 'Failed to unfavorite subject');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while trying to unfavorite the subject');
    }
  }
}*/
/*class Category {
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

  Subject({required this.id, required this.serviceName, required this.children, this.isFavorite = false});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      serviceName: json['serviceName'],
      children: (json['children'] as List).map((i) => Child.fromJson(i)).toList(),
      isFavorite: json['isFavorite'] ?? false,
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

class FavoriteSubject {
  final int id;
  final int userID;
  final int subjectID;
  final String createdAt;
  final String updatedAt;
  final Subject subject;

  FavoriteSubject({
    required this.id,
    required this.userID,
    required this.subjectID,
    required this.createdAt,
    required this.updatedAt,
    required this.subject,
  });

  factory FavoriteSubject.fromJson(Map<String, dynamic> json) {
    return FavoriteSubject(
      id: json['id'],
      userID: json['userID'],
      subjectID: json['serviceID'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      subject: Subject.fromJson(json['service']),
    );
  }
}*/

/* void updateFavoriteStatus() {
    for (var subject in subjects) {
      var favoriteSubject = favoriteSubjects.firstWhereOrNull((fav) =>
      fav.subjectID == subject.id);
      if (favoriteSubject != null) {
        subject.isFavorite = true;
      } else {
        subject.isFavorite = false;
      }
    }
  }*/

//شغال
/* void unfavoriteSubject(int favoriteSubjectID) async {
    try {
      var response = await http.delete(
        Uri.parse(
            '$baseURL/api/interestedService/unInterestInService/$favoriteSubjectID'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        favoriteSubjects.removeWhere((fav) => fav.id == favoriteSubjectID);
        updateFavoriteStatus();
        Get.snackbar('Success', 'Subject unfavorited successfully');
      } else {
        Get.snackbar('Error', 'Failed to unfavorite subject');
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'An error occurred while trying to unfavorite the subject');
    }
  }*/

/* void toggleFavoriteSubject(int index) {
    var subject = subjects[index];
    if (subject.isFavorite) {
      if (subject.id != null) {
        unfavoriteSubject(subject.id);  // تأكد من وجود id
      } else {
        Get.snackbar('Error', 'Cannot unfavorite subject, missing subjectID');
      }
    } else {
      favoriteSubject(subject.id).then((favoriteSubjectID) {  // تأكد من وجود id
        if (favoriteSubjectID != null) {
          subject.isFavorite = true;
          subjects[index] = subject; // Force UI update
        }
      });
    }
  }*/
//شغال
// void toggleFavoriteSubject(int index) {
//   var subject = subjects[index];
//   if (subject.isFavorite) {
//     // الحصول على معرف المادة المفضلة
//     var favoriteSubject = favoriteSubjects.firstWhereOrNull((fav) =>
//     fav.subjectID == subject.id);
//     if (favoriteSubject != null) {
//       unfavoriteSubject(favoriteSubject
//           .id); // إرسال معرف المادة المفضلة بدلاً من معرف المادة
//     } else {
//       Get.snackbar(
//           'Error', 'Cannot unfavorite subject, favoriteSubject not found');
//     }
//   } else {
//     favoriteSubject(subject.id).then((favoriteSubjectID) {
//       if (favoriteSubjectID != null) {
//         subject.isFavorite = true;
//         subjects[index] = subject; // Force UI update
//       }
//     });
//   }
// }

//   void unfavoriteSubject(int favoriteSubjectID) async {
//     try {
//       var response = await http.delete(
//         Uri.parse('$baseURL/api/interestedService/unInterestInService/$favoriteSubjectID'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       print(favoriteSubjectID);
//       if (response.statusCode == 200) {
//         favoriteSubjects.removeWhere((fav) => fav.id == favoriteSubjectID);
//         updateFavoriteStatus();
//         Get.snackbar('Success', 'Subject unfavorited successfully');
//       } else {
//         Get.snackbar('Error', 'Failed to unfavorite subject');
//         print(response.body);
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred while trying to unfavorite the subject');
//     }
//   }
