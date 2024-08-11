// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../model/announcment_model.dart';
//
// class AnnouncementController extends GetxController {
//   var announcements = <Announcement>[].obs;
//   var isLoading = true.obs;
//   var savedAnnouncements = <int>{}.obs; // لإدارة الإعلانات المحفوظة
//   var savedAnnouncementMap = <int, int>{}.obs; // خريطة للإعلانات المحفوظة
//
//   @override
//   void onInit() {
//     fetchAnnouncements();
//     fetchSavedAnnouncements();
//     super.onInit();
//   }
//
//   void fetchAnnouncements() async {
//     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
//     try {
//       isLoading(true);
//       var response = await http.get(
//         Uri.parse('http://192.168.1.19:8000/api/announcement/showAll/'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body);
//         var fetchedAnnouncements = (jsonData as List).map((data) => Announcement.fromJson(data)).toList();
//         announcements.assignAll(fetchedAnnouncements);
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void fetchSavedAnnouncements() async {
//     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
//     try {
//       var response = await http.get(
//         Uri.parse('http://192.168.1.19:8000/api/savedAnnouncement/showAll'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body);
//         var fetchedSavedAnnouncements = (jsonData as List).map((data) => SavedAnnouncement.fromJson(data)).toList();
//         savedAnnouncementMap.assignAll({
//           for (var saved in fetchedSavedAnnouncements) saved.id: saved.id
//         });
//         savedAnnouncements.assignAll(savedAnnouncementMap.keys);
//         for (var announcement in announcements) {
//           announcement.isSaved.value = savedAnnouncements.contains(announcement.id);
//         }
//       }
//     } catch (e) {
//       print("Error fetching saved announcements: $e");
//     }
//   }
//
//   Future<void> saveAnnouncement(int announcementId) async {
//     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
//     try {
//       var response = await http.post(
//         Uri.parse('http://192.168.1.19:8000/api/savedAnnouncement/save/$announcementId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body);
//         var savedAnnouncement = SavedAnnouncement.fromJson(jsonData);
//         savedAnnouncements.add(announcementId);
//         savedAnnouncementMap[announcementId] = savedAnnouncement.id;
//       }
//     } catch (e) {
//       print("Error saving announcement: $e");
//     }
//   }
//
//   Future<void> unSaveAnnouncement(int announcementId) async {
//     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
//     try {
//       var savedAnnouncementId = savedAnnouncementMap[announcementId];
//       if (savedAnnouncementId == null) return;
//       var response = await http.delete(
//         Uri.parse('http://192.168.1.19:8000/api/savedAnnouncement/unSave/$savedAnnouncementId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         print('delete');
//         savedAnnouncements.remove(announcementId);
//         savedAnnouncementMap.remove(announcementId);
//       }
//     } catch (e) {
//       print("Error unsaving announcement: $e");
//     }
//   }
//   Future<void> addAnnouncement(String title, String description, int serviceID) async {
//     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
//     try {
//       var response = await http.post(
//         Uri.parse('http://192.168.1.19:8000/api/announcement/add/'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           "Content-Type": "application/json",
//         },
//         body: json.encode({
//           'title': title,
//           'description': description,
//           'serviceID': serviceID,
//         }),
//       );
//       if (response.statusCode == 200) {
//         fetchAnnouncements();
//       }
//     } catch (e) {
//       print("Error adding announcement: $e");
//     }
//   }
// }
// // تعديل اخير
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// //
// // import '../model/announcment_model.dart';
// //
// // class AnnouncementController extends GetxController {
// //   var announcements = <Announcement>[].obs;
// //   var isLoading = true.obs;
// //   var savedAnnouncements = <int>{}.obs; // لإدارة الإعلانات المحفوظة
// //   var savedAnnouncementMap = <int, int>{}.obs; // خريطة للإعلانات المحفوظة
// //
// //
// //   @override
// //   void onInit() {
// //     fetchAnnouncements();
// //     fetchSavedAnnouncements();
// //     super.onInit();
// //   }
// //
// //   void fetchAnnouncements() async {
// //     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
// //     try {
// //       isLoading(true);
// //       var response = await http.get(
// //         Uri.parse('http://192.168.1.19:8000/api/announcement/showAll/'),
// //         headers: <String, String>{
// //           'Authorization': 'Bearer $token',
// //         },
// //       );
// //       if (response.statusCode == 200) {
// //         var jsonData = json.decode(response.body);
// //         var fetchedAnnouncements = (jsonData as List).map((data) => Announcement.fromJson(data)).toList();
// //         announcements.assignAll(fetchedAnnouncements);
// //       }
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// //
// //   void fetchSavedAnnouncements() async {
// //     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
// //     try {
// //       var response = await http.get(
// //         Uri.parse('http://192.168.1.19:8000/api/savedAnnouncement/showAll'),
// //         headers: <String, String>{
// //           'Authorization': 'Bearer $token',
// //         },
// //       );
// //       if (response.statusCode == 200) {
// //         print('fetch');
// //         print("Response body: ${response.body}");
// //         var jsonData = json.decode(response.body);
// //         var fetchedSavedAnnouncements = (jsonData as List).map((data) => SavedAnnouncement.fromJson(data)).toList();
// //         savedAnnouncementMap.assignAll({
// //           for (var saved in fetchedSavedAnnouncements) saved.id: saved.id
// //         });
// //         savedAnnouncements.assignAll(savedAnnouncementMap.keys);
// //         for (var announcement in announcements) {
// //           announcement.isSaved.value = savedAnnouncements.contains(announcement.id);
// //         }
// //       }else {
// //         print("Failed to load subjects: ${response.statusCode}");
// //         print("Response body: ${response.body}");
// //       }
// //     } catch (e) {
// //       print("Error fetching saved announcements: $e");
// //     }
// //   }
// //
// //   Future<void> saveAnnouncement(int announcementId) async {
// //     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
// //     try {
// //       var response = await http.post(
// //         Uri.parse('http://192.168.1.19:8000/api/savedAnnouncement/save/$announcementId'),
// //         headers: {
// //           'Authorization': 'Bearer $token',
// //         },
// //       );
// //       if (response.statusCode == 200) {
// //         var jsonData = json.decode(response.body);
// //         var savedAnnouncement = SavedAnnouncement.fromJson(jsonData);
// //         savedAnnouncements.add(announcementId);
// //         savedAnnouncementMap[announcementId] = savedAnnouncement.id;
// //       }
// //     } catch (e) {
// //       print("Error saving announcement: $e");
// //     }
// //   }
// //
// //   Future<void> unSaveAnnouncement(int announcementId) async {
// //     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
// //     try {
// //       var savedAnnouncementId = savedAnnouncementMap[announcementId];
// //       if (savedAnnouncementId == null) return;
// //       var response = await http.delete(
// //         Uri.parse('http://192.168.1.19:8000/api/savedAnnouncement/unSave/$savedAnnouncementId'),
// //         headers: {
// //           'Authorization': 'Bearer $token',
// //         },
// //       );
// //       if (response.statusCode == 200) {
// //         print('unsaved 200');
// //         savedAnnouncements.remove(savedAnnouncementId);
// //         savedAnnouncementMap.remove(savedAnnouncementId);
// //       }else {
// //         print("Failed to load subjects: ${response.statusCode}");
// //         print("Response body: ${response.body}");
// //       }
// //     } catch (e) {
// //       print("Error unsaving announcement: $e");
// //     }
// //   }
// //   Future<void> addAnnouncement(String title, String description, int serviceID) async {
// //     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
// //     try {
// //       var response = await http.post(
// //         Uri.parse('http://192.168.1.19:8000/api/announcement/add/'),
// //         headers: {
// //           'Authorization': 'Bearer $token',
// //           "Content-Type": "application/json",
// //         },
// //         body: json.encode({
// //           'title': title,
// //           'description': description,
// //           'serviceID': serviceID,
// //         }),
// //       );
// //       if (response.statusCode == 200) {
// //         fetchAnnouncements();
// //       }
// //     } catch (e) {
// //       print("Error adding announcement: $e");
// //     }
// //   }
// // }
//
// //شغال
// //first version
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// //
// // import '../model/announcment_model.dart';
// //
// // class AnnouncementController extends GetxController {
// //   var announcements = <Announcement>[].obs;
// //   var isLoading = true.obs;
// //   var savedAnnouncements = <int>{}.obs;
// //
// //
// //   @override
// //   void onInit() {
// //     fetchAnnouncements();
// //     fetchSavedAnnouncements();
// //     super.onInit();
// //   }
// //
// //   void fetchAnnouncements() async {
// //     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
// //     try {
// //       isLoading(true);
// //       var response = await http.get(
// //         Uri.parse('http://192.168.1.19:8000/api/announcement/showAll/'),
// //         headers: <String, String>{
// //           'Authorization': 'Bearer $token',
// //         },
// //       );
// //       if (response.statusCode == 200) {
// //         print(200);
// //         var jsonData = json.decode(response.body);
// //         var fetchedAnnouncements = (jsonData as List).map((data) => Announcement.fromJson(data)).toList();
// //         announcements.assignAll(fetchedAnnouncements);
// //       }
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// //
// //   void fetchSavedAnnouncements() async {
// //     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
// //     try {
// //       var response = await http.get(
// //         Uri.parse('http://192.168.1.19:8000/api/savedAnnouncement/showAll'),
// //         headers: <String, String>{
// //           'Authorization': 'Bearer $token',
// //         },
// //       );
// //       if (response.statusCode == 200) {
// //         print('i am really saved');
// //         var jsonData = json.decode(response.body);
// //         var fetchedSavedAnnouncements = (jsonData as List).map((data) => Announcement.fromJson(data)).toList();
// //         savedAnnouncements.assignAll(fetchedSavedAnnouncements.map((announcement) => announcement.id));
// //         for (var announcement in announcements) {
// //           announcement.isSaved.value = savedAnnouncements.contains(announcement.id);
// //         }
// //       }
// //     } catch (e) {
// //       print("Error fetching saved announcements: $e");
// //     }
// //   }
// //
// //   Future<void> saveAnnouncement(int announcementId) async {
// //     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
// //     try {
// //       var response = await http.post(
// //         Uri.parse('http://192.168.1.19:8000/api/savedAnnouncement/save/$announcementId'),
// //         headers: {
// //           'Authorization': 'Bearer $token',
// //         },
// //       );
// //       if (response.statusCode == 200) {
// //         savedAnnouncements.add(announcementId);
// //
// //       }
// //     } catch (e) {
// //       print("Error saving announcement: $e");
// //     }
// //   }
// //
// //   Future<void> unSaveAnnouncement(int savedAnnouncementId) async {
// //     final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2UyM2ZkM2MxNzdiNWI3ZjYyNzhjZWI2ZDk3YTg4ODZmNmJjZjkxOWRkZWVkMDA4ZWQwNmZiOGRiMTg2OGM3NWM5YjA4NzA3ZWYxNjJhZTciLCJpYXQiOjE3MTU2MDc3NjIuOTgzNDAyLCJuYmYiOjE3MTU2MDc3NjIuOTgzNDA5LCJleHAiOjE3NDcxNDM3NjIuOTc0MzczLCJzdWIiOiIyMSIsInNjb3BlcyI6W119.d5LItAOTHM9q4itcOrDoUyXe7gl88Bw7EoeFN8c2H8ayrWAkaizKCUrSt6qj2USK8GNXgx-rxEdRVfDFn1vgudv-dONYzzjbMpjL8bZW20vRWNU-oDApUdBic1FBzwe-l4tXqBSxuMdWNXzl0rtkyjqrNSGqhHf5F_Bsnv2G7ViYo9tuxD6QxaarGNpy38aFay02CEaFK39ciJD7XTazdMVLClfd_yut1eFWs3yRl3AsADtpfUUDSt--D8raDw-gFHtCTUt1A3jjuoW7q1_7X0MciI48zQpyNEH2cxHqtOFybEvQoCCr6QvzhfnPCKg1lDth63maLKbu_AL_xQHMX-ELXorgX4tnaghSzyn5hw5OejvaaE5bq20xVT4LqYoqLnbTwHXFyl2Zg8Sdfci1NqYQ1g-EEgxTXyTsuiOmedAT2hrfGLAJ_jrdJYSkTFhjn9-Y28sBiUvn-xJZsLA7PwYna9hUfKaMmb6_M8q1tbeMOjv1KT5yxRwovAPLfw0n9pHBotcD76kDdTD8km5L_yI6EBsMFgJSs979WZQSDXmyU_7R4ETfjDATeJ1y88IbxoHsZyATCmDJMzHWKd8hdovaWnGbyD70eHfCTSAJ1f5Ti74vzpv1jDmtpyO6JZMp2gFP4eTkuB9A6QCdxnmGYIUNJXhBgX1gjjXVUuuoCd0";
// //     try {
// //       var response = await http.delete(
// //         Uri.parse('http://192.168.1.19:8000/api/savedAnnouncement/unSave/$savedAnnouncementId'),
// //         headers: {
// //           'Authorization': 'Bearer $token',
// //         },
// //       );
// //       print('i am in');
// //       if (response.statusCode == 200) {
// //         savedAnnouncements.remove(savedAnnouncementId);
// //
// //       }else {
// //         print("Failed to unsaved : ${response.statusCode}");
// //         print("Response body: ${response.body}");
// //       }
// //     } catch (e) {
// //       print("Error unsaving announcement: $e");
// //     }
// //   }
// //
// //
// //
// //   Future<void> addAnnouncement(String title, String description, int serviceID) async {
// //     final String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjYzZTY4YjgwNDIwOWU0ZGY2NTViNzQzODY5YzNhM2RhYjM2ZjI3N2NhNmRlOGY5MGExYjZjNjA0YjRlZWM1M2MwOWQ3YzFhMmIzZDU4OTQiLCJpYXQiOjE3MTYxMTM0MDUuMDYyMDI1LCJuYmYiOjE3MTYxMTM0MDUuMDYyMDI5LCJleHAiOjE3NDc2NDk0MDUuMDU0MjQ5LCJzdWIiOiIzMCIsInNjb3BlcyI6W119.d1UlsCrmAiliEEFSDLM86U_k9yqt_gkavH6jhITLDw40b80DqVVfegivFRfaJZs5J6brJFZCjthlhwwl5rKKxX1R8ZYm8waYUjU2IOuJvUh1aPLmqVp_qrFp2NJbey-Cc7zfwqFRnlnMY_qA6EzCFrhMv4smxTOZsrwJlNqMratbqJ6p-PhN8PX6h-NKVq2HnhN5GnaN0DPhnGAM0bAVHr2DZ2DHoWZDdLAGEGDLHqA3jVcQ69rnfzn2WIQ5-KsIF6DPL1NknT46pn3On3L36yaAIK9aFdrj1ybI2_JC12if6erOwziQfmHvaJwRc8ZNwdomRA_3AJY_zFMThOUWqIvZG9cOKlB7rJbwTV8XFtbRUfoAMElw_B4fK-rjlxqHzUrywfWPdkw6C2kJ8z6dHQPiptKIZxwV1jysXqtgvp7P2HNduBLd5R-xtIH3Maei-TdVww8nPZnYslqAon26MSRnXqxYnFatk__2bCNqBS6lxOTJvUiaeF_ZGqFeHR2PnQnZlURmmWKOVBhJ03tZ7qx-dnXpF9ycWv1HRQXWcEKdy3fu8_qpNaz_GnZuXLcLgqqjZB38nQzoXBtpskPUuiUBUadBntx9N_LT4WDkzE41bl8NiodJtQkYaWLP96t_UM3NTcoEi624kUV9JeREbufmPF5QHCOAM-xcvfpT0kM";
// //     try {
// //       var response = await http.post(
// //         Uri.parse('http://192.168.1.19:8000/api/announcement/add/'),
// //         headers: {
// //           'Authorization': 'Bearer $token',
// //           "Content-Type": "application/json",
// //
// //         },
// //         body: json.encode({
// //           'title': title,
// //           'description': description,
// //           'serviceID': serviceID,
// //         }),
// //       );
// //       print('i am in');
// //       if (response.statusCode == 200) {
// //         fetchAnnouncements();
// //       }
// //     } catch (e) {
// //       print("Error adding announcement: $e");
// //     }
// //   }
// //
// // }
//
// //
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// //
// // import '../model/announcment_model.dart';
// //
// //
// // class AnnouncementController extends GetxController {
// //   var announcements = <Announcement>[].obs;
// //   var isLoading = true.obs;
// //
// //
// //   @override
// //   void onInit() {
// //     fetchAnnouncements();
// //     super.onInit();
// //   }
// //
// //   void fetchAnnouncements() async {
// //     final String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjYzZTY4YjgwNDIwOWU0ZGY2NTViNzQzODY5YzNhM2RhYjM2ZjI3N2NhNmRlOGY5MGExYjZjNjA0YjRlZWM1M2MwOWQ3YzFhMmIzZDU4OTQiLCJpYXQiOjE3MTYxMTM0MDUuMDYyMDI1LCJuYmYiOjE3MTYxMTM0MDUuMDYyMDI5LCJleHAiOjE3NDc2NDk0MDUuMDU0MjQ5LCJzdWIiOiIzMCIsInNjb3BlcyI6W119.d1UlsCrmAiliEEFSDLM86U_k9yqt_gkavH6jhITLDw40b80DqVVfegivFRfaJZs5J6brJFZCjthlhwwl5rKKxX1R8ZYm8waYUjU2IOuJvUh1aPLmqVp_qrFp2NJbey-Cc7zfwqFRnlnMY_qA6EzCFrhMv4smxTOZsrwJlNqMratbqJ6p-PhN8PX6h-NKVq2HnhN5GnaN0DPhnGAM0bAVHr2DZ2DHoWZDdLAGEGDLHqA3jVcQ69rnfzn2WIQ5-KsIF6DPL1NknT46pn3On3L36yaAIK9aFdrj1ybI2_JC12if6erOwziQfmHvaJwRc8ZNwdomRA_3AJY_zFMThOUWqIvZG9cOKlB7rJbwTV8XFtbRUfoAMElw_B4fK-rjlxqHzUrywfWPdkw6C2kJ8z6dHQPiptKIZxwV1jysXqtgvp7P2HNduBLd5R-xtIH3Maei-TdVww8nPZnYslqAon26MSRnXqxYnFatk__2bCNqBS6lxOTJvUiaeF_ZGqFeHR2PnQnZlURmmWKOVBhJ03tZ7qx-dnXpF9ycWv1HRQXWcEKdy3fu8_qpNaz_GnZuXLcLgqqjZB38nQzoXBtpskPUuiUBUadBntx9N_LT4WDkzE41bl8NiodJtQkYaWLP96t_UM3NTcoEi624kUV9JeREbufmPF5QHCOAM-xcvfpT0kM";
// //     try {
// //       isLoading(true);
// //       var response = await http.get(Uri.parse('http://192.168.1.105:8000/api/announcement/showAll/'),
// //         headers: <String, String>{
// //           'Authorization': 'Bearer $token',
// //         },
// //       );
// //       print('i am in');
// //       if (response.statusCode == 200) {
// //         print('200');
// //         var jsonData = json.decode(response.body);
// //         var fetchedAnnouncements = (jsonData as List).map((data) => Announcement.fromJson(data)).toList();
// //         announcements.assignAll(fetchedAnnouncements);
// //       }
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// //
// //   Future<void> addAnnouncement(String title, String description, int serviceID) async {
// //     final String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjYzZTY4YjgwNDIwOWU0ZGY2NTViNzQzODY5YzNhM2RhYjM2ZjI3N2NhNmRlOGY5MGExYjZjNjA0YjRlZWM1M2MwOWQ3YzFhMmIzZDU4OTQiLCJpYXQiOjE3MTYxMTM0MDUuMDYyMDI1LCJuYmYiOjE3MTYxMTM0MDUuMDYyMDI5LCJleHAiOjE3NDc2NDk0MDUuMDU0MjQ5LCJzdWIiOiIzMCIsInNjb3BlcyI6W119.d1UlsCrmAiliEEFSDLM86U_k9yqt_gkavH6jhITLDw40b80DqVVfegivFRfaJZs5J6brJFZCjthlhwwl5rKKxX1R8ZYm8waYUjU2IOuJvUh1aPLmqVp_qrFp2NJbey-Cc7zfwqFRnlnMY_qA6EzCFrhMv4smxTOZsrwJlNqMratbqJ6p-PhN8PX6h-NKVq2HnhN5GnaN0DPhnGAM0bAVHr2DZ2DHoWZDdLAGEGDLHqA3jVcQ69rnfzn2WIQ5-KsIF6DPL1NknT46pn3On3L36yaAIK9aFdrj1ybI2_JC12if6erOwziQfmHvaJwRc8ZNwdomRA_3AJY_zFMThOUWqIvZG9cOKlB7rJbwTV8XFtbRUfoAMElw_B4fK-rjlxqHzUrywfWPdkw6C2kJ8z6dHQPiptKIZxwV1jysXqtgvp7P2HNduBLd5R-xtIH3Maei-TdVww8nPZnYslqAon26MSRnXqxYnFatk__2bCNqBS6lxOTJvUiaeF_ZGqFeHR2PnQnZlURmmWKOVBhJ03tZ7qx-dnXpF9ycWv1HRQXWcEKdy3fu8_qpNaz_GnZuXLcLgqqjZB38nQzoXBtpskPUuiUBUadBntx9N_LT4WDkzE41bl8NiodJtQkYaWLP96t_UM3NTcoEi624kUV9JeREbufmPF5QHCOAM-xcvfpT0kM";
// //     try {
// //       var response = await http.post(
// //         Uri.parse('http://192.168.1.105:8000/api/announcement/add/'),
// //         headers: {
// //           'Authorization': 'Bearer $token',
// //           "Content-Type": "application/json",
// //
// //         },
// //         body: json.encode({
// //           'title': title,
// //           'description': description,
// //           'serviceID': serviceID,
// //         }),
// //       );
// //       print('i am in');
// //       if (response.statusCode == 200) {
// //         fetchAnnouncements();
// //       }
// //     } catch (e) {
// //       print("Error adding announcement: $e");
// //     }
// //   }
// // }
