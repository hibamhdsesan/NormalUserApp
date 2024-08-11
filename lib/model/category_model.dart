class Category {
  final int id;
  final int serviceYear;
  final String serviceSpecializationName;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.serviceYear,
    required this.serviceSpecializationName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      serviceYear: json['serviceYear'],
      serviceSpecializationName: json['serviceSpecializationName'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
