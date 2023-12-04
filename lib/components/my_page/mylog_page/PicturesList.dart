import 'package:flutter/material.dart';
import 'PictureItem.dart';
import 'IconComponent.dart';

class PictureList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Container(
        width: 100,
        height: 200,
        decoration: BoxDecoration(),
        child: ListView(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
          scrollDirection: Axis.horizontal,
          children: [
            Picture(imagePath: 'assets/ex-picture1.jpeg'),
            Picture(imagePath: 'assets/ex-picture2.jpeg'),
            Picture(imagePath: 'assets/ex-picture3.jpeg'),
            Picture(imagePath: 'assets/ex-picture4.jpeg'),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: PictureIcon(),
            ),
          ],
        ),
      ),
    );
  }
}
