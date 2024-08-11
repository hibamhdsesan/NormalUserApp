import 'package:flutter/material.dart';

class UserNamesView extends StatelessWidget {
  final int sessionId;
  final List<String> userNames;
  final List<Color> colors = [
    Color(0XFFDFC0D7),
    Color(0XFFDDD9B4),
    Color(0XFFABD8AE),
  ]; // قائمة الألوان المتنوعة

  UserNamesView({required this.sessionId, required this.userNames});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffA6A0AE),
      appBar: AppBar(
        title: Text('Reservations'),
        backgroundColor: Color(0xFF292D3D),
      ),
      body: userNames.isEmpty
          ? Center(
        child: Text(
          'No Reservations Found.',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      )
          : Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 20,
            child: Image(
              width: 200,
              height: 200,
              image: AssetImage('assets/images/girl.png'),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 240),
              Expanded(
                child: ListView.builder(
                  itemCount: userNames.length,
                  itemBuilder: (context, index) {
                    final color = colors[index % colors.length]; // اختيار اللون بناءً على التسلسل
                    return Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color:  Color(0xFF292D3D),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          title: Text(userNames[index]),

                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
