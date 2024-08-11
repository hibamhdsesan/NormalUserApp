import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart';
import '../model/Newannouncement_model.dart';
import 'package:http/http.dart' as http;

class AnnouncementController extends GetxController {
  var announcements = <Announcement>[].obs;
  RxList<SavedAnnouncement> savedAnnouncements = <SavedAnnouncement>[].obs;
  RxList<Announcement> myAnnouncements = <Announcement>[].obs;

  var isLoading = true.obs;
  //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0';
//String token='eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDc3MDEzYzM2OGM3OGQ3ODI1ODE1MWI3MGYwN2ZkNjY4NDI0ODk5MzVhN2FhYTM0ODg4MzcxYTdkNmVhY2E5NjlhOGVjYTkxYzJmZDBlNjUiLCJpYXQiOjE3MTgzMjg5NzguMTkzNTg0LCJuYmYiOjE3MTgzMjg5NzguMTkzNTksImV4cCI6MTc0OTg2NDk3OC4xODQwMjQsInN1YiI6IjEwIiwic2NvcGVzIjpbXX0.EAVjcUXkJr9hu4GaBgWOCVpa8PNGUw61QfpKlYYZpAIgfPfwgChy7CI8p9YFmLVK4gUygTMTDm_vtxT59Noez73opivX44j8CqTa-B5gXmiI20UtAomgU4UB-Hb6tBlxvWvkjmNhAXKqoRKKd6X3FoK2rw7Bri0-wWDleMZ-1Xrwz1oaJlE9iNLFNHN5Zmn_ph4zLJt6zAlUkhI-SZ_mNzFL9mn9sS6bb-pfhokf8D_Q2Je7u0hOgSXnhGN_nIK7x56RViTuPeQr-LWk3EWUrZXheI1V7cOPV5jMFrAj6GIO78AUuX7m-QN_nQKpnOFuUv3GjeRof8dgK9u1cF4JWnr6QI-LpFNvzj6CdvAWmo-uEgjztioj6HWrycVbzFRxQHy8j5_Ni-VqZeCPBugNqDz8fA3czBvraO1dtPVJQiEQpnzL5XSaVaTl3O';
  @override

  void onInit() {
    super.onInit();

    // تأكد من استدعاء fetchSavedAnnouncements أولاً
    fetchSavedAnnouncements().then((_) {
      fetchAnnouncements();
      fetchMyAnnouncements();
    });
  }

  void toggleSaveAnnouncement(int index) {
    var announcement = announcements[index];
    if (announcement.isSaved) {
      if (announcement.savedAnnouncementID != null) {
        unsaveAnnouncement(announcement.savedAnnouncementID!);
      } else {
        Get.snackbar('Error', 'Cannot unsave announcement, missing savedAnnouncementID');
      }
    } else {
      saveAnnouncement(announcement.id).then((savedAnnouncementID) {
        announcement.isSaved = true;
        announcement.savedAnnouncementID = savedAnnouncementID;
        announcements[index] = announcement; // Force UI update
      });
    }
  }
//دهب
  // void fetchAnnouncements() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final accessToken = prefs.getString('accessToken');
  //   try {
  //     isLoading(true);
  //     var response = await http.get(
  //       Uri.parse('$baseURL/api/announcement/showAll/'),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       print('announcement');
  //       var jsonData = json.decode(response.body);
  //       if (jsonData != null) {
  //         announcements.value = (jsonData as List).map((i) => Announcement.fromJson(i)).toList();
  //         updateSavedStatus(); // تأكد من تحديث حالة الإعلانات بعد تحميلها
  //       } else {
  //         announcements.value = [];
  //
  //       }
  //     } else {
  //       print(response.body);
  //       Get.snackbar('Error', 'Failed to fetch announcements');
  //
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  void fetchAnnouncements() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('$baseURL/api/announcement/showAll/'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        print('announcement');
        var jsonData = json.decode(response.body);
        if (jsonData != null) {
          // طباعة البيانات المستلمة للتحقق من معلومات الملفات
          print('Response Data: $jsonData');
          announcements.value = (jsonData as List).map((i) => Announcement.fromJson(i)).toList();
          updateSavedStatus(); // تأكد من تحديث حالة الإعلانات بعد تحميلها
        } else {
          announcements.value = [];
        }
      } else {
        print(response.body);
        Get.snackbar('Error', 'Failed to fetch announcements');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSavedAnnouncements() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('$baseURL/api/savedAnnouncement/showAll'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      print('i am in');
      if (response.statusCode == 200) {
        print('saved');
        var jsonData = json.decode(response.body);
        if (jsonData != null) {
          savedAnnouncements.assignAll((jsonData as List).map((i) => SavedAnnouncement.fromJson(i)).toList());
          updateSavedStatus(); // تأكد من تحديث حالة الإعلانات بعد تحميل الإعلانات المحفوظة
        } else {
          savedAnnouncements.value = [];
        }
      } else {
        print(response.body);
        Get.snackbar('Error', 'Failed to fetch saved announcements');
      }
    } finally {
      isLoading(false);
    }
  }

