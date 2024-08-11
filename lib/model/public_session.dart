// import 'package:tired/model/session2_model.dart';
//
// class PublicSession {
//   int id;
//   int sessionID;
//   int maximumNumberOfReservations;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Session session;
//
//   PublicSession({
//     required this.id,
//     required this.sessionID,
//     required this.maximumNumberOfReservations,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.session,
//   });
//
//   factory PublicSession.fromJson(Map<String, dynamic> json) {
//     return PublicSession(
//       id: json['id'],
//       sessionID: json['sessionID'],
//       maximumNumberOfReservations: json['MaximumNumberOfReservations'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       session: Session.fromJson(json['session']),
//     );
//   }
// }
/*import 'package:tired/model/session2_model.dart';

class PublicSession {
  final int sessionID;
  final Session session;
  final int maximumNumberOfReservations;
  bool isReserved; // حقل للتحقق من الحجز

  PublicSession({
    required this.sessionID,
    required this.session,
    required this.maximumNumberOfReservations,
    this.isReserved = false, // القيمة الافتراضية غير محجوزة
  });

  factory PublicSession.fromJson(Map<String, dynamic> json) {
    return PublicSession(
      sessionID: json['sessionID'],
      session: Session.fromJson(json['session']),
      maximumNumberOfReservations: json['MaximumNumberOfReservations'],
      isReserved: json['isReserved'] ?? false,
    );
  }
}*/
import 'package:shared_preferences/shared_preferences.dart';

import 'session2_model.dart';

class PublicSession {
  final int id;
  final int sessionID;
  final int maximumNumberOfReservations;
  bool isReserved; // حقل للتحقق من الحجز
  final String createdAt;
  final String updatedAt;
  final Session session;

  PublicSession({
    required this.id,
    required this.sessionID,
    required this.maximumNumberOfReservations,
    this.isReserved = false, // القيمة الافتراضية غير محجوزة
    required this.createdAt,
    required this.updatedAt,
    required this.session,
  });

  factory PublicSession.fromJson(Map<String, dynamic> json) {
    return PublicSession(
      id: json['id'],
      sessionID: json['sessionID'],
      maximumNumberOfReservations: json['MaximumNumberOfReservations'],
      isReserved: json['isReserved'] ?? false,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      session: Session.fromJson(json['session']),
    );
  }

  // وظيفة لاسترجاع حالة الحجز من SharedPreferences
  static Future<bool> isSessionReserved(int sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isReserved_$sessionId') ?? false;
  }

  // وظيفة لتخزين حالة الحجز في SharedPreferences
  static Future<void> setSessionReserved(int sessionId, bool isReserved) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isReserved_$sessionId', isReserved);
  }
}
