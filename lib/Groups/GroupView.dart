// view/groups_view.dart
import 'package:flutter/material.dart';

import 'GroupController.dart';
import 'GroupModel.dart';

class GroupsView extends StatefulWidget {
  @override
  _GroupsViewState createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  late Future<List<Group>> futureGroups;
  final int serviceId = 123; // يمكن تعديل هذا الرقم وفقاً لاحتياجاتك

  @override
  void initState() {
    super.initState();
    futureGroups = GroupController().fetchGroups(serviceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groups'),
      ),
      body: FutureBuilder<List<Group>>(
        future: futureGroups,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No groups found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final group = snapshot.data![index];

              return Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: group.members.map((member) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(member.name),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
