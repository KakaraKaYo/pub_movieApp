import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*
movie-detailページの関連作品の映画画像を構成するWidget
 */



class SimilarMovieImage extends StatelessWidget {
  final int similarMovieId;
  final String? similarMoviePath;

  SimilarMovieImage({required this.similarMovieId, this.similarMoviePath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.push('/movie-details/$similarMovieId');
      },
      child: Container(
        width: 88,
        child: similarMoviePath != null
            ? Image.network(
          'https://image.tmdb.org/t/p/original' + similarMoviePath!,
          fit: BoxFit.cover,
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            return Image.asset(
              'assets/images/your_error_image.png',
              fit: BoxFit.cover,
          );
        },
      )
          : Image.asset(
        'assets/castimage_error.jpeg',
        fit: BoxFit.cover,
      ),
      ),
    );
  }
}
