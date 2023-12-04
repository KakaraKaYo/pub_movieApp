import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String title;

  const TextTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        //fontWeight: FontWeight.w600,
        color: Color.fromRGBO(22, 22, 22, 1),
        decoration: TextDecoration.none,
      ),
    );
  }
}
