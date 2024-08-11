import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/announcment_model.dart';


class AnnouncementService {

  Future<List<Announcement>> fetchAnnouncements() async {
    final String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjYzZTY4YjgwNDIwOWU0ZGY2NTViNzQzODY5YzNhM2RhYjM2ZjI3N2NhNmRlOGY5MGExYjZjNjA0YjRlZWM1M2MwOWQ3YzFhMmIzZDU4OTQiLCJpYXQiOjE3MTYxMTM0MDUuMDYyMDI1LCJuYmYiOjE3MTYxMTM0MDUuMDYyMDI5LCJleHAiOjE3NDc2NDk0MDUuMDU0MjQ5LCJzdWIiOiIzMCIsInNjb3BlcyI6W119.d1UlsCrmAiliEEFSDLM86U_k9yqt_gkavH6jhITLDw40b80DqVVfegivFRfaJZs5J6brJFZCjthlhwwl5rKKxX1R8ZYm8waYUjU2IOuJvUh1aPLmqVp_qrFp2NJbey-Cc7zfwqFRnlnMY_qA6EzCFrhMv4smxTOZsrwJlNqMratbqJ6p-PhN8PX6h-NKVq2HnhN5GnaN0DPhnGAM0bAVHr2DZ2DHoWZDdLAGEGDLHqA3jVcQ69rnfzn2WIQ5-KsIF6DPL1NknT46pn3On3L36yaAIK9aFdrj1ybI2_JC12if6erOwziQfmHvaJwRc8ZNwdomRA_3AJY_zFMThOUWqIvZG9cOKlB7rJbwTV8XFtbRUfoAMElw_B4fK-rjlxqHzUrywfWPdkw6C2kJ8z6dHQPiptKIZxwV1jysXqtgvp7P2HNduBLd5R-xtIH3Maei-TdVww8nPZnYslqAon26MSRnXqxYnFatk__2bCNqBS6lxOTJvUiaeF_ZGqFeHR2PnQnZlURmmWKOVBhJ03tZ7qx-dnXpF9ycWv1HRQXWcEKdy3fu8_qpNaz_GnZuXLcLgqqjZB38nQzoXBtpskPUuiUBUadBntx9N_LT4WDkzE41bl8NiodJtQkYaWLP96t_UM3NTcoEi624kUV9JeREbufmPF5QHCOAM-xcvfpT0kM";
    final response = await http.get(Uri.parse('http://192.168.137.226:8000/api/announcement/showAll/'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
    print('i am in');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Announcement.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load announcements');
    }
  }


  Future<void> addAnnouncement(Announcement announcement) async {
    final String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjYzZTY4YjgwNDIwOWU0ZGY2NTViNzQzODY5YzNhM2RhYjM2ZjI3N2NhNmRlOGY5MGExYjZjNjA0YjRlZWM1M2MwOWQ3YzFhMmIzZDU4OTQiLCJpYXQiOjE3MTYxMTM0MDUuMDYyMDI1LCJuYmYiOjE3MTYxMTM0MDUuMDYyMDI5LCJleHAiOjE3NDc2NDk0MDUuMDU0MjQ5LCJzdWIiOiIzMCIsInNjb3BlcyI6W119.d1UlsCrmAiliEEFSDLM86U_k9yqt_gkavH6jhITLDw40b80DqVVfegivFRfaJZs5J6brJFZCjthlhwwl5rKKxX1R8ZYm8waYUjU2IOuJvUh1aPLmqVp_qrFp2NJbey-Cc7zfwqFRnlnMY_qA6EzCFrhMv4smxTOZsrwJlNqMratbqJ6p-PhN8PX6h-NKVq2HnhN5GnaN0DPhnGAM0bAVHr2DZ2DHoWZDdLAGEGDLHqA3jVcQ69rnfzn2WIQ5-KsIF6DPL1NknT46pn3On3L36yaAIK9aFdrj1ybI2_JC12if6erOwziQfmHvaJwRc8ZNwdomRA_3AJY_zFMThOUWqIvZG9cOKlB7rJbwTV8XFtbRUfoAMElw_B4fK-rjlxqHzUrywfWPdkw6C2kJ8z6dHQPiptKIZxwV1jysXqtgvp7P2HNduBLd5R-xtIH3Maei-TdVww8nPZnYslqAon26MSRnXqxYnFatk__2bCNqBS6lxOTJvUiaeF_ZGqFeHR2PnQnZlURmmWKOVBhJ03tZ7qx-dnXpF9ycWv1HRQXWcEKdy3fu8_qpNaz_GnZuXLcLgqqjZB38nQzoXBtpskPUuiUBUadBntx9N_LT4WDkzE41bl8NiodJtQkYaWLP96t_UM3NTcoEi624kUV9JeREbufmPF5QHCOAM-xcvfpT0kM";
    final response = await http.post(
      Uri.parse('http://192.168.137.216:8000/api/announcement/add/'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'serviceID': announcement.serviceID,
        'title': announcement.title,
        'description': announcement.description,
        'userID': announcement.userID,
      }),
    );
print('i am in');
    if (response.statusCode != 200) {
      throw Exception('Failed to add announcement');
    }
  }
}
