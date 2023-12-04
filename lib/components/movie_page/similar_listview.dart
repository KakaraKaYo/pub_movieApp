import 'package:dup_movielist/components/movie_page/similar_movie_image.dart';
import 'package:flutter/material.dart';
import 'cast_image.dart';

class SimilarListView extends StatelessWidget {
  final List<dynamic> similarMovies;
  const SimilarListView({required this.similarMovies,});

  @override
  Widget build(BuildContext context) {

    // 映画のIDのリストを作成
    List<int> similarMovieIds = similarMovies.map((movie) => movie['id'] as int).toList();

    List<String?> moviePosterPaths = similarMovies.map((movie) => movie['poster_path'] as String?).where((path) => path != null).toList();

    // 表示するアイテムの数を決定
   // int displayCount = movieIds.length > 20 ? 20 : movieIds.length;

    print("SIMILAR MOVIES:${similarMovies}");
    print('SMILAR IDs:${similarMovieIds}');
    print('POSTER_PSTH: ${moviePosterPaths}');

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          const SizedBox(height: 40),
          const Text("関連作品", style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
          const SizedBox(height:5),
          SizedBox(
            height: 136,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: similarMovieIds.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: SimilarMovieImage(
                  similarMovieId: similarMovieIds[index],
                  similarMoviePath: moviePosterPaths[index],
                ),),
            ),
          ),
        ]
    );
  }
}
