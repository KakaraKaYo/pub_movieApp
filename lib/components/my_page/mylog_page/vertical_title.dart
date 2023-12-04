import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class VerticalTitle extends StatelessWidget {
  final String text;
  final String originTitle;
  final String formattedDate;
  final int runtime;
  final String genresText;


  VerticalTitle({required this.text, required this.originTitle,required this. formattedDate, required this.runtime,required this.genresText});

  @override
  Widget build(BuildContext context) {


    // テキストの長さに基づいてフォントサイズと行数を設定
    int maxLines = text.length < 15 ? 1 : 2;
    double fontSize = text.length < 15 ? 36 : 18;

    return RotatedBox(
      quarterTurns: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            text,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700),
            maxLines: maxLines,
            minFontSize: 12,
            overflow: TextOverflow.visible,
          ),
          //SizedBox(height: 5),
          AutoSizeText(
            originTitle,
            style: TextStyle(fontSize: 16),
            maxLines: 2,
            minFontSize: 12,
            overflow: TextOverflow.visible,
          ),
          //SizedBox(height: 5),
          Text("${formattedDate}上映,${runtime}分,${genresText}", style: TextStyle(fontSize: 12),),

        ],
      ),
    );
  }
}
