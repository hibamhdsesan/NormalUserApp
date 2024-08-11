class SwapRequest {
  final int swapRequestID;
  final String serviceName;
  final ReservationDetails? senderReservation; // السماح بالقيمة الفارغة
  final ReservationDetails? receiverReservation; // السماح بالقيمة الفارغة
  final String status;

  SwapRequest({
    required this.swapRequestID,
    required this.serviceName,
    this.senderReservation,
    this.receiverReservation,
    required this.status,
  });

  factory SwapRequest.fromJson(Map<String, dynamic> json) {
    return SwapRequest(
      swapRequestID: json['swapRequestID'],
      serviceName: json['serviceName'],
      senderReservation: json['senderReservation'] != null
          ? ReservationDetails.fromJson(json['senderReservation'])
          : null,
      receiverReservation: json['receiverReservation'] != null
          ? ReservationDetails.fromJson(json['receiverReservation'])
          : null,
      status: json['status'],
    );
  }
}

class ReservationDetails {
  final int id;
  final String reservationDate;
  final String reservationStartTime;
  final String reservationEndTime;

  ReservationDetails({
    required this.id,
    required this.reservationDate,
    required this.reservationStartTime,
    required this.reservationEndTime,
  });

  factory ReservationDetails.fromJson(Map<String, dynamic> json) {
    return ReservationDetails(
      id: json['id'],
      reservationDate: json['reservationDate'],
      reservationStartTime: json['reservationStartTime'],
      reservationEndTime: json['reservationEndTime'],
    );
  }
}
