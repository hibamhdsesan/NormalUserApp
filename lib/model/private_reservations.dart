class PrivateReservation {
  final int id;
  final int groupID;
  final List<String> groupMembers;
  final String reservationDate;
  final String reservationStartTime;
  final String reservationEndTime;
  final int privateReservationStatus;

  PrivateReservation({
    required this.id,
    required this.groupID,
    required this.groupMembers,
    required this.reservationDate,
    required this.reservationStartTime,
    required this.reservationEndTime,
    required this.privateReservationStatus,
  });

  factory PrivateReservation.fromJson(Map<String, dynamic> json) {
    return PrivateReservation(
      id: json['privateReservationID'],
      groupID: json['groupID'],
      groupMembers: List<String>.from(json['groupMembers']),
      reservationDate: json['reservationDate'],
      reservationStartTime: json['reservationStartTime'],
      reservationEndTime: json['reservationEndTime'],
      privateReservationStatus: json['privateReservationStatus'],
    );
  }
}
