/*import 'package:get/get.dart';


class Announcement {
  final int id;
  final int serviceID;
  final int userID;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;
  final Service service;
  RxBool isSaved; // Use RxBool for reactivity
  int? savedAnnouncementID; // Make sure this field is nullable

  Announcement({
    required this.id,
    required this.serviceID,
    required this.userID,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.service,
    bool isSaved = false,
    this.savedAnnouncementID,
  }) : isSaved = isSaved.obs;

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
      savedAnnouncementID: json['savedAnnouncementID'], // Make sure to map this correctly
    );
  }
}
class Service {
  final int id;
  final int serviceManagerID;
  final int? parentServiceID;
  final int serviceYearAndSpecializationID;
  final String serviceName;
  final String serviceDescription;
  final String serviceType;
  final int minimumNumberOfGroupMembers;
  final int maximumNumberOfGroupMembers;
  final int status;
  final String createdAt;
  final String updatedAt;

  Service({
    required this.id,
    required this.serviceManagerID,
    this.parentServiceID,
    required this.serviceYearAndSpecializationID,
    required this.serviceName,
    required this.serviceDescription,
    required this.serviceType,
    required this.minimumNumberOfGroupMembers,
    required this.maximumNumberOfGroupMembers,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      serviceManagerID: json['serviceManagerID'],
      parentServiceID: json['parentServiceID'],
      serviceYearAndSpecializationID: json['serviceYearAndSpecializationID'],
      serviceName: json['serviceName'],
      serviceDescription: json['serviceDescription'],
      serviceType: json['serviceType'],
      minimumNumberOfGroupMembers: json['minimumNumberOfGroupMembers'],
      maximumNumberOfGroupMembers: json['maximumNumberOfGroupMembers'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class SavedAnnouncement {
  final int id;
  final int userID;
  final int announcementID;
  final String createdAt;
  final String updatedAt;
  final Announcement announcement;

  SavedAnnouncement({
    required this.id,
    required this.userID,
    required this.announcementID,
    required this.createdAt,
    required this.updatedAt,
    required this.announcement,
  });

  factory SavedAnnouncement.fromJson(Map<String, dynamic> json) {
    return SavedAnnouncement(
      id: json['id'],
      userID: json['userID'],
      announcementID: json['announcementID'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      announcement: Announcement.fromJson(json['announcement']),
    );
  }
}

*/
//مودل زي العسل

// class Announcement {
//   final int id;
//   final int serviceID;
//   final int userID;
//   final String title;
//   final String description;
//   final String createdAt;
//   final String updatedAt;
//   final Service service;
//   bool isSaved;
//   int? savedAnnouncementID; // Make sure this field is nullable
//
//   Announcement({
//     required this.id,
//     required this.serviceID,
//     required this.userID,
//     required this.title,
//     required this.description,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.service,
//     this.isSaved = false,
//     this.savedAnnouncementID,
//   });
//
//   factory Announcement.fromJson(Map<String, dynamic> json) {
//     return Announcement(
//       id: json['id'],
//       serviceID: json['serviceID'],
//       userID: json['userID'],
//       title: json['title'],
//       description: json['description'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       service: Service.fromJson(json['service']),
//       isSaved: json['isSaved'] ?? false,
//       savedAnnouncementID: json['savedAnnouncementID'], // Make sure to map this correctly
//     );
//   }
// }
// class Service {
//   final int id;
//   final int serviceManagerID;
//   final int? parentServiceID;
//   final int serviceYearAndSpecializationID;
//   final String serviceName;
//   final String serviceDescription;
//   final String serviceType;
//   final int minimumNumberOfGroupMembers;
//   final int maximumNumberOfGroupMembers;
//   final int status;
//   final String createdAt;
//   final String updatedAt;
//
//   Service({
//     required this.id,
//     required this.serviceManagerID,
//     this.parentServiceID,
//     required this.serviceYearAndSpecializationID,
//     required this.serviceName,
//     required this.serviceDescription,
//     required this.serviceType,
//     required this.minimumNumberOfGroupMembers,
//     required this.maximumNumberOfGroupMembers,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Service.fromJson(Map<String, dynamic> json) {
//     return Service(
//       id: json['id'],
//       serviceManagerID: json['serviceManagerID'],
//       parentServiceID: json['parentServiceID'],
//       serviceYearAndSpecializationID: json['serviceYearAndSpecializationID'],
//       serviceName: json['serviceName'],
//       serviceDescription: json['serviceDescription'],
//       serviceType: json['serviceType'],
//       minimumNumberOfGroupMembers: json['minimumNumberOfGroupMembers'],
//       maximumNumberOfGroupMembers: json['maximumNumberOfGroupMembers'],
//       status: json['status'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }
//
// class SavedAnnouncement {
//   final int id;
//   final int userID;
//   final int announcementID;
//   final String createdAt;
//   final String updatedAt;
//   final Announcement announcement;
//
//   SavedAnnouncement({
//     required this.id,
//     required this.userID,
//     required this.announcementID,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.announcement,
//   });
//
//   factory SavedAnnouncement.fromJson(Map<String, dynamic> json) {
//     return SavedAnnouncement(
//       id: json['id'],
//       userID: json['userID'],
//       announcementID: json['announcementID'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       announcement: Announcement.fromJson(json['announcement']),
//     );
//   }
// }
//
//
//////////////////////////////////////////////
// class Announcement {
//   final int id;
//   int? serviceID;
//   final int userID;
//   final String title;
//   final String description;
//   String? createdAt;
//   String? updatedAt;
//   Service? service;
//   bool isSaved;
//   int? savedAnnouncementID;
//
//   Announcement({
//     required this.id,
//     this.serviceID,
//     required this.userID,
//     required this.title,
//     required this.description,
//     this.createdAt,
//     this.updatedAt,
//     this.service,
//     this.isSaved = false,
//     this.savedAnnouncementID,
//   });
//
//   factory Announcement.fromJson(Map<String, dynamic> json) {
//     return Announcement(
//       id: json['id'],
//       serviceID: json['serviceID'] as int?,
//       userID: json['userID'],
//       title: json['title'],
//       description: json['description'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       service: json['service'] != null ? Service.fromJson(json['service']) : null,
//       isSaved: json['isSaved'] ?? false,
//       savedAnnouncementID: json['savedAnnouncementID'] as int?,
//     );
//   }
// }
class Announcement {
  final int id;
  int? serviceID;
  final int userID;
  final String title;
  final String description;
  String? createdAt;
  String? updatedAt;
  Service? service;
  bool isSaved;
  int? savedAnnouncementID;
  List<FileStored>? files;
  Announcement({
    required this.id,
    this.serviceID,
    required this.userID,
    required this.title,
    required this.description,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.isSaved = false,
    this.savedAnnouncementID,
    this.files,
  });

