// class Session {
//   int id;
//   String sessionName;
//   String sessionDescription;
//   String sessionDate; // تم إضافة sessionDate هنا
//   String sessionStartTime;
//   String sessionEndTime;
//   String status;
//
//   Session({
//     required this.id,
//     required this.sessionName,
//     required this.sessionDescription,
//     required this.sessionDate,
//     required this.sessionStartTime,
//     required this.sessionEndTime,
//     required this.status,
//   });
//
//   factory Session.fromJson(Map<String, dynamic> json) {
//     return Session(
//       id: json['id'],
//       sessionName: json['sessionName'],
//       sessionDescription: json['sessionDescription'],
//       sessionDate: json['sessionDate'],
//       sessionStartTime: json['sessionStartTime'],
//       sessionEndTime: json['sessionEndTime'],
//       status: json['status'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'sessionName': sessionName,
//       'sessionDescription': sessionDescription,
//       'sessionDate': sessionDate,
//       'sessionStartTime': sessionStartTime,
//       'sessionEndTime': sessionEndTime,
//       'status': status,
//     };
//   }
// }
/*class Session {
  int id;
  int userID;
  int serviceID;
  String sessionName;
  String sessionDescription;
  String sessionDate;
  String sessionStartTime;
  String sessionEndTime;
  String status;

  Session({
    required this.id,
    required this.userID,
    required this.serviceID,
    required this.sessionName,
    required this.sessionDescription,
    required this.sessionDate,
    required this.sessionStartTime,
    required this.sessionEndTime,
    required this.status,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      userID: json['userID'],
      serviceID: json['serviceID'],
      sessionName: json['sessionName'] ?? '',
      sessionDescription: json['sessionDescription'] ?? '',
      sessionDate: json['sessionDate'] ?? '',
      sessionStartTime: json['sessionStartTime'] ?? '',
      sessionEndTime: json['sessionEndTime'] ?? '',
      status: json['status'] ?? '',
    );
  }
}*/
class Session {
  int id;
  int userID;
  int serviceID;
  String sessionName;
  String sessionDescription;
  String sessionDate;
  String sessionStartTime;
  String sessionEndTime;
  String status;

  Session({
    required this.id,
    required this.userID,
    required this.serviceID,
    required this.sessionName,
    required this.sessionDescription,
    required this.sessionDate,
    required this.sessionStartTime,
    required this.sessionEndTime,
    required this.status,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] ?? 0,
      userID: json['userID'] ?? 0,
      serviceID: json['serviceID'] ?? 0,
      sessionName: json['sessionName'] ?? '',
      sessionDescription: json['sessionDescription'] ?? '',
      sessionDate: json['sessionDate'] ?? '',
      sessionStartTime: json['sessionStartTime'] ?? '',
      sessionEndTime: json['sessionEndTime'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'serviceID': serviceID,
      'sessionName': sessionName,
      'sessionDescription': sessionDescription,
      'sessionDate': sessionDate,
      'sessionStartTime': sessionStartTime,
      'sessionEndTime': sessionEndTime,
      'status': status,
    };
  }
}
