
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testme/globals.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String message = 'Scan a code';
  bool isScanningPaused = false;
  bool isDataSent = false;
  List<String> scannedCodes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          _buildQrFrame(),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Center(
              child: Column(
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (isScanningPaused && scannedCodes.length < 3)
                    ElevatedButton(
                      onPressed: _scanAgain,
                      child: Text('Scan Again'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrFrame() {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 4,
                child: Container(
                  color: Colors.red,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                width: 4,
                child: Container(
                  color: Colors.red,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                width: 4,
                child: Container(
                  color: Colors.red,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 4,
                child: Container(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isScanningPaused && !isDataSent) { // Check if scanning is paused and data is not sent
        setState(() {
          result = scanData;
          message = 'Barcode Type: ${result!.format}   Data: ${result!.code}';
          print('Scanned QR Code: ${result!.code}');
          if (!scannedCodes.contains(scanData.code)) {
            scannedCodes.add(scanData.code!);
          }

          if (scannedCodes.length == 3) {
            isDataSent = true; // Mark that data is being sent
            _sendData(scannedCodes.last);
          } else {
            isScanningPaused = true;
            controller.pauseCamera();
          }
        });
      }
    });
  }

  void _scanAgain() {
    setState(() {
      result = null;
      message = 'Scan a code';
      isScanningPaused = false;
    });
    controller?.resumeCamera();
  }

  Future<void> _sendData(String? qrCode) async {
    if (qrCode == null) return;

    // استرجاع الـToken
    String? token = await getUserToken();

    if (token == null) {
      setState(() {
        message = 'User token not found.';
        isDataSent = false; // Reset the flag if token is not found
      });
      return;
    }

    List<String> qrData = qrCode.split('|');
    if (qrData.length != 4) {
      setState(() {
        message = 'Invalid QR code format.';
        isDataSent = false; // Reset the flag if data is invalid
      });
      return;
    }

    String sessionId = qrData[0];
    String password = qrData[1];
    String dateNow = qrData[2];
    String timeNow = qrData[3];

    final response = await http.post(
      Uri.parse('$baseURL/api/attendance/scanQr'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',  // استخدام الـToken في الهيدر
      },
      body: jsonEncode(<String, String>{
        'sessionID': sessionId,
        'password': password,
        'dateNow': dateNow,
        'timeNow': timeNow,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        message = 'Attendance recorded successfully.';
        scannedCodes.clear(); // Clear scanned codes after successful attendance
      });
    } else {
      setState(() {
        message = 'Failed to record attendance: ${response.body}';
        isDataSent = false; // Reset the flag if request failed
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

Future<String?> getUserToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken');
}







