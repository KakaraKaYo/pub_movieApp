import 'package:flutter/material.dart';

class SortListMaterial extends StatelessWidget {
  final String text;
  final bool isSelected;

  SortListMaterial({required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
            text,
          style:const TextStyle(
            fontSize: 24,
            fontFamily: 'Notosans',
          ),)),
    );
  }
}

