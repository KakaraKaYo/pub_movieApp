import 'package:dup_movielist/components/movie_page/thumbnail.dart';
import 'package:flutter/material.dart';

class PositionedThumbnail extends StatelessWidget {
  final String posterUrl;

  PositionedThumbnail({required this.posterUrl});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90,
      left: 15, //デバイスによって変わるかも。要検討

      child: Thumbnail(posterUrl: posterUrl,)
    );
  }
}
