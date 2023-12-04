import 'package:dup_movielist/Page/my_page/mylog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


/*
movie_pageとmy_pageで表示する映画ポースターの一覧を表示するWidget
 */


class ThumbnailList extends ConsumerWidget {
  final String imagePath;
  final int movieId;
  final String nextPageId;
  const ThumbnailList({required this.imagePath, required this.movieId, required this.nextPageId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {

        if (nextPageId == '0') {
          //movie_pageからタップした場合、moviedetail_pageに遷移
          context.go('/movie-details/$movieId');
        } else if (nextPageId == '1') {

          // my_pageからタップした場合、mylog_pageに遷移
          context.go('/mylog/$movieId');
        }

      },

      child: Container(
        width: MediaQuery.of(context).size.width*0.293,
        height: MediaQuery.of(context).size.width*0.293*3/2 ,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }
}