  // factory Announcement.fromJson(Map<String, dynamic> json) {
  //   return Announcement(
  //     id: json['id'],
  //     serviceID: json['serviceID'] as int?,
  //     userID: json['userID'],
  //     title: json['title'] ?? '', // استخدم قيمة افتراضية
  //     description: json['description'] ?? '', // استخدم قيمة افتراضية
  //     createdAt: json['created_at'] ?? '', // تأكد من أن هذه القيم ليست فارغة
  //     updatedAt: json['updated_at'] ?? '', // تأكد من أن هذه القيم ليست فارغة
  //     service: json['service'] != null ? Service.fromJson(json['service']) : null,
  //     isSaved: json['isSaved'] ?? false,
  //     savedAnnouncementID: json['savedAnnouncementID'] as int?,
  //     fileStored: json['fileStored'] != null ? FileStored.fromJson(json['fileStored']) : null,
  //   );
  // }
  factory Announcement.fromJson(Map<String, dynamic> json) {
    print('Creating Announcement from JSON: $json');
    return Announcement(
      id: json['id'],
      serviceID: json['serviceID'] != null ? int.tryParse(json['serviceID'].toString()) : null,
      userID: json['userID'],
      title: json['title'] ?? '', // استخدم قيمة افتراضية
      description: json['description'] ?? '', // استخدم قيمة افتراضية
      createdAt: json['created_at'] ?? '', // تأكد من أن هذه القيم ليست فارغة
      updatedAt: json['updated_at'] ?? '', // تأكد من أن هذه القيم ليست فارغة
      service: json['service'] != null ? Service.fromJson(json['service']) : null,
      isSaved: json['isSaved'] ?? false,
      savedAnnouncementID: json['savedAnnouncementID'] as int?,
      files: json['file'] != null ? (json['file'] as List).map((i) => FileStored.fromJson(i)).toList() : null,
    );
  }


}

class FileStored {
  int? id;
  int? announcementID;
  String fileName;
  String filePath;
  String createdAt;
  String updatedAt;

  FileStored({
    this.id,
    this.announcementID,
    required this.fileName,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileStored.fromJson(Map<String, dynamic> json) {
    return FileStored(
      id: json['id'],
      announcementID: json['announcementID'],
      fileName: json['fileName'] ?? '',
      filePath: json['filePath'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}


class Service {
  final int id;
  final int serviceManagerID;
  final int? parentServiceID;
  final int serviceYearAndSpecializationID;
  final String serviceName;
  final String serviceDescription;
  final String serviceType;
  final int minimumNumberOfGroupMembers;
  final int maximumNumberOfGroupMembers;
  final int status;
  final String createdAt;
  final String updatedAt;

  Service({
    required this.id,
    required this.serviceManagerID,
    this.parentServiceID,
    required this.serviceYearAndSpecializationID,
    required this.serviceName,
    required this.serviceDescription,
    required this.serviceType,
    required this.minimumNumberOfGroupMembers,
    required this.maximumNumberOfGroupMembers,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      serviceManagerID: json['serviceManagerID'],
      parentServiceID: json['parentServiceID'],
      serviceYearAndSpecializationID: json['serviceYearAndSpecializationID'],
      serviceName: json['serviceName'],
      serviceDescription: json['serviceDescription'],
      serviceType: json['serviceType'],
      minimumNumberOfGroupMembers: json['minimumNumberOfGroupMembers'],
      maximumNumberOfGroupMembers: json['maximumNumberOfGroupMembers'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class SavedAnnouncement {
  final int id;
  final int userID;
  final int announcementID;
  final String createdAt;
  final String updatedAt;
  final Announcement announcement;

  SavedAnnouncement({
    required this.id,
    required this.userID,
    required this.announcementID,
    required this.createdAt,
    required this.updatedAt,
    required this.announcement,
  });

  factory SavedAnnouncement.fromJson(Map<String, dynamic> json) {
    return SavedAnnouncement(
      id: json['id'],
      userID: json['userID'],
      announcementID: json['announcementID'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      announcement: Announcement.fromJson(json['announcement']),
    );
  }
}



//اوعك تحذفيه
/*class Announcement {
  final int id;
   int? serviceID;
  final int userID;
  final String title;
  final String description;
   String? createdAt;
   String? updatedAt;
   Service? service;
  bool isSaved;
  int? savedAnnouncementID;

  Announcement({
    required this.id,
    this.serviceID,
    required this.userID,
    required this.title,
    required this.description,
    this.createdAt,
    this.updatedAt,
    this.service,
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
}*/
