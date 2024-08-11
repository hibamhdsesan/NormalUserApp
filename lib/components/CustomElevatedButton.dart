import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;

  CustomElevatedButton({
    required this.color,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0, backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'Inter',
            height: 29 / 24,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
