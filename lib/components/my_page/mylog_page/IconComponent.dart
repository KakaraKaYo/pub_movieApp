import 'package:flutter/material.dart';

class PictureIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 60,
      icon: Icon(
        Icons.add_photo_alternate,
        color: Color(0xFF51616F),
        size: 50,
      ),
      onPressed: () {
        print('IconButton pressed ...');
      },
    );
  }
}
