// // import 'dart:async';
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// //
// // class QrCodeScreen extends StatefulWidget {
// //   @override
// //   _QrCodeScreenState createState() => _QrCodeScreenState();
// // }
// //
// // class _QrCodeScreenState extends State<QrCodeScreen> {
// //   String? _base64Image;
// //   Timer? _timer;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchQrCode();
// //   }
// //
// //   Future<void> _fetchQrCode() async {
// //     const int sessionID = 3; // تعيين قيمة sessionID مباشرة هنا
// //     const String baseUrl =
// //         'http://192.168.137.240:8000/api/attendance/showSessionQr';
// //
// //     try {
// //       final response = await http.get(
// //         Uri.parse('$baseUrl/$sessionID'),
// //       );
// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         setState(() {
// //           _base64Image = data['image'];
// //         });
// //
// //         _timer = Timer(Duration(seconds: 10), () {
// //           setState(() {
// //             _base64Image = null;
// //           });
// //         });
// //       } else {
// //         // Handle error
// //         print('Failed to load QR code');
// //       }
// //     } catch (e) {
// //       // Handle error
// //       print('Failed to load QR code');
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     _timer?.cancel();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('QR Code'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             _base64Image == null
// //                 ? Text('QR code not available')
// //                 : Image.memory(base64Decode(_base64Image!)),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: _fetchQrCode,
// //               child: Text('Generate QR Code'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class QrCodeScreen extends StatefulWidget {
//   @override
//   _QrCodeScreenState createState() => _QrCodeScreenState();
// }
//
// class _QrCodeScreenState extends State<QrCodeScreen> {
//   String? _base64Image;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchQrCode();
//   }
//
//   Future<void> _fetchQrCode() async {
//     print("before url");
//     const int sessionID = 14; // تعيين قيمة sessionID مباشرة هنا
//     const String baseUrl =
//         'http://192.168.182.125:8000/api/attendance/showSessionQr';
//     print(baseUrl);
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/$sessionID'),
//       );
//       if (response.statusCode == 200) {
//         print("after url");
//         print(response.statusCode);
//         final data = jsonDecode(response.body);
//         setState(() {
//           _base64Image = data['image'];
//         });
//
//         _timer = Timer(Duration(seconds: 10), () {
//           setState(() {
//             _base64Image = null;
//           });
//         });
//       } else {
//         // Handle error
//         print(response.statusCode);
//         print('Failed to load QR code');
//       }
//     } catch (e) {
//       // Handle error
//       print('Exception occurred: $e');
//       print('Failed to load QR code');
//     }
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('QR Code'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _base64Image == null
//                 ? Text('QR code not available')
//                 : Image.memory(base64Decode(_base64Image!)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _fetchQrCode,
//               child: Text('Generate QR Code'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/session2_model.dart';


class QrCodeView extends StatefulWidget {
  String base64Image;
  final Session session;
  final String baseURL;

  QrCodeView({required this.base64Image, required this.session, required this.baseURL});

  @override
  _QrCodeViewState createState() => _QrCodeViewState();
}

class _QrCodeViewState extends State<QrCodeView> {
  late Uint8List imageBytes;
  bool showQR = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _loadImage();
  }

  void _loadImage() {
    try {
      imageBytes = base64Decode(widget.base64Image);
    } catch (e) {
      imageBytes = Uint8List(0);
    }
  }

  void _startTimer() {
    _timer = Timer(Duration(seconds: 10), () {
      setState(() {
        showQR = false;
      });
    });
  }

  Future<void> _generateNewQrCode() async {
    // استرجاع accessToken من SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');

    // التحقق من وجود accessToken
    if (accessToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Access token is not set')),
      );
      return;
    }

    // إرسال الطلب عبر HTTP GET
    try {
      final response = await http.get(
        Uri.parse('${widget.baseURL}/api/attendance/showSessionQr/${widget.session.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('message')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody['message'])),
          );
        } else if (responseBody.containsKey('image')) {
          setState(() {
            widget.base64Image = responseBody['image'];
            _loadImage();
            showQR = true;
          });
          _startTimer();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected response format')),
          );
        }
      } else {
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request failed with status: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showQR && imageBytes.isNotEmpty
                ? Image.memory(
              imageBytes,
              fit: BoxFit.contain,
            )
                : Text('QR code not available'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateNewQrCode,
              child: Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }
}
