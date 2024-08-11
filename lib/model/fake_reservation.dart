class FakeReservation {
  final int id;
  final int privateSessionID;
  final String reservationStartTime;
  final String reservationEndTime;
  final String createdAt;
  final String updatedAt;

  FakeReservation({
    required this.id,
    required this.privateSessionID,
    required this.reservationStartTime,
    required this.reservationEndTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FakeReservation.fromJson(Map<String, dynamic> json) {
    return FakeReservation(
      id: json['id'],
      privateSessionID: json['privateSessionID'],
      reservationStartTime: json['reservationStartTime'],
      reservationEndTime: json['reservationEndTime'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
