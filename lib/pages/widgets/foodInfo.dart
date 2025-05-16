import 'package:flutter/material.dart';

class FoodInfo extends StatelessWidget {
  const FoodInfo({
    super.key,
    required this.image,
    required this.value,
  });
  final String image;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          width: 25,
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ],
    );
  }
}
