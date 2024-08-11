// model/subject_model.dart
class Subject {
  final int id;
  final String serviceName;
  final List<Child> children;

  Subject({
    required this.id,
    required this.serviceName,
    required this.children,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      serviceName: json['serviceName'],
      children: (json['children'] as List).map((i) => Child.fromJson(i)).toList(),
    );
  }
}

class Child {
  final int id;
  final String serviceName;

  Child({
    required this.id,
    required this.serviceName,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      serviceName: json['serviceName'],
    );
  }
}
