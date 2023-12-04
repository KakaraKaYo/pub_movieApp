import 'package:flutter/material.dart';

class Picture extends StatelessWidget {
  final String imagePath;

  const Picture({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