  void updateSavedStatus() {
    for (var announcement in announcements) {
      var savedAnnouncement = savedAnnouncements.firstWhereOrNull((saved) => saved.announcementID == announcement.id);
      if (savedAnnouncement != null) {
        announcement.isSaved = true;
        announcement.savedAnnouncementID = savedAnnouncement.id;
      } else {
        announcement.isSaved = false;
        announcement.savedAnnouncementID = null;
      }
    }
  }

  Future<int?> saveAnnouncement(int announcementID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    var response = await http.post(
      Uri.parse('$baseURL/api/savedAnnouncement/save/$announcementID'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      var savedData = json.decode(response.body);
      var savedAnnouncement = SavedAnnouncement(
        id: savedData['id'],
        userID: savedData['userID'],
        announcementID: savedData['announcementID'],
        createdAt: savedData['created_at'],
        updatedAt: savedData['updated_at'],
        announcement: announcements.firstWhere((announcement) => announcement.id == announcementID),
      );
      savedAnnouncements.add(savedAnnouncement);
      updateSavedStatus();
      Get.snackbar('Success', 'Announcement saved successfully');
      return savedData['id']; // Return the savedAnnouncementID
    } else {
      Get.snackbar('Error', 'Failed to save announcement');
      return null;
    }
  }

  void unsaveAnnouncement(int savedAnnouncementID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.delete(
        Uri.parse('$baseURL/api/savedAnnouncement/unSave/$savedAnnouncementID'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        savedAnnouncements.removeWhere((saved) => saved.id == savedAnnouncementID);

        // تحديث حالة الإعلانات هنا
        for (var i = 0; i < announcements.length; i++) {
          if (announcements[i].savedAnnouncementID == savedAnnouncementID) {
            announcements[i].isSaved = false;
            announcements[i].savedAnnouncementID = null;
            announcements[i] = announcements[i];
          }
        }

        updateSavedStatus();
        Get.snackbar('Success', 'Announcement unsaved successfully');
      } else {
        Get.snackbar('Error', 'Failed to unsave announcement');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while trying to unsave the announcement');
    }
  }

  // Future<void> addAnnouncement(String title, String description, int serviceID) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final accessToken = prefs.getString('accessToken');
  //   try {
  //     var response = await http.post(
  //       Uri.parse('$baseURL/api/announcement/add/'),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         "Content-Type": "application/json",
  //       },
  //       body: json.encode({
  //         'title': title,
  //         'description': description,
  //         'serviceID': serviceID,
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       print('200');
  //       var jsonData = json.decode(response.body);
  //       var newAnnouncement = Announcement.fromJson(jsonData);
  //       myAnnouncements.add(newAnnouncement);
  //       fetchAnnouncements(); // لتحديث قائمة الإعلانات العامة
  //     } else{
  //       print(response.body);
  //     }
  //   } catch (e) {
  //
  //     print("Error adding announcement: $e");
  //   }
  // }
  /*Future<void> addAnnouncement(String title, String description, int serviceID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.post(
        Uri.parse('$baseURL/api/announcement/add/'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          "Content-Type": "application/json",
        },
        body: json.encode({
          'title': title,
          'description': description,
          'serviceID': serviceID,
        }),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        print('200');
        if (response.body.isNotEmpty) {
          var jsonData = json.decode(response.body);
          var newAnnouncement = Announcement.fromJson(jsonData);
          myAnnouncements.add(newAnnouncement);
          fetchAnnouncements(); // لتحديث قائمة الإعلانات العامة
        } else {
          print("Error: Empty response body");
        }
      } else {
        print(response.body);
      }
    } catch (e) {
      print("Error adding announcement: $e");
    }
  }*/
//add without file
//   Future<void> addAnnouncement(String title, String description, int? serviceID) async {
//     final prefs = await SharedPreferences.getInstance();
//     final accessToken = prefs.getString('accessToken');
//     try {
//       final Map<String, dynamic> body = {
//         if (title.isNotEmpty) 'title': title,
//         if (description.isNotEmpty) 'description': description,
//         if (serviceID != null) 'serviceID': serviceID,
//       };
//
//       var response = await http.post(
//         Uri.parse('$baseURL/api/announcement/add/'),
//         headers: {
//           'Authorization': 'Bearer $accessToken',
//           "Content-Type": "application/json",
//         },
//         body: json.encode(body),
//       );
//
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         print('200');
//         if (response.body.isNotEmpty) {
//           var jsonData = json.decode(response.body) as Map<String, dynamic>;
//           var newAnnouncement = Announcement.fromJson(jsonData);
//           myAnnouncements.add(newAnnouncement);
//           fetchAnnouncements(); // لتحديث قائمة الإعلانات العامة
//         } else {
//           print("Error: Empty response body");
//         }
//       } else {
//         print(response.body);
//       }
//     } catch (e) {
//       print("Error adding announcement: $e");
//     }
//   }
  Future<void> addAnnouncement(String title, String description, int? serviceID, PlatformFile? file) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseURL/api/announcement/add/'));
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.headers['Content-Type'] = 'multipart/form-data';

      if (title.isNotEmpty) request.fields['title'] = title;
      if (description.isNotEmpty) request.fields['description'] = description;
      if (serviceID != null) request.fields['serviceID'] = serviceID.toString();
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path!));
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print('Response status: ${response.statusCode}');
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        var jsonData = json.decode(responseBody) as Map<String, dynamic>;
        var newAnnouncement = Announcement.fromJson(jsonData);
        myAnnouncements.add(newAnnouncement);
        fetchAnnouncements(); // لتحديث قائمة الإعلانات العامة
      } else {
        print('Error: $responseBody');
      }
    } catch (e) {
      print("Error adding announcement: $e");
    }
  }

  /*Future<void> addAnnouncement(String title, String description, int? serviceID, PlatformFile? file) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseURL/api/announcement/add/'));
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.headers['Content-Type'] = 'multipart/form-data';

      if (title.isNotEmpty) request.fields['title'] = title;
      if (description.isNotEmpty) request.fields['description'] = description;
      if (serviceID != null) request.fields['serviceID'] = serviceID.toString();
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path!));
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print('Response status: ${response.statusCode}');
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        var jsonData = json.decode(responseBody) as Map<String, dynamic>;
        var newAnnouncement = Announcement.fromJson(jsonData);
        myAnnouncements.add(newAnnouncement);
        fetchAnnouncements(); // لتحديث قائمة الإعلانات العامة
      } else {
        print('Error: $responseBody');
      }
    } catch (e) {
      print("Error adding announcement: $e");
    }
  }*/


  void fetchMyAnnouncements() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('$baseURL/api/announcement/showMy'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData != null) {
          myAnnouncements.value = (jsonData as List).map((i) => Announcement.fromJson(i)).toList();
        } else {
          myAnnouncements.value = [];
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch my announcements');
      }
    } finally {
      isLoading(false);
    }
  }
  /*Future<void> updateAnnouncement(int id, String title, String description, int serviceID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.put(
        Uri.parse('$baseURL/api/announcement/update/$id'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': title,
          'description': description,
          'serviceID': serviceID,
        }),
      );
      if (response.statusCode == 200) {
        bool result = json.decode(response.body);
        if (result) {
          var updatedAnnouncement = Announcement(
            id: id,
            title: title,
            description: description,
            serviceID: serviceID,
            userID: announcements.firstWhere((ann) => ann.id == id).userID,
            isSaved: announcements.firstWhere((ann) => ann.id == id).isSaved,
            savedAnnouncementID: announcements.firstWhere((ann) => ann.id == id).savedAnnouncementID,
          );

          int myIndex = myAnnouncements.indexWhere((ann) => ann.id == id);
          if (myIndex != -1) {
            myAnnouncements[myIndex] = updatedAnnouncement;
          }

          int allIndex = announcements.indexWhere((ann) => ann.id == id);
          if (allIndex != -1) {
            announcements[allIndex] = updatedAnnouncement;
          }

          // تحديث الإعلانات المحفوظة
          int savedIndex = savedAnnouncements.indexWhere((saved) => saved.announcementID == id);
          if (savedIndex != -1) {
            var savedAnnouncement = savedAnnouncements[savedIndex];
            savedAnnouncements[savedIndex] = SavedAnnouncement(
              id: savedAnnouncement.id,
              userID: savedAnnouncement.userID,
              announcementID: savedAnnouncement.announcementID,
              createdAt: savedAnnouncement.createdAt,
              updatedAt: savedAnnouncement.updatedAt,
              announcement: updatedAnnouncement, // هنا يتم تحديث الإعلان
            );
          }

          Get.snackbar('Success', 'Announcement updated successfully');
        } else {
          Get.snackbar('Error', 'Failed to update announcement');
        }
      } else {
        Get.snackbar('Error', 'Failed to update announcement');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while trying to update the announcement');
    }
  }*/
  Future<void> updateAnnouncement(int id, String? title, String? description, int? serviceID) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      final Map<String, dynamic> body = {
        if (title != null && title.isNotEmpty) 'title': title,
        if (description != null && description.isNotEmpty) 'description': description,
        if (serviceID != null) 'serviceID': serviceID,
      };

      var response = await http.put(
        Uri.parse('$baseURL/api/announcement/update/$id'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('200');
        if (response.body.isNotEmpty) {
          var responseBody = json.decode(response.body);
          if (responseBody is Map<String, dynamic>) {
            var updatedAnnouncement = Announcement.fromJson(responseBody);
            int index = myAnnouncements.indexWhere((a) => a.id == id);
            if (index != -1) {
              myAnnouncements[index] = updatedAnnouncement;
              fetchAnnouncements(); // لتحديث قائمة الإعلانات العامة
            }
          } else if (responseBody is bool && responseBody == true) {
            // التعامل مع الحالة التي تعيد فيها الاستجابة `true`
            fetchAnnouncements(); // لتحديث قائمة الإعلانات العامة
            print("Announcement updated successfully");
          } else {
            print("Error: Unexpected response format");
          }
        } else {
          print("Error: Empty response body");
        }
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print("Error updating announcement: $e");
    }
  }






}


