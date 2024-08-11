class Session {
  final int sessionID;
  final int serviceID;
  final String parentServiceName;

  Session({
    required this.sessionID,
    required this.serviceID,
    required this.parentServiceName,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionID: json['sessionID'],
      serviceID: json['serviceID'],
      parentServiceName: json['parentServiceName'],
    );
  }
}
