// import 'package:flutter/foundation.dart';
// import 'package:tired/model/session2_model.dart';
//
// class PrivateSession {
//   final int id;
//   final int sessionID;
//   final String durationForEachReservation;
//   final String createdAt;
//   final String updatedAt;
//   final Session session;
//
//   PrivateSession({
//     required this.id,
//     required this.sessionID,
//     required this.durationForEachReservation,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.session,
//   });
//
//   factory PrivateSession.fromJson(Map<String, dynamic> json) {
//     return PrivateSession(
//       id: json['id'],
//       sessionID: json['sessionID'],
//       durationForEachReservation: json['durationForEachReservation'] ?? '',
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//       session: Session.fromJson(json['session']),
//     );
//   }
// }
//

import 'session2_model.dart';

class PrivateSession {
  final int id;
  final int? sessionID;
  final String durationForEachReservation;
  final String createdAt;
  final String updatedAt;
  final Session? session;

  PrivateSession({
    required this.id,
    this.sessionID,
    required this.durationForEachReservation,
    required this.createdAt,
    required this.updatedAt,
    this.session,
  });

  factory PrivateSession.fromJson(Map<String, dynamic> json) {
    return PrivateSession(
      id: json['id'] ?? 0,
      sessionID: json['sessionID'],
      durationForEachReservation: json['durationForEachReservation'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      session: json['session'] != null ? Session.fromJson(json['session']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sessionID': sessionID,
      'durationForEachReservation': durationForEachReservation,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'session': session?.toJson(), // Convert Session object to JSON if it exists
    };
  }
}
