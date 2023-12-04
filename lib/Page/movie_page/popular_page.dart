import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/common/thumbnail_list.dart';
import '../../provider/popular_provider.dart';


/*
映画情報を確認するmovie_pageを構成しているpage
*/

class PopularPage extends ConsumerWidget {
  final ScrollController _scrollController = ScrollController();

  PopularPage({super.key}) {
    _scrollController.addListener(_scrollListener as VoidCallback);
  }

  void _scrollListener() {
    // ここではWidgetRefを直接使用しません
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(movieProvider);

    _scrollController.removeListener(_scrollListener); // 既存のリスナーを削除
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref.read(movieProvider.notifier).fetchNextPage();
      }
    });

    return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),

          //APIで取得した映画のポスターを２０個Wrapで表示
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 7,
              childAspectRatio: (1000) / (1500),

            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              var movie = movies[index];
              return ThumbnailList(
                imagePath: 'https://image.tmdb.org/t/p/original${movie.posterPath}',
                movieId: movie.id,
                nextPageId: "0",
              );
            },
          ),
    );
  }
}
