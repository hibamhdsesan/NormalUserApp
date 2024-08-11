class Group {
  final int id;
  final List<Member> members;

  Group({required this.id, required this.members});

  factory Group.fromJson(Map<String, dynamic> json) {
    var membersFromJson = json['members'] as List;
    List<Member> membersList = membersFromJson.map((i) => Member.fromJson(i)).toList();

    return Group(
      id: json['group_id'],
      members: membersList,
    );
  }
}

class Member {
  final int id;
  final String name;

  Member({required this.id, required this.name});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['normalUserID'],
      name: json['memberName'],
    );
  }
}
