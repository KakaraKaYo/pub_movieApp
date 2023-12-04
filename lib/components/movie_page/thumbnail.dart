import 'package:flutter/material.dart';

class Thumbnail extends StatelessWidget {
  final String posterUrl;

  Thumbnail({required this.posterUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: Card(
        elevation: 4.0, // カードの影の深さを調整
        color: Colors.transparent,
        child: SizedBox(
          //height: 200,
          //width: 130,
          width: MediaQuery.of(context).size.height * 0.16,
          height: MediaQuery.of(context).size.height * 0.24, //0.18*1.5
          child: Image.network(
            posterUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
