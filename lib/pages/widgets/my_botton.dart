import 'package:flutter/material.dart';

class MyBotton extends StatelessWidget {
  const MyBotton({
    super.key,
    required this.onTap,
    required this.bottonText,
    this.color = Colors.blueAccent,
  });

  final VoidCallback onTap;
  final String bottonText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onTap,
      child: Text(
        bottonText,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
