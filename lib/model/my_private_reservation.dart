class MyPrivateReservation {
  final int reservationID;
  final String reservationDate;
  final String reservationStartTime;
  final String reservationEndTime;
  final int privateReservationStatus;
  final String serviceName;

  MyPrivateReservation({
    required this.reservationID,
    required this.reservationDate,
    required this.reservationStartTime,
    required this.reservationEndTime,
    required this.privateReservationStatus,
    required this.serviceName,
  });

  factory MyPrivateReservation.fromJson(Map<String, dynamic> json) {
    return MyPrivateReservation(
      reservationID: json['reservationID'],
      reservationDate: json['reservationDate'],
      reservationStartTime: json['reservationStartTime'],
      reservationEndTime: json['reservationEndTime'],
      privateReservationStatus: json['privateReservationStatus'],
      serviceName: json['serviceName'],
    );
  }
}
