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
  final List<Service> children; // تأكد من إضافة هذا الحقل

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
    this.children = const [], // تأكد من تهيئة هذا الحقل
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    var childrenJson = json['children'] as List<dynamic>? ?? [];
    var childrenList = childrenJson.map((childJson) => Service.fromJson(childJson)).toList();

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
      children: childrenList,
    );
  }
}
