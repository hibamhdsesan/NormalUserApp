// import 'package:get/get.dart';
//
// class Announcement {
//   int id;
//   String title;
//   String description;
//   int serviceID;
//   int userID;
//   String createdAt;
//   String updatedAt;
//   var isSaved = false.obs;
//
//
//   Announcement({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.serviceID,
//     required this.userID,
//     required this.createdAt,
//     required this.updatedAt,
//
//   });
//
//   factory Announcement.fromJson(Map<String, dynamic> json) {
//     return Announcement(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       serviceID: json['serviceID'],
//       userID: json['userID'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//
//     );
//   }
// }

import 'service_model.dart';

class Announcement {
  final int id;
  final int serviceID;
  final int userID;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;
  final Service service;
  bool isSaved;
  int? savedAnnouncementID;

  Announcement({
    required this.id,
    required this.serviceID,
    required this.userID,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.service,
    this.isSaved = false,
    this.savedAnnouncementID,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      serviceID: json['serviceID'],
      userID: json['userID'],
      title: json['title'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      service: Service.fromJson(json['service']),
      isSaved: json['isSaved'] ?? false,
      savedAnnouncementID: json['savedAnnouncementID'],
    );
  }
}
