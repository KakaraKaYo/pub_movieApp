import 'package:flutter/material.dart';

class BackImage extends StatelessWidget {
  final String imagePath;

  BackImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: Container(
        width: MediaQuery.of(context).size.width, // 画面全体の幅
        child: AspectRatio(
          aspectRatio: 375 / 211, // ここでアスペクト比を調整します。1:1の比率を設定しています
          child: Image.network(
            imagePath,
          ),
        ),
      ),
    );
  }
}
