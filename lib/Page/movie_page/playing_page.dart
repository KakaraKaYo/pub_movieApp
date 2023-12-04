import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/common/thumbnail_list.dart';
import '../../provider/now_playing_provider.dart';

final scrollControllerProvider = StateProvider<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

class PlayingPage extends ConsumerWidget {
  PlayingPage({super.key});

  void _scrollListener(ScrollController controller, WidgetRef ref) {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      // スクロールが最下部に達した場合の処理
      ref.read(movieProvider.notifier).fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(movieProvider);
    final _scrollController = ref.watch(scrollControllerProvider);

    // リスナーを追加
    _scrollController.removeListener(() => _scrollListener(_scrollController, ref));
    _scrollController.addListener(() => _scrollListener(_scrollController, ref));

    // SingleChildScrollViewでラップしてNestedScrollViewと連携
    return SingleChildScrollView(
      controller: _scrollController, // SingleChildScrollViewでスクロール制御
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 10),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // GridView内でのスクロール無効化
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
      ),
    );
  }
}