//شغال زي العسل
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../globals.dart';
// import '../model/Newannouncement_model.dart';
//
// class AnnouncementController extends GetxController {
//   var announcements = <Announcement>[].obs;
//  // var savedAnnouncements = <Announcement>[].obs;
//   RxList<SavedAnnouncement> savedAnnouncements = <SavedAnnouncement>[].obs;
//
//
//   var isLoading = true.obs;
//   var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0';
//
//   @override
//   void onInit() {
//     fetchAnnouncements();
//     fetchSavedAnnouncements();
//     super.onInit();
//   }
//
//   void fetchAnnouncements() async {
//     try {
//       isLoading(true);
//       var response = await http.get(
//           Uri.parse('$baseURL/api/announcement/showAll/'),
//           headers: {
//             'Authorization': 'Bearer $token',
//           });
//       if (response.statusCode == 200) {
//         print('announcement');
//         var jsonData = json.decode(response.body);
//         if (jsonData != null) {
//           announcements.value =
//               (jsonData as List).map((i) => Announcement.fromJson(i)).toList();
//         } else {
//           announcements.value = [];
//         }
//         updateSavedStatus();
//       } else {
//         Get.snackbar('Error', 'Failed to fetch announcements');
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void fetchSavedAnnouncements() async {
//     try {
//       isLoading(true);
//       var response = await http.get(
//         Uri.parse('$baseURL/api/savedAnnouncement/showAll'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         print('200');
//         var jsonData = json.decode(response.body);
//         if (jsonData != null) {
//           savedAnnouncements.assignAll((jsonData as List).map((i) => SavedAnnouncement.fromJson(i)).toList());
//         } else {
//           savedAnnouncements.value = [];
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to fetch saved announcements');
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
//
//
//
//   void updateSavedStatus() {
//     for (var announcement in announcements) {
//       if (savedAnnouncements.any((saved) => saved.id == announcement.id)) {
//         announcement.isSaved = true;
//       }
//     }
//   }
//
//   void saveAnnouncement(int announcementID) async {
//     var response = await http.post(
//       Uri.parse(
//           '$baseURL/api/savedAnnouncement/save/$announcementID'),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );
//     if (response.statusCode == 200) {
//       var savedData = json.decode(response.body);
//       var savedAnnouncement = SavedAnnouncement(
//         id: savedData['id'],
//         userID: savedData['userID'],
//         announcementID: savedData['announcementID'],
//         createdAt: savedData['created_at'],
//         updatedAt: savedData['updated_at'],
//         announcement: announcements
//             .firstWhere((announcement) => announcement.id == announcementID),
//       );
//       savedAnnouncements.add(savedAnnouncement);
//       Get.snackbar('Success', 'Announcement saved successfully');
//     } else {
//       Get.snackbar('Error', 'Failed to save announcement');
//     }
//   }
//
//
//   void unsaveAnnouncement(int savedAnnouncementID) async {
//     try {
//       var response = await http.delete(
//         Uri.parse('$baseURL/api/savedAnnouncement/unSave/$savedAnnouncementID'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       print(savedAnnouncementID);
//       if (response.statusCode == 200) {
//         print('unsave');
//         var savedAnnouncement = savedAnnouncements.firstWhere((saved) => saved.id == savedAnnouncementID);
//         savedAnnouncements.removeWhere((saved) => saved.id == savedAnnouncementID);
//         Get.snackbar('Success', 'Announcement unsaved successfully');
//       } else {
//         Get.snackbar('Error', 'Failed to unsave announcement');
//         print("Failed to unsave: ${response.statusCode}");
//         print("Response body: ${response.body}");
//       }
//     } catch (e) {
//       print("Error unsaving announcement: $e");
//       Get.snackbar('Error', 'An error occurred while trying to unsave the announcement');
//     }
//   }
//
// }


/*
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/Newannouncement_model.dart';
class AnnouncementController extends GetxController {
  var announcements = <Announcement>[].obs;
  var savedAnnouncements = <Announcement>[].obs;
  var isLoading = true.obs;
  var token='eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0';

  @override
  void onInit() {
    fetchAnnouncements();
    fetchSavedAnnouncements();
    super.onInit();
  }

  void fetchAnnouncements() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('http://192.168.137.14:8000/api/announcement/showAll/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print('announcement');
        var jsonData = json.decode(response.body);
        announcements.value = (jsonData as List).map((i) => Announcement.fromJson(i)).toList();
        updateSavedStatus();
      } else {
        Get.snackbar('Error', 'Failed to fetch announcements');
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchSavedAnnouncements() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('http://192.168.137.14:8000/api/savedAnnouncement/showAll'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print('200');
        var jsonData = json.decode(response.body);
        savedAnnouncements.value = (jsonData as List).map((i) => Announcement.fromJson(i['announcement'])).toList();
        updateSavedStatus();
      } else {
        Get.snackbar('Error', 'Failed to fetch saved announcements');
      }
    } finally {
      isLoading(false);
    }
  }

  void updateSavedStatus() {
    for (var announcement in announcements) {
      if (savedAnnouncements.any((saved) => saved.id == announcement.id)) {
        announcement.isSaved = true;
      }
    }
  }

  void saveAnnouncement(int announcementID) async {
    var response = await http.post(Uri.parse('http://192.168.137.14:8000/api/savedAnnouncement/save/$announcementID'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var savedAnnouncement = announcements.firstWhere((announcement) => announcement.id == announcementID);
      savedAnnouncement.isSaved = true;
      savedAnnouncements.add(savedAnnouncement);
      Get.snackbar('Success', 'Announcement saved successfully');
    } else {
      Get.snackbar('Error', 'Failed to save announcement');
    }
  }

  void unsaveAnnouncement(int announcementID) async {
    var savedAnnouncement = savedAnnouncements.firstWhere((saved) => saved.id == announcementID);
    var response = await http.delete(Uri.parse('http://192.168.137.14:8000/api/savedAnnouncement/unSave/${savedAnnouncement.id}'),

      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(savedAnnouncement.id);
    print('i am in');
    if (response.statusCode == 200) {
print('unsave');
      savedAnnouncement.isSaved = false;
      savedAnnouncements.removeWhere((saved) => saved.id == announcementID);
      Get.snackbar('Success', 'Announcement unsaved successfully');
    } else {
      Get.snackbar('Error', 'Failed to unsave announcement');
    }
  }
}*/
