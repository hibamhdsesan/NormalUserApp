class NormalUserModel {
  String fullName;
  String email;
  int serviceYear;
  String serviceSpecializationName;
  int examinationNumber;
  String studySituation;
  String? skills;
  DateTime? birthDate;

  NormalUserModel({
    required this.fullName,
    required this.email,
    required this.serviceYear,
    required this.serviceSpecializationName,
    required this.examinationNumber,
    required this.studySituation,
    this.skills,
    this.birthDate,
  });


  factory NormalUserModel.fromJson(Map<String, dynamic> json) {
    return NormalUserModel(
      fullName: json['fullName'],
      email: json['email'],
      serviceYear: json['serviceYear'],
      serviceSpecializationName: json['serviceSpecializationName'],
      examinationNumber: json['examinationNumber'],
      studySituation: json['studySituation'],
      skills: json['skills'],
      birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'serviceYear': serviceYear,
      'serviceSpecializationName': serviceSpecializationName,
      'examinationNumber': examinationNumber,
      'studySituation': studySituation,
      'skills': skills,
      'birthDate': birthDate?.toIso8601String(),
    };
  }
}
